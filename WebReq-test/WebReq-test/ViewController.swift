//
//  ViewController.swift
//  WebReq-test
//
//  Created by Ernesto De La Trinidad Vidana on 4/25/16.
//  Copyright © 2016 NetoCo. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController {
    
    @IBOutlet weak var container: UIView!
    
    var webview: WKWebView!

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    override func viewDidAppear(animated: Bool) {
        webview = WKWebView()
        container.addSubview(webview)
        let frame = CGRectMake(0, 0, container.bounds.width, container.bounds.height)
        webview.frame = frame
        
        loadRequest("https://www.currencymood.com/bancos")
    }
    
    func loadRequest(URLstr: String){
        let url = NSURL(string: URLstr)!
        let request = NSURLRequest(URL: url)
        
        webview.loadRequest(request)
        
    }
    
    
    @IBAction func leftbutton(sender: AnyObject) {
        loadRequest("https://www.currencymood.com/home")
    }
    @IBAction func centerbutton(sender: AnyObject) {
        loadRequest("https://www.currencymood.com/bancos")
    }
    @IBAction func rightbutton(sender: AnyObject) {
        loadRequest("https://www.currencymood.com/contacto")
    }
 


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

