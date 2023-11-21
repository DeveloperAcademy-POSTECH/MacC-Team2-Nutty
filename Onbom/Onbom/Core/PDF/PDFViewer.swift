//
//  PDFViewer.swift
//  Onbom
//
//  Created by Sebin Kwon on 2023/09/26.
//

import SwiftUI
import PDFKit

struct PDFViewer: UIViewRepresentable {
    var pdfData: Data?
    @Binding var pageIndex: Int
    func makeUIView(context: Context) -> some UIView {
        let pdfView = PDFView()
        return pdfView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        if let pdfView = uiView as? PDFView {
            setupPDFView(pdfView)
        }
    }
    
    private func setupPDFView(_ pdfView: PDFView) {
        if let pdfData {
            pdfView.document = PDFDocument(data: pdfData)
        } else {
            pdfView.document = PDFDocument(url: LTCIFormResource)
        }
        if let page = pdfView.document?.page(at: pageIndex) {
            pdfView.go(to: page)
        }
        pdfView.displayMode = .singlePage
        pdfView.backgroundColor = UIColor(Color(.black).opacity(0.5))
        pdfView.autoScales = true
        pdfView.maxScaleFactor = 3.0
        pdfView.minScaleFactor = 1.0
        pdfView.contentMode = .scaleAspectFit
    }
}
