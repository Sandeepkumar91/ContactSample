//
//  ViewContactTableViewController.swift
//  ContactsDemo
//
//  Created by Apple on 02/09/19.
//  Copyright © 2019 Abhilash. All rights reserved.
//

import UIKit
import MessageUI

class ViewContactTableViewController: UITableViewController {
    
    fileprivate lazy var EditButton = UIBarButtonItem.init(barButtonSystemItem: .edit, target: self, action: #selector(handleEditTap))
    
    var contactId: String?
    fileprivate var contact: Contact?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = nil
        tableView.dataSource = nil
        self.navigationItem.rightBarButtonItem = EditButton
        self.navigationController?.navigationBar.setBackgroundImage(UIImage.init(color: UIColor.white), for: .default)        
        
        let secendpoint = API.Endpoints.showContact(["id": "\(contactId!)" as AnyObject])
        API.request(endpoint: secendpoint) {[unowned self] (data, error) in
            self.contact = try! JSONDecoder().decode(Contact.self, from: data!)
            DispatchQueue.main.async {
                self.configureTableView()
                self.tableView.reloadData()
            }
        }
    }
    
    func sendEmail() {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients(["you@yoursite.com"])
            mail.setMessageBody("<p>You're so awesome!</p>", isHTML: true)
            
            present(mail, animated: true)
        } else {
            print("Mail failed")
        }
    }
    
    func sendSMS() {
        let composeVC = MFMessageComposeViewController()
        composeVC.messageComposeDelegate = self
        composeVC.recipients = [contact?.phone_number] as? [String]
        composeVC.body = "I love Swift!"
        
        if MFMessageComposeViewController.canSendText() {
            self.present(composeVC, animated: true, completion: nil)
        }
    }
    
    @objc func handleEditTap() {
        let c = AddEditContactTableViewController.init(style: .plain)
        c.contact = contact
        let navController = UINavigationController.init(rootViewController: c)
        navController.navigationBar.setBackgroundImage(UIImage.init(color: UIColor.white), for: .default)
        self.navigationController?.present(navController, animated: true, completion: nil)
    }
    
    func configureTableView() {
        self.tableView.register(UINib.init(nibName: String(describing: ContactDetailTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: ContactDetailTableViewCell.self))

        tableView.backgroundColor = UIColor.init(red: 249, green: 249, blue: 249)
        tableView.tableFooterView = UIView.init()
        tableView.rowHeight = 60
        tableView.delegate = self
        tableView.dataSource = self
        self.tableView.sectionHeaderHeight = 300
        tableView.sectionIndexColor = UIColor.TextBlack
    }
}
extension ViewContactTableViewController {
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView: ViewContactHeaderView = (ViewContactHeaderView.instanceFromNib() as? ViewContactHeaderView)!
        headerView.contact = contact
        return headerView
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ContactDetailTableViewCell.self)) as! ContactDetailTableViewCell
        switch indexPath.row {
        case 0:
            cell.titleLable.text = "mobile"
            cell.valueTF.isEnabled = false
            if let phNum = contact?.phone_number, !phNum.isEmpty {
                cell.valueTF.text = phNum
            }
            else {
                cell.valueTF.text = "N/A"
            }
        case 1:
            cell.titleLable.text = "email"
            if let email = contact?.email, !email.isEmpty {
                cell.valueTF.text = email
            }
            else {
                cell.valueTF.text = "N/A"
            }
        default:
            break
        }
        return cell
    }
}
extension ViewContactTableViewController: MFMailComposeViewControllerDelegate {
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
}
extension ViewContactTableViewController: MFMessageComposeViewControllerDelegate {
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        controller.dismiss(animated: true)
    }
}
