//
//  RoundedImageView.swift
//  MVCTest
//
//  Created by Ernesto De La Trinidad Vidana on 4/9/16.
//  Copyright © 2016 NetoCo. All rights reserved.
//

import UIKit

class RoundedImageView: UIImageView {

    override func awakeFromNib(){
        
        self.layer.cornerRadius = 5.0
        self.clipsToBounds = true
    }
}
