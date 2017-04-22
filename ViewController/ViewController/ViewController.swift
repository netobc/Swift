//
//  ViewController.swift
//  ViewController
//
//  Created by Ernesto De La Trinidad Vidana on 4/9/16.
//  Copyright © 2016 NetoCo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    //only once on first time
    override func viewDidLoad() {
        super.viewDidLoad()

        //refresh table
        view.backgroundColor = UIColor.greenColor()
        
    }

    //called before views appear on screen every time
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    //put code that modifies layout if fun before doesnt work
    override func viewDidLayoutSubviews() {
        
    }
    
    
    
}

