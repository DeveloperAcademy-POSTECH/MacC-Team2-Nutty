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
    
    func isValidPhoneNumber() -> Bool {
        let reg = try? NSRegularExpression(pattern: "^010[0-9]{8}$")
        
        return reg?.firstMatch(in: self, options: [], range: NSRange(location: 0, length: self.utf16.count)) != nil
    }
    
    func isValidName() -> Bool {
        let koreanRegex = try? NSRegularExpression(pattern: "^[가-힣]{2,}$")
        
        return koreanRegex?.firstMatch(in: self, options: [], range: NSRange(location: 0, length: self.utf16.count)) != nil
    }

}
