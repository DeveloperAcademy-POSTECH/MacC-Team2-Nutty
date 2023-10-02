//
//  AuthenticationViewModel.swift
//  Onbom
//
//  Created by moon on 2023/09/24.
//

import AuthenticationServices
import FirebaseAuth
import KakaoSDKUser
import CryptoKit

class AuthenticationViewModel {
    func handleSignInWithKakaoLogin() {
        UserApi.shared.loginWithKakaoTalk { oauthToken, error in
            if let error = error {
                print(error)
                return
            }
            print("loginWithKakaoTalk() success.")
        }
    }
    func signOut() {
        do {
            try Auth.auth().signOut()
        }
        catch {
            print(error)
            errorMessage = error.localizedDescription
        }
    }
    func deleteAccount() async -> Bool {
        do {
            try await Auth.auth().currentUser?.delete()
            return true
        }
        catch {
            errorMessage = error.localizedDescription
            return false
        }
    }
    
	private var currentNonce: String?
	private var _errorMessage: String?
		
	private var errorMessage: String? {
		get {
			return _errorMessage
		}
		set(newValue) {
			print(newValue ?? "")
			_errorMessage = newValue
		}
	}
	
	// MARK: 애플 로그인 기능 관련
	func handleSignInWithAppleRequest(_ request: ASAuthorizationAppleIDRequest) {
		request.requestedScopes = [.fullName, .email]
		let nonce = randomNonceString()
		currentNonce = nonce
		request.nonce = sha256(nonce)
	}
	func handleSignInWithAppleCompletion(_ result: Result<ASAuthorization, Error>) {
		if case .failure(let failure) = result {
			errorMessage = failure.localizedDescription
			return
		}
		else if case .success(let success) = result {
			if let appleIdCredential = success.credential as? ASAuthorizationAppleIDCredential {
				guard let nonce = currentNonce else {
					fatalError("유효하지 않습니다: 로그인 콜백을 받았지만, 로그인 요청을 받지 않았습니다.")
				}
				guard let appleIDToken = appleIdCredential.identityToken else {
					errorMessage = "appleIDToken을 불러오는데 실패했습니다."
					return
				}
				guard let idTokenString = String(data: appleIDToken, encoding: .utf8) else {
					errorMessage = "appleIDToken을 문자열로 변환하는데 실패했습니다. data: \(appleIDToken.debugDescription)"
					return
				}
				let credential = OAuthProvider.credential(withProviderID: "apple.com",
														  idToken: idTokenString,
														  rawNonce: nonce)
				
				Task {
					do {
						try await Auth.auth().signIn(with: credential)
					}
					catch {
						print("Error authentication: \(error.localizedDescription)")
					}
				}
			}
		}
	}
	
	// MARK: 유틸리티
	private func randomNonceString(length: Int = 32) -> String {
		precondition(length > 0)
		var randomBytes = [UInt8](repeating: 0, count: length)
		let errorCode = SecRandomCopyBytes(kSecRandomDefault, randomBytes.count, &randomBytes)
		if errorCode != errSecSuccess {
			fatalError(
				"Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)"
			)
		}
		
		let charset: [Character] =
		Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
		
		let nonce = randomBytes.map { byte in
			// Pick a random character from the set, wrapping around if needed.
			charset[Int(byte) % charset.count]
		}
		
		return String(nonce)
	}
	private func sha256(_ input: String) -> String {
		let inputData = Data(input.utf8)
		let hashedData = SHA256.hash(data: inputData)
		let hashString = hashedData.compactMap {
			String(format: "%02x", $0)
		}.joined()
		
		return hashString
	}
	
}
