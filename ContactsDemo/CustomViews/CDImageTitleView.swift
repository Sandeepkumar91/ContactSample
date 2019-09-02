//
//  CDImageTitleView.swift
//  ContactsDemo
//
//  Created by Apple on 01/09/19.
//  Copyright © 2019 Abhilash. All rights reserved.
//

import UIKit

class CDImageTitleView: RUICustomNIbView {
    
    @IBInspectable var image: UIImage? {
        didSet {
            if image != nil{
                (viewWithTag(imageViewTag) as? RUINetworkImageView)?.image = image
            }
        }
    }
    
    var sourceUrl: String? {
        didSet{
            if sourceUrl != nil{
                (viewWithTag(imageViewTag) as? RUINetworkImageView)?.sourceUrl = sourceUrl
            }
        }
    }
    
    @IBInspectable var title: String? {
        didSet {
            (viewWithTag(titleViewTag) as? UILabel)?.text = title
        }
    }
    
    var didClickedCallBack: (() -> ())?
    
    let imageViewTag = 101
    let titleViewTag = 102
    
    override func initialConfiguration() {
        super.initialConfiguration()
        (viewWithTag(imageViewTag) as? RUINetworkImageView)?.callBack = {
            if let block = self.didClickedCallBack {
                block()
            }
        }
    }
}

