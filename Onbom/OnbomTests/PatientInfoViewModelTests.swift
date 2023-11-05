//
//  OnbomTests.swift
//  OnbomTests
//
//  Created by moon on 10/30/23.
//

import XCTest

final class PatientInfoViewModelTests: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testIsValidName(_ name: String) -> Bool {
        let koreanRegex = try? NSRegularExpression(pattern: "^[가-힣]{2,}$")
        return koreanRegex?.firstMatch(in: name, options: [], range: NSRange(location: 0, length: name.utf16.count)) != nil
    }
    
    func testValidName() {
        // given
        let cases = [("뷁", false), ("asfdsa", false), ("ㅁ문", false), ("문ㅁㅁ", false), ("문문문문문ㅁㅁ", false), ("문문", true), ("문ㅁ", false), ("ㅎ", false), ("힣힣", true)]
        // when & then
        cases.forEach {
            print($0)
            XCTAssertEqual(testIsValidName($0), $1)
        }
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }
}
