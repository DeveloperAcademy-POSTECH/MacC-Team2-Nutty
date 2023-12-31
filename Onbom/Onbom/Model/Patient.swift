//
//  ApplicationViewModel.swift
//  Onbom
//
//  Created by Junyoo on 2023/10/09.
//

import SwiftUI

class Patient: ObservableObject {
    var dictionary: [String:(answer:String,position:CGRect)] = [
        "name":("",CGRect(x: 158, y: 605, width: 140, height: 20)),
        "id":("",CGRect(x: 395, y: 605, width: 150, height: 20)),
        "address":("",CGRect(x: 158, y: 565, width: 380, height: 20)),
        "actualAddress":("",CGRect(x: 158, y: 520, width: 380, height: 20)),
        "phoneNumber":("",CGRect(x: 158, y: 479, width: 140, height: 20)),
    ]
    @Published var name: String = ""
    @Published var id: String = ""
    @Published var address: Address = Address()
    @Published var actualAddress: Address = Address()
    @Published var _phoneNumber = ""
    
    var phoneNumber: String {
        get { return self._phoneNumber }
        set {
            if(newValue == " "){ self._phoneNumber = "" }
            else { self._phoneNumber = newValue }
        }
    }
    @Published var hasMobile: Bool = true
    @Published var hasInfectiousDisease = false
    @Published var hasMentalDisorder = false
    
    init() {}
    
    init(name: String, id: String, address: Address, actualAddress: Address, phoneNumber: String, hasInfectiousDisease: Bool = false, hasMentalDisorder: Bool = false) {
        self.name = name
        self.id = id
        self.address = address
        self.actualAddress = actualAddress
        self.phoneNumber = phoneNumber
        self.hasInfectiousDisease = hasInfectiousDisease
        self.hasMentalDisorder = hasMentalDisorder
    }
    
    func combineID(frontID: String, backID: String) {
        id = "\(frontID)-\(backID)"
    }
    
    func getPhoneNumber() -> String {
        if(hasMobile == false) { return "전화번호 없음"}
        if(self._phoneNumber.count < 11) { return "전화번호가 올바르지 않습니다" }
        
        return "010-\(_phoneNumber.slice(3, 6))-\(_phoneNumber.slice(7,10))"
    }
    
    func updateDictionary() {
        dictionary["name"]?.answer = name
        dictionary["id"]?.answer = id
        dictionary["address"]?.answer = "\(address.cityAddress)  \(address.detailAddress)"
        dictionary["actualAddress"]?.answer = "\(actualAddress.cityAddress)  \(actualAddress.detailAddress)"
        dictionary["phoneNumber"]?.answer = phoneNumber
    }
    
    func reset() {
        name = ""
        id = ""
        address = Address()
        actualAddress = Address()
        phoneNumber = ""
        hasInfectiousDisease = false
        hasMentalDisorder = false
    }
}


let mockPatient = Patient(
    name: "김순옥",
    id: "331212-1234567",
    address: mockAddress,
    actualAddress: mockAddress,
    phoneNumber: "01012341234",
    hasInfectiousDisease: false,
    hasMentalDisorder: false
)

