//
//  Agent.swift
//  Onbom
//
//  Created by moon on 10/27/23.
//

import SwiftUI

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
    @Published var signature: [[CGPoint]] = []
    
    func combineID(frontID: String, backID: String) {
        id = "\(frontID)-\(backID)"
    }

    func splitID() -> (frontID: String, backID: String) {
        let splittedIDs = id.split(separator: "-").map { String($0) }
        return (splittedIDs.count > 0 ? splittedIDs[0] : "", splittedIDs.count > 1 ? splittedIDs[1] : "")
    }
    
    func updateDictionary() {
        dictionary["name"]?.answer = name
        dictionary["id"]?.answer = id
        dictionary["relation"]?.answer = relation
        dictionary["address"]?.answer = address.cityAddress + address.detailAddress
        dictionary["phoneNumber"]?.answer = phoneNumber
    }
}
