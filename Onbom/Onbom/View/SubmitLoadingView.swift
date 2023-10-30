//
//  SubmitLoadingView.swift
//  Onbom
//
//  Created by 금가경 on 2023/10/23.
//

import SwiftUI

struct SubmitLoadingView: View {
    private enum SubmitLoadingViewState {
        case loading
        case fail
    }
    @State private var isSubmitViewPresented = false
    @State private var err: String?
    @State private var state: SubmitLoadingViewState = .loading
    private let firebaseStorageManager: FirebaseStorageManager = .shared
    @EnvironmentObject var pdfManager: PDFManager
    
    var body: some View {
        if(self.state == .loading) {
            VStack {
                Text("국민건강보험공단에 보내고 있어요")
                    .H2()
                    .foregroundColor(.B)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.bottom, 162)
                    .padding(.top, 45)
                Image("SubmitLoadingView")
                
                Spacer()
            }
            .navigationDestination(isPresented: $isSubmitViewPresented, destination: {
                SubmitView()
            })
            .navigationBarBackButtonHidden(true)
            .padding(20.0)
            .onAppear{ initialize() }
        }
        else if (self.state == .fail) {
            Text(self.err ?? "에러")
                .navigationBarBackButton()
        }
    }
    
    private func initialize() {
        Task {
            do {
                let pdf = try pdfManager.getLastPdf()
                try await firebaseStorageManager.upload(pdf) { [self] error in
                    if let error = error as? FirebaseStorageError {
                        self.err = error.rawValue
                        self.state = .fail
                    }
                    else if let error = error {
                        self.err = error.localizedDescription
                        self.state = .fail
                    } else {
                        self.isSubmitViewPresented = true
                    }
                    
                }
            } catch let error as PDFError {
                self.err = error.rawValue
            }
            catch let error {
                print(error.localizedDescription)
                self.err = "죄송합니다. 다시 시도해주세요"
            }
        }
    }
}



struct SubmitLoadingView_Previews: PreviewProvider {
    static var previews: some View {
        SubmitLoadingView()
    }
}
