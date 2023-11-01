//
//  DocumentTextRecognizer.swift
//  Onbom
//
//  Created by Junyoo on 11/1/23.
//

import UIKit
import Vision

class DocumentTextRecognizer: TextRecognizable {
    func recognizeText(from image: UIImage, completion: @escaping (String?) -> Void) {
        guard let cgImage = image.cgImage else {
            completion(nil)
            return
        }
        
        let request = VNRecognizeTextRequest { (request, error) in
            if let error = error {
                print("TextRecognizer text recognition error: \(error)")
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
            let recognizedNameID = self.filterText(from: recognizedTexts)
            
            completion(recognizedNameID)
        }
        
        request.recognitionLevel = .accurate
        request.recognitionLanguages = ["ko-KR"]
        
        let requests = [request]
        let imageRequestHandler = VNImageRequestHandler(cgImage: cgImage, options: [:])
        do {
            try imageRequestHandler.perform(requests)
        } catch let error {
            print("Error: \(error)")
            completion(nil)
        }
    }
    
    private func filterText(from texts: [String]) -> String? {
        
        return nil
    }
}
