//
//  extensions.swift
//  CBVogoManager
//
//  Created by Abhilash Palem on 05/08/19.
//  Copyright © 2019 Abhilash Palem. All rights reserved.
//

import UIKit

//MARK: - UIAlertController Extension
extension UIAlertController {
    @discardableResult static func displayAlert(message: String?, title: String, actionsArr:[(title: String, actionBlock:() -> ()?)]! = [], inViewController: UIViewController?, completionBlock : (() -> ())? = nil) -> UIAlertController? {
        
        guard let vc = inViewController else {
            return nil
        }
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        if !actionsArr.isEmpty {
            for btnTuple in actionsArr! {
                let title: String? = btnTuple.title
                alert.addAction(UIAlertAction(title: title ?? "", style: UIAlertAction.Style.default, handler: { alertAction in
                    btnTuple.actionBlock()
                }))
            }
        }
        else {
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler:nil))
        }
        vc.present(alert, animated: true, completion: completionBlock)
        return alert
    }
}

//MARK: - UIStoryboard Extension
extension UIStoryboard {
    static var main: UIStoryboard {
        return UIStoryboard.init(name: "Main", bundle: nil)
    }
}

//MARK: - String Extension
extension String {
    func toCGFloat() -> CGFloat? {
        var float: CGFloat? = nil
        if let n = NumberFormatter().number(from: self) {
            float = CGFloat(truncating: n)
        }
        return float
    }
}
extension UIView {
    /** Loads instance from nib with the same name. */
    func loadNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nibName = type(of: self).description().components(separatedBy: ".").last!
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as! UIView
    }
}
extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }

    convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }
}
public extension UIImage {
    public convenience init?(color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) {
        let rect = CGRect(origin: .zero, size: size)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
        color.setFill()
        UIRectFill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        guard let cgImage = image?.cgImage else { return nil }
        self.init(cgImage: cgImage)
    }
}
