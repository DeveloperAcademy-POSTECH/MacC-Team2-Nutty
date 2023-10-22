//
//  ApplicationViewModel.swift
//  Onbom
//
//  Created by Junyoo on 2023/10/09.
//

import SwiftUI

class Patient: ObservableObject {
    var dictionary: [String:(answer:String,position:CGRect)] = [
        "name":("name",CGRect(x: 158, y: 605, width: 140, height: 20)),
        "id":("id",CGRect(x: 395, y: 605, width: 150, height: 20)),
        "address":("address",CGRect(x: 158, y: 565, width: 380, height: 20)),
        "actualAddress":("actualAddress",CGRect(x: 158, y: 520, width: 380, height: 20)),
        "phoneNumber":("phoneNumber",CGRect(x: 158, y: 479, width: 140, height: 20)),
    ]
    @Published var name: String = ""
    @Published var id: String = ""
    @Published var address: Address = Address()
    @Published var actualAddress: Address = Address()
    @Published var phoneNumber: String = ""
    
    func combineID(frontID: String, backID: String) {
        id = "\(frontID)-\(backID)"
    }
    
    func updateDictionary() {
        dictionary["name"]?.answer = name
        dictionary["id"]?.answer = id
        dictionary["address"]?.answer = address.cityAddress + address.detailAddress
        dictionary["actualAddress"]?.answer = actualAddress.cityAddress + actualAddress.detailAddress
        dictionary["phoneNumber"]?.answer = phoneNumber
    }
}

class Agent: ObservableObject {
    var dictionary: [String:(answer:String,position:CGRect)] = [
        "name":("name", CGRect(x: 158, y: 450, width: 140, height: 20)),
        "id":("id", CGRect(x: 395, y: 450, width: 150, height: 20)),
        "relation":("relation", CGRect(x: 183, y: 320, width: 140, height: 20)),
        "address":("address", CGRect(x: 158, y: 413, width: 380, height: 20)),
        "phoneNumber":("phoneNumber", CGRect(x: 158, y: 368, width: 140, height: 20)),
    ]
    @Published var name: String = "대리인"
    @Published var id: String = ""
    @Published var idCardImage: UIImage = UIImage()
    @Published var relation: String = ""
    @Published var address: Address = Address()
    @Published var phoneNumber: String = ""
    
    func combineID(frontID: String, backID: String) {
        id = "\(frontID)-\(backID)"
    }
    
    func updateDictionary() {
        dictionary["name"]?.answer = name
        dictionary["id"]?.answer = id
        dictionary["relation"]?.answer = relation
        dictionary["address"]?.answer = address.cityAddress + address.detailAddress
        dictionary["phoneNumber"]?.answer = phoneNumber
    }
}

struct Address {
    var cityAddress: String = ""
    var detailAddress: String = ""
}

//초기값
//struct ApplicationModel {
//    var patientName = "김순옥"
//    var patientID = "123456-1234567"
//    var patientAddress = Address()
//    var patientActualAddress = Address()
//    var patientPhoneNumber: String?
//
//    var agentName = "김유진"
//    var agentRelation = "가족"
//    var agentID = "123456-1234567"
//    var agentAddress = Address()
//    var agentPhoneNumber = "010-1234-5678"
//}
