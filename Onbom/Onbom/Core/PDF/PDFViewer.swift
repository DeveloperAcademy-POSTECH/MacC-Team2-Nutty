//
//  PDFViewer.swift
//  Onbom
//
//  Created by Sebin Kwon on 2023/09/26.
//

import SwiftUI
import PDFKit

struct PDFViewer: UIViewRepresentable {
    private let pdfManager: PDFManager = .shared
    let pdfDocument: PDFDocument
    @Binding var pageIndex: Int
    
    init(pdfDocument: PDFDocument = PDFDocument(url: LTCIFormResource)!, pageIndex: Binding<Int>) {
        if let pdfDocument = PDFDocument(data: pdfManager.PDFDatas.first ?? Data()) {
            self.pdfDocument = pdfDocument
        } else {
            self.pdfDocument = pdfDocument
        }
        self._pageIndex = pageIndex
    }
    
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
        let minScale: CGFloat = UIScreen.main.bounds.height * 0.00075
        pdfView.document = pdfDocument
        if let page = pdfView.document?.page(at: pageIndex) {
            pdfView.go(to: page)
        }
        pdfView.displayMode = .singlePage
        pdfView.backgroundColor = UIColor(Color(.black).opacity(0.8))
        pdfView.scaleFactor = minScale
        pdfView.minScaleFactor = minScale
        pdfView.maxScaleFactor = 3.0
    }
}
