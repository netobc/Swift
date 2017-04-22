//
//  ViewController.swift
//  MexicaliApp
//
//  Created by Ernesto De La Trinidad Vidana on 4/17/16.
//  Copyright © 2016 NetoCo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var moreBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        moreBtn.layer.cornerRadius = 3.0
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

