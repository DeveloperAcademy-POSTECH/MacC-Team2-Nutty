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

    func makeUIView(context: Context) -> some UIView {
        let pdfView = PDFView()
        
        if let pdfData {
            pdfView.document = PDFDocument(data: pdfData)
        } else {
            pdfView.document = PDFDocument(url: LTCIFormResource)
        }
        // TODO: pdfData로 넘긴 pdfView만 적용 안되는 이슈 존재
        pdfView.autoScales = true
        pdfView.displayDirection = .horizontal
        pdfView.minScaleFactor = 0.6
        pdfView.maxScaleFactor = 5.0
        
        return pdfView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        if let pdfView = uiView as? PDFView, let pdfData {
                pdfView.document = PDFDocument(data: pdfData)
            }
    }
}

