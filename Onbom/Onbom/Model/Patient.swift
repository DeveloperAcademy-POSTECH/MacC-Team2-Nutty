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
    @Published var hasInfectiousDisease = false
    @Published var hasMentalDisorder = false
    
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


