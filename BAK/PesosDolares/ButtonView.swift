//
//  ButtonView.swift
//  PesosDolares
//
//  Created by Ernesto De La Trinidad Vidana on 9/18/16.
//  Copyright © 2016 Neto's Co. All rights reserved.
//

import UIKit

class ButtonView: UIButton {
    
    override func awakeFromNib() {
        layer.cornerRadius = 5.0
        layer.shadowColor =  UIColor(red: SHADOW_COLOR, green: SHADOW_COLOR, blue: SHADOW_COLOR, alpha: 0.5).cgColor
        layer.shadowOpacity = 0.8
        layer.shadowRadius = 5.0
        layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
    }
    
}