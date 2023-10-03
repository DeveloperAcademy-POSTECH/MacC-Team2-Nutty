//
//  PDFManager.swift
//  Onbom
//
//  Created by Sebin Kwon on 2023/09/26.
//

import Foundation
import PDFKit

class PDFManager: ObservableObject {
    @Published var PDFDatas: [Data] = []
    
    func createPDF(documentURL: URL, newText: [String], at rect: [CGRect]) {
        guard let pdfDocument = PDFDocument(url: documentURL) else { return }
        
        if let firstPage = pdfDocument.page(at: 0) {
            for index in 0..<newText.count {
                let textAnnotation = PDFAnnotation(bounds: rect[index], forType: .freeText, withProperties: nil)
                textAnnotation.contents = newText[index]
//                textAnnotation.font = UIFont.systemFont(ofSize: 12.0)
                textAnnotation.font = UIFont(name: "Helvetica", size: 12.0)
//                textAnnotation.color = .clear
                firstPage.addAnnotation(textAnnotation)
            }
        }
        
        guard let newData = pdfDocument.dataRepresentation() else { return }
        PDFDatas.append(newData)
        
        //    let newURL = 서버 URL?
        //    do {
        //        try newData.write(to: newURL)
        //    } catch {
        //        print("Failed to save the modified PDF: \(error)")
        //    }
    }
}
