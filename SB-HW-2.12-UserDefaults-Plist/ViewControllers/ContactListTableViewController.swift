//
//  ViewController.swift
//  SB-HW-2.12-UserDefaults-Plist
//
//  Created by Sergey Nestroyniy on 13.10.2022.
//

import UIKit

class ContactListTableViewController: UITableViewController {
    
    private var contacts : [Contact] = StorageManager.shared.fetchFromFile()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if contacts.isEmpty {
            contacts = Contact.defaultContactList()
            contacts.forEach { contact in
                StorageManager.shared.saveToFile(with: contact)
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }
    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Contact", for: indexPath)
        let contact = contacts[indexPath.row]
        
        cell.contentMode = .right
                
        cell.textLabel?.text = contact.fullName
        cell.detailTextLabel?.text = contact.phone
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            contacts.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
//          StorageManager.shared.deleteContact(at: indexPath.row)
            StorageManager.shared.deleteFromFile(at: indexPath.row)
        }
    }
    
    
    // MARK: Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Add" {
            let addVC = segue.destination as! AddContactViewController
            addVC.delegate = self
        } else if segue.identifier == "Edit", let index = tableView.indexPathForSelectedRow?.row {
            let editVC = segue.destination as! AddContactViewController
            editVC.contact = contacts[index]
            editVC.index = index
            editVC.typeView = .edit
            editVC.delegate = self
        }
    }
        
}

    // MARK: Delegate

extension ContactListTableViewController : AddContactViewControllerDelegate {
    func saveContact(_ contact: Contact) {
        contacts.append(contact)
        self.tableView.reloadData()
    }
    
    func saveContact (_ contact: Contact, index: Int) {
        contacts[index] = contact
        self.tableView.reloadData()
    }
    
}



