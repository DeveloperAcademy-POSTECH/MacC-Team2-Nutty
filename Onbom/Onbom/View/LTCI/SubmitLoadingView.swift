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
    @State private var err: String?
    @State private var state: SubmitLoadingViewState = .loading
    @Binding var presented: Bool
    private let firebaseStorageManager: FirebaseStorageManager = .shared
    private let pdfManager: PDFManager = .shared
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        if state == .loading {
            VStack {
                Text("국민건강보험공단에\n신청 서류를 보내고 있어요")
                    .H1()
                    .foregroundColor(.B)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.bottom, 100)
                    .padding(.top, 45)
                Image("SubmitLoadingView")
                
                Spacer()
            }
            .navigationBarBackButtonHidden(true)
            .padding(20.0)
            .onAppear {
                initialize()
            }
        }
        else {
            NavigationStack {
                Text(self.err ?? "죄송합니다 다시 시도해주세요")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(.gray.opacity(0.2))
                    .toolbar {
                        ToolbarItem(placement: .navigationBarLeading) {
                            HStack() {
                                Text("")
                                Image("chevronLeft")
                                    .aspectRatio(contentMode: .fit)
                                    .onTapGesture {
                                        dismiss()
                                    }
                            }
                        }
                    }
            }
        }
    }
    
    private func initialize() {
        Task {
            do {
                let pdf = try pdfManager.getLastPdf()
                await firebaseStorageManager.upload(pdf) { [self] error in
                    if let error = error as? FirebaseStorageError {
                        self.err = error.rawValue
                        self.state = .fail
                    }
                    else if let error = error {
                        self.err = error.localizedDescription
                        self.state = .fail
                    }
                }
                self.presented = false // TODO: firebase 에러가 발생해도 다음화면으로 넘어가지 않아야한다
            } catch let error as PDFError {
                self.err = error.rawValue
                self.state = .fail
            }
            catch let error {
                print(error.localizedDescription)
                self.err = "죄송합니다 다시 시도해주세요"
                self.state = .fail
            }
        }
    }
}



struct SubmitLoadingView_Previews: PreviewProvider {
    static var previews: some View {
        SubmitLoadingView(presented: .constant(false))
    }
}
