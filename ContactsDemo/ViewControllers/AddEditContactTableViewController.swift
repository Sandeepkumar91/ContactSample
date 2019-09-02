//
//  AddEditContactTableViewController.swift
//  ContactsDemo
//
//  Created by Apple on 02/09/19.
//  Copyright © 2019 Abhilash. All rights reserved.
//

import UIKit
import Alamofire
class AddEditContactTableViewController: UITableViewController {

    fileprivate lazy var doneButton = UIBarButtonItem.init(barButtonSystemItem: .done, target: self, action: #selector(handleDoneTap))
    fileprivate lazy var cancelButton = UIBarButtonItem.init(barButtonSystemItem: .cancel, target: self, action: #selector(handleCancelTap))
    
    var contact: Contact?
    
    var tableListArr: [[String: String]]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = doneButton
        self.navigationItem.leftBarButtonItem = cancelButton
        convertModelIntoJson()
        configureTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        self.view.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(viewTapped)))
    }
    
    func convertModelIntoJson() {
        tableListArr = [
                [
                    "key": "First Name",
                    "value": self.contact?.first_name  ?? ""
                ],
                [
                    "key": "Last Name",
                    "value": self.contact?.last_name ?? ""
                ],
                [
                    "key": "mobile",
                    "value": self.contact?.phone_number ?? ""
                ],
                [
                    "key": "email",
                    "value": self.contact?.email ?? ""
                ]
            ]
    }
    
    @objc func viewTapped() {
        self.view.endEditing(true)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
                self.tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        self.tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func configureTableView() {
        self.tableView.register(UINib.init(nibName: String(describing: ContactDetailTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: ContactDetailTableViewCell.self))
        
        tableView.tableFooterView = UIView.init()
        tableView.backgroundColor = UIColor.init(red: 249, green: 249, blue: 249)
        tableView.rowHeight = 60
        tableView.delegate = self
        tableView.dataSource = self
        self.tableView.sectionHeaderHeight = 200
        tableView.sectionIndexColor = UIColor.TextBlack
    }
    
    func cameraButtonClicked() {
        ImagePickerManager.shared.presentPickerInViewController(vc: self)
    }
    
    @objc func handleDoneTap() {
        let dict = [
            "first_name" : self.tableListArr![0]["value"],
            "last_name": self.tableListArr![1]["value"]!,
            "email": self.tableListArr![3]["value"]!,
            "phone_number": self.tableListArr![2]["value"]!,
            "favorite": false
            ] as Parameters
        let endpoint = API.Endpoints.saveContact(dict)
        API.requestPOST(endpoint: endpoint) {[unowned self] (data, error) in
            if error == nil {
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    @objc func handleCancelTap() {
        dismiss(animated: true, completion: nil)
    }
}
extension AddEditContactTableViewController {
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if let headerView: AddContactHeaderView = (AddContactHeaderView.instanceFromNib() as? AddContactHeaderView) {
            headerView.cameraActionCallBack = {
                
            }
            return headerView
        }
        return nil
    }
}
extension AddEditContactTableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableListArr?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let details = tableListArr?[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ContactDetailTableViewCell.self)) as! ContactDetailTableViewCell
        cell.valueTF.tag = indexPath.row
        cell.titleLable.text = details?["key"]
        cell.valueTF.text = details?["value"]
        return cell
    }
}
extension AddEditContactTableViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        let nextRowIndex = textField.tag
        if nextRowIndex < 4, let cell = self.tableView.cellForRow(at: IndexPath.init(row: nextRowIndex, section: 0)) as? ContactDetailTableViewCell{
            cell.valueTF.becomeFirstResponder()
            return false
        }
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.tableView.scrollToRow(at: IndexPath.init(row: textField.tag, section: 0), at: .middle, animated: true)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if var details = tableListArr?[textField.tag] {
            details["value"] = textField.text
        }
    }
}
