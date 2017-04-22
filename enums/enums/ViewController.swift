//
//  ViewController.swift
//  enums
//
//  Created by Ernesto De La Trinidad Vidana on 4/17/16.
//  Copyright © 2016 NetoCo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var theLbl: UILabel!
    enum cars: Int {
        case TESLA = 0
        case HONDA = 2
        case BMW = 1
        case SUBARU = 3
    }
    
    var carOC: cars!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onBtnPressed(sender: UIButton!) {
        
        if sender.tag == cars.BMW.rawValue{
            theLbl.text = "BMW car"
        } else if sender.tag == cars.TESLA.rawValue{
            theLbl.text = "TESLA car"
        } else if sender.tag == cars.HONDA.rawValue{
            theLbl.text = "HONDA car"
        } else if sender.tag == cars.SUBARU.rawValue{
            theLbl.text = "SUBARU car"
        }
    }

}

