//
//  StorageManager.swift
//  SB-HW-2.12-UserDefaults-Plist
//
//  Created by Sergey Nestroyniy on 13.10.2022.
//

import Foundation

class StorageManager {
    static let shared = StorageManager()
        
    private let userDefaults = UserDefaults.standard
    private let contactKey = "contacts"
    private let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    private var archiveURL: URL
    
    init() {
        archiveURL = documentDirectory.appendingPathComponent("Contacts").appendingPathExtension("plist")
    }
    
    // MARK: userDefaults
    
    func fetchContacts() -> [Contact] {
        guard let data = userDefaults.object(forKey: contactKey) as? Data else { return [] }
        guard let contacts = try? JSONDecoder().decode([Contact].self, from: data) else { return [] }
        return contacts
    }
    
    func save(contact: Contact) {
        var contacts = fetchContacts()
        contacts.append(contact)
        guard let data = try? JSONEncoder().encode(contacts) else { return }
        userDefaults.setValue(data, forKey: contactKey)
    }
    
    func deleteContact(at index: Int) {
        var contacts = fetchContacts()
        contacts.remove(at: index)
        guard let data = try? JSONEncoder().encode(contacts) else { return }
        userDefaults.setValue(data, forKey: contactKey)
    }
    
    // MARK: plist
    
    func fetchFromFile() -> [Contact] {
        guard let data = try? Data(contentsOf: archiveURL) else { return [] }
        guard let contacts = try? PropertyListDecoder().decode([Contact].self, from: data) else { return [] }
        return contacts
        
    }
    
    func saveToFile(with contact: Contact, index: Int? = nil) {
        var contacts = fetchFromFile()
        if let index = index {
            contacts[index] = contact
        } else {
            contacts.append(contact)
        }

        guard let data = try? PropertyListEncoder().encode(contacts) else {
            return
        }
        
        try? data.write(to: archiveURL, options: .noFileProtection)
    }
    
    func deleteFromFile(at index: Int) {
        var contacts = fetchFromFile()
        contacts.remove(at: index)
        
        guard let data = try? PropertyListEncoder().encode(contacts) else {
            return
        }
    
        try? data.write(to: archiveURL, options: .noFileProtection)
    }
}

