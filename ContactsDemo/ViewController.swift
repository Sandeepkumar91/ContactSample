//
//  ViewController.swift
//  ContactsDemo
//
//  Created by Apple on 01/09/19.
//  Copyright © 2019 Abhilash. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var haederView: ViewContactHeaderView?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
//        let headerview = ViewContactHeaderView.instanceFromNib() as? ViewContactHeaderView
//        headerview?.frame = CGRect.init(x: 0, y: 50, width: view.frame.width, height: 300)
//        self.view.addSubview(headerview!)
        
        let headerviewsec = AddContactHeaderView.instanceFromNib() as? AddContactHeaderView
        headerviewsec?.frame = CGRect.init(x: 0, y: 0, width: view.frame.width, height: 300)
        self.view.addSubview(headerviewsec!)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
    }

}

