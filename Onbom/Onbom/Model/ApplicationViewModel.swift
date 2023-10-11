//
//  ApplicationViewModel.swift
//  Onbom
//
//  Created by Junyoo on 2023/10/11.
//

import SwiftUI

class ApplicationViewModel: ObservableObject {
    @Published var image: UIImage?
    @Published var patientName = "김순옥"
    @Published var patientID = "123456-1234567"
    @Published var patientAddress = Address()
    @Published var patientActualAddress = Address()
    @Published var patientPhoneNumber: String?
    
    @Published var agentName = "김유진"
    @Published var agentRelation = "가족"
    @Published var agentID = "123456-1234567"
    @Published var agentAddress = Address()
    @Published var agentPhoneNumber = "010-1234-5678"
}

struct Address {
    var cityAddress = "경기 성남시 분당구 판교역로 4 (백현동)"
    var detailAddress = "행복아파트 104동 310호"
}
