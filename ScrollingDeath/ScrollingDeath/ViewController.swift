//
//  ViewController.swift
//  ScrollingDeath
//
//  Created by Ernesto De La Trinidad Vidana on 5/7/16.
//  Copyright © 2016 NetoCo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var scrollview: UIScrollView!
    
    let WIDTH: CGFloat = 240
    let HEIGHT: CGFloat = 397

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        for x in 1...5{
            let img = UIImage(named: "\(x)")
            let imgView = UIImageView(image: img)
            
            scrollview.addSubview(imgView)
            imgView.frame = CGRectMake(-WIDTH + (WIDTH*CGFloat(x)), 270, WIDTH, HEIGHT)
        }
        
        scrollview.contentSize = CGSizeMake(WIDTH*5, scrollview.frame.size.height)
    }

    
    


}

