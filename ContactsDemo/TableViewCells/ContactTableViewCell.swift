//
//  ContactTableViewCell.swift
//  ContactsDemo
//
//  Created by Apple on 01/09/19.
//  Copyright © 2019 Abhilash. All rights reserved.
//

import UIKit
import RxSwift

class ContactTableViewCell: UITableViewCell {

    @IBOutlet weak var profileImgView: RUINetworkImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    let model : PublishSubject<Contact> = PublishSubject()
    private let bag = DisposeBag()
    
    fileprivate lazy var favouriteImg = UIImage.init(named: "home_favourite")
    
    override func awakeFromNib() {
        super.awakeFromNib()
        model
        .observeOn(MainScheduler.instance)
        .subscribe(onNext: {[unowned self] (element) in
            self.nameLabel.text = element.first_name! + element.last_name!
            self.profileImgView.sourceUrl = element.profile_pic
            self.accessoryView = element.favorite! ? UIImageView.init(image: self.favouriteImg) : nil
        })
        .disposed(by: bag)
    }
}
