//
//  ImagePickerManager.swift
//  ContactsDemo
//
//  Created by Apple on 02/09/19.
//  Copyright © 2019 Abhilash. All rights reserved.
//

import UIKit
import RxSwift

class ImagePickerManager: NSObject, UINavigationControllerDelegate {
    
    static let shared: ImagePickerManager = ImagePickerManager.init()
    private override init() {
        super.init()
    }
    
    var onImageChosenCallBack: PublishSubject<UIImage?> = PublishSubject.init()
    var onImagePickerDismissCallBack: PublishSubject<Bool> = PublishSubject.init()
    
    fileprivate var chosenImage: UIImage? = nil

    func presentPickerInViewController(vc: UIViewController) {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let pickerController = UIImagePickerController.init()
            pickerController.delegate = self
            pickerController.sourceType = .photoLibrary
            vc.present(pickerController, animated: true, completion: nil)
        }
    }
}
extension ImagePickerManager: UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.originalImage] as? UIImage
        onImageChosenCallBack.onNext(image)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        onImagePickerDismissCallBack.onNext(true)
    }
}
