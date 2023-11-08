//
//  Agent.swift
//  Onbom
//
//  Created by moon on 10/27/23.
//

import SwiftUI

class Agent: ObservableObject {
    var dictionary: [String:(answer:String,position:CGRect)] = [
        "name":("김유진", CGRect(x: 158, y: 450, width: 140, height: 20)),
        "id":("", CGRect(x: 395, y: 450, width: 150, height: 20)),
        "relation":("", CGRect(x: 183, y: 320, width: 140, height: 20)),
        "address":("", CGRect(x: 158, y: 413, width: 380, height: 20)),
        "phoneNumber":("", CGRect(x: 158, y: 368, width: 140, height: 20)),
    ]
    @Published var name: String = "김유진"
    @Published var id: String = ""
    @Published var idCardImage: UIImage = UIImage()
    @Published var relation: String = ""
    @Published var address: Address = Address()
    @Published var phoneNumber: String = ""
    @Published var signature: [[CGPoint]] = []
    
    init() {}
    
    init(name: String, id: String, idCardImage: UIImage, relation: String, address: Address, phoneNumber: String, signature: [[CGPoint]]) {
        self.name = name
        self.id = id
        self.idCardImage = idCardImage
        self.relation = relation
        self.address = address
        self.phoneNumber = phoneNumber
        self.signature = signature
    }
    
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
        dictionary["address"]?.answer = "\(address.cityAddress)  \(address.detailAddress)"
        dictionary["phoneNumber"]?.answer = phoneNumber
    }
    
    func reset() {
        name = "김유진"
        id = ""
        idCardImage = UIImage(systemName: "heart")!
        relation = ""
        address = Address()
        phoneNumber = ""
        signature = [[]]
    }
}

let mockAgent = Agent(
    name: "김유진",
    id: "880912-2132321",
    idCardImage: UIImage(systemName: "heart")!,
    relation: "친족",
    address: mockAddress,
    phoneNumber: "01032323232",
    signature: [[]]
)

