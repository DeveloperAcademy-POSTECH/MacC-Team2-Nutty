//
//  IDCardTextRecognizer.swift
//  Onbom
//
//  Created by Junyoo on 2023/10/09.
//

import Vision
import UIKit

class IDCardTextRecognizer: TextRecognizable {
    func recognizeText(from image: UIImage, completion: @escaping (String?) -> Void) {
        guard let cgImage = image.cgImage else {
            completion(nil)
            return
        }
        
        let request = VNRecognizeTextRequest { (request, error) in
            if let error = error {
                print("IDCardTextRecognizer text recognition error: \(error)")
                completion(nil)
                return
            }
            guard let observations = request.results as? [VNRecognizedTextObservation] else {
                completion(nil)
                return
            }
            let recognizedTexts = observations.compactMap { observation in
                return observation.topCandidates(1).first?.string
            }
            let recognizedID = self.filterShowcaseID(from: recognizedTexts)
            
            completion(recognizedID)
        }
        
        request.recognitionLevel = .accurate
        request.recognitionLanguages = ["ko-KR"]
        
        let requests = [request]
        let imageRequestHandler = VNImageRequestHandler(cgImage: cgImage, options: [:])
        do {
            try imageRequestHandler.perform(requests)
        } catch let error {
            print("IDCardTextRecognizer VNImageRequestHandler Error: \(error)")
            completion(nil)
        }
    }
    
    private func filterShowcaseID(from recognizedText: [String]) -> String? {
        let firstIDPattern = "\\d{6}-\\d{7}"
        let secondIDPattern = "\\d{13}"
        let thirdIDPattern = "\\d{7}"
        let fourthIDPattern = "\\d{6}"

        var frontID: String = ""
        var backID: String = ""

        for text in recognizedText {
            if text.range(of: firstIDPattern, options: .regularExpression) != nil {
                return text
            } else if text.range(of: secondIDPattern, options: .regularExpression) != nil {
                let retString = text
                frontID = String(retString.prefix(6))
                backID = String(retString.suffix(7))
            } else if text.range(of: thirdIDPattern, options: .regularExpression) != nil {
                backID = text
            } else if text.range(of: fourthIDPattern, options: .regularExpression) != nil {
                frontID = text
            }
            
            if !frontID.isEmpty && !backID.isEmpty { return "\(frontID)-\(backID)"}
        }
        return frontID.isEmpty && backID.isEmpty ? nil : "\(frontID)-\(backID)"
    }
    
    private func filterID(from recognizedText: [String]) -> String? {
        var id = ""
        let idPattern = "\\d{6}\\s?-\\s?\\d{7}"
        
        for text in recognizedText {
            if text.range(of: idPattern, options: .regularExpression) != nil {
                id = text
                break
            }
        }
        
        return id.isEmpty ? nil : id
    }
}
