//
//  ContactsTableViewController.swift
//  ContactsDemo
//
//  Created by Apple on 01/09/19.
//  Copyright © 2019 Abhilash. All rights reserved.
//

import UIKit

class ContactsTableViewController: UITableViewController {
    
    fileprivate lazy var groups = UIBarButtonItem.init(title: "Groups", style: .plain, target: nil, action:  nil)
    
    fileprivate lazy var Add = UIBarButtonItem.init(barButtonSystemItem: .add, target: self, action: #selector(handleAddTap))

    var contacts: [String: [Contact]]  = [:]
    var sortedSectionTitles: [String] = []
    
    var navBackgroundImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Contact"
        configureTableView()
        self.navigationItem.leftBarButtonItem = groups
        self.navigationItem.rightBarButtonItem = Add
        
        let endpoint = API.Endpoints.fetchContacts
//        API.request(endpoint: endpoint) {
//            print("done")
//        }
        
//        let secendpoint = API.Endpoints.showContact(["id": "10139" as AnyObject])
        self.navBackgroundImage = self.navigationController?.navigationBar.backgroundImage(for: .default)
        API.request(endpoint: endpoint) {[unowned self] (data, error) in
            let scontacts = try! JSONDecoder().decode([Contact].self, from: data!)
            var sortedContacts = [String: [Contact]]()
            for contact in scontacts {
                let firstChar = "\(String(describing: contact.first_name!.characters.first!))".uppercased()
                 if sortedContacts[firstChar] == nil {
                    sortedContacts[firstChar] = [contact]
                }
                else {
                    sortedContacts[firstChar]?.append(contact)
                }
            }
            self.contacts = sortedContacts
            self.sortedSectionTitles = sortedContacts.keys.sorted()
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.setBackgroundImage(self.navBackgroundImage, for: .default)
    }
    
    @objc func handleAddTap() {
       
    }
    
    func configureTableView() {
        tableView.tableFooterView = UIView.init()
        tableView.rowHeight = 60
        tableView.delegate = self
        tableView.dataSource = self
        tableView.sectionIndexColor = UIColor.TextBlack
        self.tableView.register(UINib.init(nibName: String(describing: ContactTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: ContactTableViewCell.self))
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return sortedSectionTitles.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.contacts[sortedSectionTitles[section]]!.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sortedSectionTitles[section]
    }
    
    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return sortedSectionTitles
    }
    
    override func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
        return sortedSectionTitles.firstIndex(of: title)!
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let contact = contacts[sortedSectionTitles[indexPath.section]]![indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ContactTableViewCell.self), for: indexPath) as? ContactTableViewCell
        cell?.model.onNext(contact)
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let contact = contacts[sortedSectionTitles[indexPath.section]]![indexPath.row]

        let viewContact = ViewContactTableViewController.init(style: .plain)
        viewContact.contactId = "\(contact.id!)"
        self.navigationController?.pushViewController(viewContact, animated: true)
    }

}
