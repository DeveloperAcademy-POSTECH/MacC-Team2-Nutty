//
//  String+Validation.swift
//  Onbom
//
//  Created by Junyoo on 11/5/23.
//

import Foundation

extension String {
    func isValidDateOfBirth() -> Bool {
        //주민번호 앞자리 검증
        if self.count != 6 { return false }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyMMdd"
        return dateFormatter.date(from: self) != nil
    }
    
    func isValidIDBackNumber() -> Bool {
        if self.count == 7 {
            if let first = self.first, "1234".contains(first) {
                return true
            }
        }
        return false
    }
}
