//
//  AddContactHeaderView.swift
//  ContactsDemo
//
//  Created by Apple on 01/09/19.
//  Copyright © 2019 Abhilash. All rights reserved.
//

import UIKit
import RxSwift
class AddContactHeaderView: UIView {
    
    @IBOutlet weak var cameraActionButton: RUIBorderedClickableImageView!
    @IBOutlet weak var profileImgView: RUINetworkImageView!
    
    fileprivate var bag = DisposeBag.init()
    
    var cameraActionCallBack: (() -> ())? = nil
    
    static func instanceFromNib() -> UIView {
        return UINib(nibName: String(describing: AddContactHeaderView.self), bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! UIView
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
//        let obj = ImagePickerManager.init()
//
//        obj.onImagePickerDismissCallBack
//        .subscribe(onNext: { (isClickedOnCancel) in
//            self.onImagePickerDismissCallBack.onNext(isClickedOnCancel)
//        })
//        .disposed(by: bag)
//
//        obj.onImageChosenCallBack
//        .subscribe(onNext: {[unowned self] (image) in
//            self.onImageChosenCallBack.onNext(image)
//        })
//        .disposed(by: bag)
        
        self.cameraActionButton.callBack = { [unowned self] in
            print("cameraAction")
            if let block = self.cameraActionCallBack {
                block()
            }
        }
    }
}
