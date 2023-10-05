//
//  MainView.swift
//  Onbom
//
//  Created by moon on 2023/10/03.
//

import SwiftUI
import FirebaseAuth

struct MainView: View {
	@EnvironmentObject var authViewModel: AuthenticationViewModel
	
	var body: some View {
		if authViewModel.state == .signedIn {
			VStack{
				Text("Hello, World!")
				Button("로그아웃"){
					authViewModel.signOutFirebase()
				}
			}
		}
		else {
			LoginView()
		}
	}
}

struct MainView_Previews: PreviewProvider {
	static var previews: some View {
		MainView()
	}
}
