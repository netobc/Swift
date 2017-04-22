//
//  BluViewController.swift
//  segues
//
//  Created by Ernesto De La Trinidad Vidana on 4/16/16.
//  Copyright © 2016 NetoCo. All rights reserved.
//

import UIKit

class BluViewController: UIViewController {
    
    @IBOutlet weak var mainLabel: UILabel!
    var transfertext = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        mainLabel.text = transfertext
        
    }
}
