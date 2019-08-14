//
//  TableView.swift
//  ContactListApp
//
//  Created by IMCS2 on 8/13/19.
//  Copyright © 2019 Tanishk. All rights reserved.
//

import UIKit
import Contacts

class TableView: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var contactStore = CNContactStore()
    var contacts = [ContactStruct]()
    
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
         fetchContact()
        // Do any additional setup after loading the view.
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let contactToDisp = contacts[indexPath.row]
        cell.textLabel?.text = contactToDisp.givenName + " " + contactToDisp.familyName
        cell.detailTextLabel?.text = contactToDisp.number
        
        return cell
    }
    
    
    func fetchContact() {
        
        let key = [CNContactGivenNameKey, CNContactFamilyNameKey , CNContactPhoneNumbersKey, CNContactEmailAddressesKey] as [CNKeyDescriptor]
        let request = CNContactFetchRequest(keysToFetch: key)
        
        try!  contactStore.enumerateContacts(with: request) { (contact, stoppingPointer) in
            
            let name = contact.givenName
            let familyName = contact.familyName
            let number = contact.phoneNumbers.first?.value.stringValue
            //  let email = contact.emailAddresses.first?.value
            
            let contactToAppend = ContactStruct(givenName: name, familyName: familyName, number: number!)
            self.contacts.append(contactToAppend)
            
        }
        
        tableView.reloadData()
       // print(contacts.first?.givenName)
        
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    let blogSegueIdentifier = "tableToView"
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if  segue.identifier == blogSegueIdentifier,
            let destination = segue.destination as? ViewController,
            let blogIndex = tableView.indexPathForSelectedRow?.row
            
        {
            let contactToDisp = contacts[blogIndex]
            print(contactToDisp.givenName + " " + contactToDisp.familyName)
            destination.str = contactToDisp.givenName + " " + contactToDisp.familyName
            
        }
    }
    
    


}
