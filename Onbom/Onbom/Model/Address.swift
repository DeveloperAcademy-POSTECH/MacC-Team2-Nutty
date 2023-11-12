//
//  Address.swift
//  Onbom
//
//  Created by moon on 10/27/23.
//


struct Address {
    var cityAddress: String = ""
    var detailAddress: String = ""
    var toString: String {
        get { return "\(cityAddress)  \(detailAddress)" }
    }
    
    init() {}
    
    init(_ cityAddress: String, _ detailAddress: String) {
        self.cityAddress = cityAddress
        self.detailAddress = detailAddress
    }
    
}

let mockAddress = Address("경기 성남시 분당구 판교역로 4(백현동)너어어어어무 기이이이이이잉이긴 글이이이이이이이이이일 경우", "행복아파트 104동 310호")
