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
    
    func createPDF(documentURL: URL, newText: [String], signature: [[CGPoint]], image: UIImage, imageSize: CGSize) {
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
        addIDCardToPDF(pdfDocument: pdfDocument, image: image, imageSize: imageSize)
        
        guard let newData = pdfDocument.dataRepresentation() else { return }
        PDFDatas.append(newData)
    }
    
    // MARK: 전자서명 추가하는 함수
    func addSignatureToPDF(lines: [[CGPoint]], pdfDocument: PDFDocument) {
        if let secondPage = pdfDocument.page(at: 1) {
            for line in lines {
                let linePath = UIBezierPath()
                linePath.lineWidth = 20
                
                guard !line.isEmpty else { continue }
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
    
    // MARK: 민증 사진 추가하는 함수
    func addIDCardToPDF(pdfDocument: PDFDocument, image: UIImage, imageSize: CGSize) {
        let page = PDFPage()
        let a4Bounds = CGRect(x: 0, y: 0, width: 595.2, height: 841.8)
        page.setBounds(a4Bounds, for: .cropBox)
        let renderer = UIGraphicsImageRenderer(size: a4Bounds.size)
        let img = renderer.image { context in
            context.cgContext.saveGState()
            context.cgContext.translateBy(x: 0, y: a4Bounds.height)
            page.draw(with: .mediaBox, to: context.cgContext)
            context.cgContext.restoreGState()
            
            let myImage = image
            // 이미지의 위치와 크기 지정하는 코드
            myImage.draw(in: CGRect(x: (a4Bounds.width - imageSize.width * 10) / 2, y: (a4Bounds.height - imageSize.height * 10) / 2, width: imageSize.width*10, height: imageSize.height*10))
        }

        let newPage = PDFPage(image: img)!
        pdfDocument.insert(newPage, at: 2)
    }

}
