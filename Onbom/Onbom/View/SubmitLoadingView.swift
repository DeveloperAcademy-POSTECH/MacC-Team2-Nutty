//
//  SubmitLoadingView.swift
//  Onbom
//
//  Created by 금가경 on 2023/10/23.
//

import SwiftUI

struct SubmitLoadingView: View {
    @State private var isSubmitViewPresented = false
    @State private var isFailed = false
    @State private var err: String = ""
    private let firebaseStorageManager: FirebaseStorageManager = .shared
    @EnvironmentObject var pdfManager: PDFManager
    
    var body: some View {
        if(isFailed) {
            Text(err)
                .navigationBarBackButton()
        }
        else {
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
            .onAppear() {
                Task {
                    do {
                        let pdf = try pdfManager.getLastPdf()
                        try await firebaseStorageManager.upload(pdf)
                        DispatchQueue.main.async {
                            self.isSubmitViewPresented = true
                        }
                    } catch let error as FirebaseStorageError {
                        DispatchQueue.main.async {
                            self.err = error.rawValue
                            self.isFailed = true
                        }
                    } catch let error as PDFError {
                        DispatchQueue.main.async {
                            self.err = error.rawValue
                            self.isFailed = true
                        }
                    }
                    catch {
                        DispatchQueue.main.async {
                            self.err = "죄송합니다. 다시 시도해주세요"
                            self.isFailed = true
                        }
                    }
                }
            }
        }
    }
}



struct SubmitLoadingView_Previews: PreviewProvider {
    static var previews: some View {
        SubmitLoadingView()
    }
}
