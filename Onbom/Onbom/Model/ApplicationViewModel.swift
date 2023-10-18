//
//  ApplicationViewModel.swift
//  Onbom
//
//  Created by Junyoo on 2023/10/09.
//

import SwiftUI

class Patient: ObservableObject {
    @Published var name: String = ""
    @Published var id: String = ""
    @Published var address: Address = Address()
    @Published var actualAddress: Address = Address()
    @Published var phoneNumber: String = ""
    
    func combineID(frontID: String, backID: String) {
        id = "\(frontID)-\(backID)"
    }
}

class Agent: ObservableObject {
    @Published var name: String = ""
    @Published var id: String = ""
    @Published var relation: String = ""
    @Published var address: Address = Address()
    @Published var phoneNumber: String = ""
    
    func combineID(frontID: String, backID: String) {
        id = "\(frontID)-\(backID)"
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
