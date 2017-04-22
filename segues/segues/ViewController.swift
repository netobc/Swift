//
//  ViewController.swift
//  segues
//
//  Created by Ernesto De La Trinidad Vidana on 4/16/16.
//  Copyright © 2016 NetoCo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func loadBlue(sender: AnyObject!){
        let str = "Hey, acabamos de venir del otro"
        performSegueWithIdentifier("goToBlue", sender: str)
    }
    @IBAction func another(sender: AnyObject) {
        performSegueWithIdentifier("goToYellow", sender: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "goToBlue" {
            if let blueVC = segue.destinationViewController as? BluViewController{
                if let theString = sender as? String {
                    blueVC.transfertext = theString
                }
            }
        }
    }
}

