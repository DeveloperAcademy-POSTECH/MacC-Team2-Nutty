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
        pdfView.autoScales = true
        
        return pdfView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        if let pdfView = uiView as? PDFView, let pdfData {
            pdfView.document = PDFDocument(data: pdfData)
            pdfView.autoScales = true
        }
    }
}

