//
//  ViewController.swift
//  SB-HW-2.12-UserDefaults-Plist
//
//  Created by Sergey Nestroyniy on 13.10.2022.
//

import UIKit

enum TypeView {
    case add
    case edit
}

protocol AddContactViewControllerDelegate {
    func saveContact (_ contact: Contact)
    func saveContact (_ contact: Contact, index: Int)
}

class AddContactViewController: UIViewController {

    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var familyTextField: UITextField!
    @IBOutlet var phoneTextField: UITextField!
    
    var delegate : AddContactViewControllerDelegate!
    
    var typeView = TypeView.add
    var contact : Contact!
    var index : Int!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        switch typeView {
        case .add:
            self.title = "Add Contact"
        case .edit:
            self.title = contact.fullName
            nameTextField.placeholder = contact.name
            familyTextField.placeholder = contact.familyName
            phoneTextField.placeholder = contact.phone
        }
    }
    
    @IBAction func doneButtonPressed(_ sender: UIBarButtonItem) {
//        let contactListVC = delegate as! ContactListTableViewController
//        switch typeView {
//        case .add: addContact(contactListVC)
//        case .edit: changeContact(contactListVC)
//        }
        switch typeView {
        case .add: addContact()
        case .edit: changeContact()
        }
        
        self.navigationController?.popViewController(animated: true)
    }
    
    private func showAlert () {
        let alert = UIAlertController(title: "Внимание", message: "Заполните все поля, чтобы добавить новый контакт", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        self.present(alert, animated: true)
    }
    
    
    //MARK: Setting data for storage and delegate
    
    private func addContact () {
        guard !(nameTextField.text!.isEmpty || familyTextField.text!.isEmpty || phoneTextField.text!.isEmpty) else {
            showAlert()
            return
        }
        contact = Contact(name: nameTextField.text!, familyName: familyTextField.text!, phone: familyTextField.text!)
        StorageManager.shared.saveToFile(with: contact, index: nil)
        delegate.saveContact(contact)
    }
    
    private func changeContact (){
        if !nameTextField.text!.isEmpty {contact.name = nameTextField.text!}
        if !familyTextField.text!.isEmpty {contact.familyName = familyTextField.text!}
        if !phoneTextField.text!.isEmpty {contact.phone = phoneTextField.text!}
        StorageManager.shared.saveToFile(with: contact, index: index)
        delegate.saveContact(contact, index: index)
    }
     
    
    /*
    //MARK: Setting data for delegate
    
    private func addContact (_ destVC: ContactListTableViewController) {
        guard !(nameTextField.text!.isEmpty || familyTextField.text!.isEmpty || phoneTextField.text!.isEmpty) else {
            showAlert()
            return
        }
        contact = Contact(name: nameTextField.text!, familyName: familyTextField.text!, phone: familyTextField.text!)
        destVC.saveContact(contact)
    }
    
    private func changeContact (_ destVC: ContactListTableViewController) {
        if !nameTextField.text!.isEmpty {contact.name = nameTextField.text!}
        if !familyTextField.text!.isEmpty {contact.familyName = familyTextField.text!}
        if !phoneTextField.text!.isEmpty {contact.phone = phoneTextField.text!}
        destVC.saveContact(contact, index: index)
    }
     */


}
