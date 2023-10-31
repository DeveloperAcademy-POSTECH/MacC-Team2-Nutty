//
//  DocumentTextRecognizer.swift
//  Onbom
//
//  Created by Junyoo on 11/1/23.
//

import UIKit
import Vision

class DocumentTextRecognizer: TextRecognizable {
    //나중에 수정할 코드덩어리~
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
            let recognizedNameID = self.filterNameID(from: recognizedTexts)
            
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
    
    private func filterNameID(from texts: [String]) -> String? {
        var name = ""
        var id = ""
        
        if let index = texts.firstIndex(where: { $0.contains("주민등록증") }) {
            let nameIndex = index + 1
            if texts.indices.contains(nameIndex) {
                let rawName = texts[nameIndex]
                if let range = rawName.range(of: "(", options: .literal) {
                    name = String(rawName[..<range.lowerBound])
                } else {
                    name = rawName
                }
                name = name.replacingOccurrences(of: " ", with: "")
            }
            
            let idNumberIndex = nameIndex + 1
            if texts.indices.contains(idNumberIndex){
                id = texts[idNumberIndex]
            }
        }
        
        if !name.isEmpty && !id.isEmpty {
            return id
        } else {
            return nil
        }
    }
}
