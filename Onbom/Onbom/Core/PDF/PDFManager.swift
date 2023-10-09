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
    let cgRectArray: [CGRect] = [CGRect(x: 150, y: 650, width: 140, height: 20),CGRect(x: 350, y: 650, width: 140, height: 20),CGRect(x: 150, y: 600, width: 140, height: 20),CGRect(x: 350, y: 565, width: 140, height: 20)]
    let signatureRect: CGRect = CGRect(x: 300, y: 300, width: 500, height: 250)
    
    func createPDF(documentURL: URL, newText: [String], signature: [[CGPoint]]) {
        guard let pdfDocument = PDFDocument(url: documentURL) else { return }
        
        if let firstPage = pdfDocument.page(at: 0) {
            for index in 0..<newText.count {
                let textAnnotation = PDFAnnotation(bounds: cgRectArray[index], forType: .freeText, withProperties: nil)
                textAnnotation.contents = newText[index]
//                textAnnotation.font = UIFont.systemFont(ofSize: 12.0)
                textAnnotation.font = UIFont(name: "Helvetica", size: 12.0)
//                textAnnotation.color = .clear
                firstPage.addAnnotation(textAnnotation)
            }
        }
        
        addSignatureToPDF(lines: signature, pdfDocument: pdfDocument)
        
        guard let newData = pdfDocument.dataRepresentation() else { return }
        PDFDatas.append(newData)
    }
    
    func addSignatureToPDF(lines: [[CGPoint]], pdfDocument: PDFDocument) {
        if let secondPage = pdfDocument.page(at: 1) {
            for line in lines {
                let linePath = UIBezierPath()
                linePath.lineWidth = 20
                
                guard !line.isEmpty else { continue }
                // 좌표를 상하반전해서 적용
                let reversedLine = line.map { CGPoint(x: $0.x, y: signatureRect.height - $0.y) }
                linePath.move(to: reversedLine[0])
                
                for pointIndex in 1..<reversedLine.count {
                    linePath.addLine(to: reversedLine[pointIndex])
                }
                
                let lineAnnotation = PDFAnnotation(bounds: signatureRect, forType: .ink, withProperties: nil)
                lineAnnotation.add(linePath)
                secondPage.addAnnotation(lineAnnotation)
            }
        }
    }

}
