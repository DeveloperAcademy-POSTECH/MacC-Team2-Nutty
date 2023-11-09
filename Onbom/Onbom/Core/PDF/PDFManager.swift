//
//  PDFManager.swift
//  Onbom
//
//  Created by Sebin Kwon on 2023/09/26.
//

import Foundation
import PDFKit

enum PDFError: String, Error {
    case NullError = "pdf가 존재하지 않습니다"
}

// TODO: ObservableObject 제외, 싱글톤으로 변경
class PDFManager: ObservableObject {
    @Published var PDFDatas: [Data] = []

    let signatureRect: CGRect = CGRect(x: 280, y: 250, width: 500, height: 250)
    let imageSizeFloat: CGFloat = 0.5
    enum FixedPositionItems: CaseIterable {
            case apply
            case mailReceive
            case mailAddress
            case todayDate
            case agentName
        }
    
    func createPDF(documentURL: URL, patient: Patient, agent: Agent) {
        guard let pdfDocument = PDFDocument(url: documentURL) else { return }
        
        // MARK: 첫번째 페이지
        if let firstPage = pdfDocument.page(at: 0) {
            // 고정된 정보
            for item in Array(FixedPositionItems.allCases.prefix(2)) {
                switch item {
                case .apply:
                    addTextAnnotation(page: firstPage, bounds: CGRect(x: 168, y: 742, width: 140, height: 20), content: "✓")
                default:
                    continue
                }
            }
            // 환자
            for value in patient.dictionary.values {
                addTextAnnotation(page: firstPage, bounds:value.position, content: value.answer)
            }
            // 대리인
            for value in agent.dictionary.values {
                switch value.answer {
                case "가족":
                    addTextAnnotation(page: firstPage, bounds:value.position, content: "✓")
                case "친족":
                    addTextAnnotation(page: firstPage, bounds:CGRect(x: 245, y: 320, width: 140, height: 20), content: "✓")
                default:
                    addTextAnnotation(page: firstPage, bounds:value.position, content: value.answer)
                }
            }
        }
            
            // MARK: 두번째 페이지
            if let secondPage = pdfDocument.page(at: 1) {
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy        MM        dd"
                let currentDate = formatter.string(from: Date())
                // 고정된 정보
                for item in Array(FixedPositionItems.allCases.suffix(3)) {
                    switch item {
                    case .mailReceive:
                        addTextAnnotation(page: secondPage, bounds:CGRect(x: 342, y: 733, width: 140, height: 20), content: "✓")
                    case .mailAddress:
                        addTextAnnotation(page: secondPage, bounds:CGRect(x: 429, y: 690, width: 140, height: 20), content: "✓")
                    case .todayDate:
                        addTextAnnotation(page: secondPage, bounds:CGRect(x: 400, y: 482, width: 140, height: 20), content: currentDate)
                    case .agentName:
                        addTextAnnotation(page: secondPage, bounds:CGRect(x: 382, y: 430, width: 140, height: 20), content: agent.name)
                    default:
                        continue
                    }
                }
                // 전염성, 정신질환, 전자서명
                addTextAnnotation(page: secondPage, bounds: patient.hasInfectiousDisease ? CGRect(x: 301, y: 601, width: 140, height: 20) : CGRect(x: 352, y: 601, width: 140, height: 20), content: "✓")
                addTextAnnotation(page: secondPage, bounds: patient.hasMentalDisorder ? CGRect(x: 301, y: 580, width: 140, height: 20) : CGRect(x: 352, y: 580, width: 140, height: 20), content: "✓")
                addSignatureToPDF(lines: agent.signature, page: secondPage)
            }
        // 민증 사진
        addIDCardToPDF(pdfDocument: pdfDocument, image: agent.idCardImage, imageSize: agent.idCardImage.size)
        
        guard let newData = pdfDocument.dataRepresentation() else { return }
        PDFDatas.append(newData)
    }
    
    // MARK: 내용 추가하는 함수
    func addTextAnnotation(page: PDFPage, bounds: CGRect, content: String) {
        let textAnnotation = PDFAnnotation(bounds: bounds, forType: .freeText, withProperties: nil)
        textAnnotation.contents = content
        textAnnotation.color = .clear
        page.addAnnotation(textAnnotation)
    }
    
    // MARK: 전자서명 추가하는 함수
    func addSignatureToPDF(lines: [[CGPoint]], page: PDFPage) {
        let desiredSize = CGSize(width: 130, height: 80)
        
            for line in lines {
                let linePath = UIBezierPath()
                linePath.lineWidth = 20
                
                guard !line.isEmpty else { continue }
                let reversedLine = line.map { CGPoint(x: $0.x, y: signatureRect.height - $0.y) }
                linePath.move(to: reversedLine[0])
                
                for pointIndex in 1..<reversedLine.count {
                    linePath.addLine(to: reversedLine[pointIndex])
                }
                
                let scaleFactor = CGSize(width: desiredSize.width / signatureRect.width, height: desiredSize.height / signatureRect.height)
                linePath.apply(CGAffineTransform(scaleX: scaleFactor.width, y: scaleFactor.height))
                
                let adjustedBounds = CGRect(x: 440, y: 388, width: desiredSize.width, height: desiredSize.height)
                let lineAnnotation = PDFAnnotation(bounds: adjustedBounds, forType: .ink, withProperties: nil)
                
                lineAnnotation.add(linePath)
                page.addAnnotation(lineAnnotation)
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
            myImage.draw(in: CGRect(x: (a4Bounds.width - imageSize.width * imageSizeFloat) / 2, y: (a4Bounds.height - imageSize.height * imageSizeFloat) / 2, width: imageSize.width*imageSizeFloat, height: imageSize.height*imageSizeFloat))
        }

        let newPage = PDFPage(image: img)!
        pdfDocument.insert(newPage, at: 2)
    }
    
    public func getLastPdf() throws -> Data {
        guard let pdf = PDFDatas.last else {
            throw PDFError.NullError
        }
        return pdf;
    }

}
