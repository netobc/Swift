//
//  BlueButton.swift
//  CustomView
//
//  Created by Ernesto De La Trinidad Vidana on 4/17/16.
//  Copyright © 2016 NetoCo. All rights reserved.
//

import UIKit

class BlueButton: UIButton {

    override func awakeFromNib() {
        layer.cornerRadius = 5.0
        backgroundColor = UIColor(red: 0.0/255.0, green: 122.0/255.0, blue: 255.0/255.0, alpha: 1.0)
        setTitleColor(UIColor.whiteColor(), forState: .Normal)
    }

}
