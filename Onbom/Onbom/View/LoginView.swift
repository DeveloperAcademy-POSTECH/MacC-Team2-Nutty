//
//  LoginView.swift
//  Onbom
//
//  Created by moon on 2023/09/24.
//

import SwiftUI
import _AuthenticationServices_SwiftUI

struct LoginView: View {
    let viewModel = AuthenticationViewModel()
    
    var body: some View {
        VStack{
            SignInWithAppleButton{ request in
                viewModel.handleSignInWithAppleRequest(request)
            } onCompletion: { result in
                viewModel.handleSignInWithAppleCompletion(result)
            }
            .signInWithAppleButtonStyle(.black)
            .frame(maxWidth: .infinity, maxHeight: 50)
            .cornerRadius(8)
            .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
            
            Button {
                viewModel.handleSignInWithKakaoLogin()
            } label: {
                Image("kakao_login_medium_wide")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
            .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
            
        }
    }
}

#Preview {
    LoginView()
}
