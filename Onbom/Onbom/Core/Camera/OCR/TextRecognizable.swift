//
//  TextRecognizable.swift
//  Onbom
//
//  Created by Junyoo on 11/1/23.
//

import UIKit

protocol TextRecognizable {
    func recognizeText(from image: UIImage, completion: @escaping (String?) -> Void)
}
