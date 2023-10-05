//
//  LoginView.swift
//  Onbom
//
//  Created by moon on 2023/09/24.
//

import SwiftUI
import _AuthenticationServices_SwiftUI
import FirebaseAuth

struct LoginView: View {
  @EnvironmentObject var authViewModel: AuthenticationViewModel
  
  var body: some View {
    VStack{
      SignInWithAppleButton{ request in
        authViewModel.handleSignInWithAppleRequest(request)
      } onCompletion: { result in
        authViewModel.handleSignInWithAppleCompletion(result)
      }
      .signInWithAppleButtonStyle(.black)
      .frame(maxWidth: .infinity, maxHeight: 50)
      .cornerRadius(8)
      .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
      
      Button {
        authViewModel.handleSignInWithKakaoLogin()
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
