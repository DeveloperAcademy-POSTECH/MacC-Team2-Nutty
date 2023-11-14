//
//  ValidationUtilTest.swift
//  OnbomTests
//
//  Created by moon on 11/9/23.
//

import XCTest


final class StringValidateTests: XCTestCase {
    
    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }
    
    struct EntryTestParameter<U, V> {
        let input: U
        let output: V
    }
    

    // 이름이 주어지면, 정규표현식을 확인하고, 결과를 내보낸다.
    func test_name_validate_result() throws {
        let parameters: [EntryTestParameter] = [
            EntryTestParameter(input: "김경숙", output: true),
            EntryTestParameter(input: "임의창", output: true),
            EntryTestParameter(input: "ㅁ문", output: false),
            EntryTestParameter(input: "문ㅁㅁ", output: false),
            EntryTestParameter(input: "문문문문문ㅁㅁ", output: false),
            EntryTestParameter(input: "문문", output: true),
            EntryTestParameter(input: "ㅎ", output: false),
            EntryTestParameter(input: "뷁", output: false),
            EntryTestParameter(input: "힣힣", output: true),
        ]
        
        for p in parameters {
            // given
            let name = p.input
            
            // when
            let result = name.isValidName()
            let expected = p.output
            
            // then
            print("input: \(name) / output: \(result)")
            XCTAssertEqual(result, expected)
        }
    }
    
    func test_phoneNumber_validate_result() throws {
        
        let parameters: [EntryTestParameter] = [
            EntryTestParameter(input: "01032323232", output: true),
            EntryTestParameter(input: "0100000000", output: false),
            EntryTestParameter(input: "01112345678", output: false),
        ]
        
        for p in parameters {
            // given
            let phoneNumber = p.input
            
            // when
            let result = phoneNumber.isValidPhoneNumber()
            let expected = p.output
            
            // then
            print("input: \(phoneNumber) / output: \(result)")
            XCTAssertEqual(result, expected)
        }
    
    }
    
    func test_birthday_validate_result() throws {
        
        let parameters: [EntryTestParameter] = [
            EntryTestParameter(input: "001223", output: true),
            EntryTestParameter(input: "221212", output: true),
            EntryTestParameter(input: "001232", output: false),
            EntryTestParameter(input: "01232", output: false),
            EntryTestParameter(input: "323232", output: false),
        ]
        
        for p in parameters {
            // given
            let birthday = p.input
            
            // when
            let result = birthday.isValidDateOfBirth()
            let expected = p.output
            
            // then
            print("input: \(birthday) / output: \(result)")
            XCTAssertEqual(result, expected)
        }
    
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
