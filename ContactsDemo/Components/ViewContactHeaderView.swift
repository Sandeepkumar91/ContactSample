//
//  ViewContactHeaderView.swift
//  ContactsDemo
//
//  Created by Apple on 01/09/19.
//  Copyright © 2019 Abhilash. All rights reserved.
//

import UIKit

class ViewContactHeaderView: UIView {

    @IBOutlet weak var profileView: CDImageTitleView!
    @IBOutlet weak var msgView: CDImageTitleView!
    @IBOutlet weak var callView: CDImageTitleView!
    @IBOutlet weak var emailView: CDImageTitleView!
    @IBOutlet weak var favouriteView: CDImageTitleView!
    
    var contact: Contact? {
        didSet {
            if contact != nil {
                self.profileView.sourceUrl = contact?.profile_pic
                self.profileView.title = contact!.first_name! + contact!.last_name!
            }
        }
    }
    
    var didClickedOnContactOptions: ((Int) -> ())?
    
    static func instanceFromNib() -> UIView {
        return UINib(nibName: String(describing: ViewContactHeaderView.self), bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! UIView
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        msgView.didClickedCallBack = {
            if let block = self.self.didClickedOnContactOptions {
                block(0)
            }
            let urlString = "sms:+12345678901"
            UIApplication.shared.openURL(URL(string: urlString)!)
        }
        
        callView.didClickedCallBack = {
            if let block = self.didClickedOnContactOptions {
                block(1)
            }
            let urlString = "tel://8197097703"
            UIApplication.shared.openURL(URL(string: urlString)!)
        }
        
        emailView.didClickedCallBack = {
            if let block = self.didClickedOnContactOptions {
                block(2)
            }
        }
        
        favouriteView.didClickedCallBack = {
            if let block = self.didClickedOnContactOptions {
                block(3)
            }
        }
    }
}
