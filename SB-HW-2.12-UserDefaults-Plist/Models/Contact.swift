//
//  Contact.swift
//  SB-HW-2.12-UserDefaults-Plist
//
//  Created by Sergey Nestroyniy on 13.10.2022.
//

struct Contact: Codable{
    var name : String
    var familyName : String
    var phone : String
    var fullName : String {
        name + " " + familyName
    }
    
    static func defaultContactList() -> [Contact] {
        let contactList : [Contact] = [ Contact(name: "Max", familyName: "Smith", phone: "+7123456789"),
                                        Contact(name: "Jane", familyName: "Johanson", phone: "+1231313213"),
                                        Contact(name: "Bill", familyName: "Gates", phone: "+1234324234")]
        return contactList
    }
}
