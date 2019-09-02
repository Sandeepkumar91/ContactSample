//
//  RUIImageView.swift
//  ContactsDemo
//
//  Created by Apple on 01/09/19.
//  Copyright © 2019 Abhilash. All rights reserved.
//

import UIKit
import Alamofire
class RUIImageView: UIImageView {
    
}

class RUIBorderedImageView: RUIImageView {
    @IBInspectable var borderColor: String?
    @IBInspectable var borderWidth: String?
    @IBInspectable var cornerRadius: String?
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.borderColor = UIColor.getColorFromString(colorInString: borderColor).cgColor
        layer.borderWidth = borderWidth?.toCGFloat() ?? 0
        if let radius = cornerRadius {
            if !radius.isEmpty {
                layer.cornerRadius = radius.toCGFloat() ?? 0.0
            }
        }
    }
}

class RUINetworkImageView: RUIBorderedClickableImageView {
    
    var sourceUrl: String? {
        didSet {
            if let url = sourceUrl {
                getImageFromUrl(url: url) {[unowned self] img in
                    self.image = img
                }
            }
        }
    }
    
    func getImageFromUrl(url: String?, completionHandler: ((UIImage) -> ())?) {
        guard let url = url else { return }
        
        Alamofire.request(API.baseUrl + url).responseData { response in
            if let data = response.result.value {
                if let image = UIImage(data: data), let callback = completionHandler {
                    DispatchQueue.main.async {
                        callback(image)
                    }
                }
            }
        }
    }
}
class RUIBorderedClickableImageView: RUIBorderedImageView {
    var callBack: (() -> ())?
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialConfiguration()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialConfiguration()
    }
    
    func initialConfiguration() {
        self.isUserInteractionEnabled = true
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.handleTap)))
    }
    
    @objc func handleTap() {
        if let onClickAction = callBack {
            onClickAction()
        }
    }
}
