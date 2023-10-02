//
//  TempPDFView.swift
//  Onbom
//
//  Created by Sebin Kwon on 2023/10/02.
//

import SwiftUI

struct TempPDFView: View {
    @EnvironmentObject var pdfManager: PDFManager
    
    var body: some View {
        NavigationStack {
            VStack {
                NavigationLink {
                    TempWriteFormView()
                } label: {
                    Text("신청서 작성하기")
                }
                ForEach(Array(pdfManager.PDFDatas.enumerated()), id:\.1) { index, pdfdata in
                    NavigationLink {
                        PDFViewer(pdfData: pdfdata)
                    } label: {
                        Text("PDF 보기 \(index)")
                    }.padding()
                }
                Text("신청한 수 : \(pdfManager.PDFDatas.count)")
                    .padding()
                NavigationLink {
                    PDFViewer()
                } label: {
                    Text("PDF 원본")
                }.padding()
            }
        }
    }
}

struct TempPDFView_Previews: PreviewProvider {
    static var previews: some View {
        TempPDFView()
            .environmentObject(PDFManager())
    }
}
