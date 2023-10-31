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
            let recognizedID = self.filterID(from: recognizedTexts)
            
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
    
    private func filterID(from texts: [String]) -> String? {
        var id = ""
        let idPattern = "\\d{6}\\s?-\\s?\\d{7}"

        for text in texts {
            if text.range(of: idPattern, options: .regularExpression) != nil {
                id = text
                break
            }
        }
        
        return id.isEmpty ? nil : id
    }
}
