//
//  RUIWhiteGreenGradientView.swift
//  ContactsDemo
//
//  Created by Apple on 01/09/19.
//  Copyright © 2019 Abhilash. All rights reserved.
//

import UIKit

class RUIWhiteGreenGradientView: UIView {
    override func layoutSubviews() {
        super.layoutSubviews()
        createGradientLayer()
    }
    
    func createGradientLayer() {
        let gradientLayer = CAGradientLayer.init()
        gradientLayer.frame = bounds
        gradientLayer.colors = [UIColor.init(rgb: 0xFFFFFF).cgColor, UIColor.init(red: 221, green: 245, blue: 240).cgColor]
        gradientLayer.locations = [0, 0.3]
        layer.insertSublayer(gradientLayer, at: 0)
    }
}
