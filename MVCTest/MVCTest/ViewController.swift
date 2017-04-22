//
//  ViewController.swift
//  MVCTest
//
//  Created by Ernesto De La Trinidad Vidana on 4/9/16.
//  Copyright © 2016 NetoCo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var FullName: UILabel!
    @IBOutlet weak var RenameField: UITextField!
    let person = Person(first: "Ernesto", last: "De la Trinidad")

    @IBAction func RenameButton(sender: AnyObject) {
        if let txt = RenameField.text{
            person.firstName = txt
            FullName.text = person.fullName
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        FullName.text = person.fullName

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

