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
	
	// MARK: 카카오톡 로그인 기능 관련
	func handleSignInWithKakaoLogin() {
		if UserApi.isKakaoTalkLoginAvailable() {
			kakaoLoginInApp() // 카카오톡 앱이 있다면 앱으로 로그인
		} else {
			kakaoLoginInWeb() // 앱이 없다면 웹으로 로그인 (애뮬레이터)
		}
	}
	
	private func kakaoLoginInApp() {
		UserApi.shared.loginWithKakaoTalk { oauthToken, error in
			if let error = error {
				self.errorMessage = "카카오톡에 로그인하는데 실패했습니다. \(error.localizedDescription)"
				return
			}
			self.loginInFirebaseWithEmail()
		}
	}
	private func kakaoLoginInWeb() {
		UserApi.shared.loginWithKakaoAccount { oauthToken, error in
			if let error = error {
				self.errorMessage = "카카오톡에 로그인하는데 실패했습니다. \(error.localizedDescription)"
				return
			}
			self.loginInFirebaseWithEmail()
		}
	}
	
	private func loginInFirebaseWithEmail() {
		UserApi.shared.me { kakaoUser, error in
			if let error = error {
				self.errorMessage = "카카오에서 유저정보를 불러오는데 실패했습니다. \(error.localizedDescription)"
				return
			}
			guard let email = kakaoUser?.kakaoAccount?.email else { return }
			guard let password = kakaoUser?.id else { return }
			guard let userName = kakaoUser?.kakaoAccount?.profile?.nickname else { return }
			
			self.emailAuthSignUp(email: email, userName: userName, password: "\(password)")
			self.emailAuthSignIn(email: email, password: "\(password)")
		}
	}
		
	private func emailAuthSignUp(email: String, userName: String, password: String) {
		Auth.auth().createUser(withEmail: email, password: password) { result, error in
			if let error = error {
				self.errorMessage = "파이어베이스에 회원가입하는데 실패했습니다. \(error.localizedDescription)"
				return
			}
			if result != nil {
				let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
				changeRequest?.displayName = userName
			}
		}
	}

	private func emailAuthSignIn(email: String, password: String) {
		Auth.auth().signIn(withEmail: email, password: password) { result, error in
			if let error = error {
				self.errorMessage = "파이어베이스에 로그인하는데 실패했습니다. error: \(error.localizedDescription)"
				return
			}
			
			if result == nil {
				self.errorMessage = "Fail to find firebase user info."
				return
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
