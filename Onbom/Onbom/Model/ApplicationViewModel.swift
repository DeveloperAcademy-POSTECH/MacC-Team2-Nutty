//
//  ApplicationViewModel.swift
//  Onbom
//
//  Created by Junyoo on 2023/10/11.
//

import SwiftUI

class ApplicationViewModel: ObservableObject {
    @Published var application = ApplicationModel()
}

struct ApplicationModel {
    var image: UIImage?
    var patientName = "김순옥"
    var patientID = "123456-1234567"
    var patientAddress = Address()
    var patientActualAddress = Address()
    var patientPhoneNumber: String?
    
    var agentName = "김유진"
    var agentRelation = "가족"
    var agentID = "123456-1234567"
    var agentAddress = Address()
    var agentPhoneNumber = "010-1234-5678"
}

struct Address {
    var cityAddress = "경기 성남시 분당구 판교역로 4 (백현동)"
    var detailAddress = "행복아파트 104동 310호"
}
