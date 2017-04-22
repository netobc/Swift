//
//  ViewController.swift
//  PesosDolares
//
//  Created by Ernesto De La Trinidad Vidana on 9/17/16.
//  Copyright © 2016 Neto's Co. All rights reserved.
//

import UIKit
import Firebase
import SwiftKeychainWrapper

class ViewController: UIViewController {

    @IBOutlet weak var EmailField: UITextField!
    @IBOutlet weak var PasswordField: UITextField!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(SignIn.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func SignInTapped(_ sender: AnyObject) {
        
        //self.showerrorAlert("Email and password required.", msg: "You must enter a correct email or Password")
        
        if let email = EmailField.text, let pwd = PasswordField.text {
            
            FIRAuth.auth()?.signIn(withEmail: email, password: pwd, completion: {(user, error) in
                if error == nil {
                    print("Neto: Email user authenticated with Firebase")
                    if let user = user {
                        self.completeSignIn(id: user.uid)
                    }
                } else {
                    FIRAuth.auth()?.createUser(withEmail: email, password: pwd, completion: {(user, error) in
                        if error != nil {
                            print("Neto: Unable to authenticate with Firebase using Firebase \(error)")
                            
                            if error.debugDescription.contains("ERROR_INVALID_EMAIL") {
                                self.showerrorAlert("Email and password required.", msg: "You must enter a correct email or Password")
                            }else if error.debugDescription.contains("MISSING_PASSWORD") {
                                self.showerrorAlert("Password field empty.", msg: "Please enter your Password")
                            }else if error.debugDescription.contains("MISSING_EMAIL") {
                                self.showerrorAlert("E-mail field empty.", msg: "Please enter your E-mail")
                            }else if error.debugDescription.contains("ERROR_WEAK_PASSWORD") {
                                self.showerrorAlert("Password too weak", msg: "The password must be 6 characters long or more")
                            }else if error.debugDescription.contains("ERROR_EMAIL_ALREADY_IN_USE") {
                                self.showerrorAlert("E-mail already in use", msg: "Check your password or try using another account")
                            }
                        } else {
                            print("Sucessfully created new user with Firebase")
                            if let user = user {
                              self.completeSignIn(id: user.uid)
                            }
                        
                        }
                    })
                }
            })
        }
        
    }
    
    func completeSignIn(_ id: String){
        let kish = KeychainWrapper.defaultKeychainWrapper().setString(id, forKey: KEY_UID)
        print("Data saves with keychain: \(kish)")
        performSegue(withIdentifier: "gotoVChilo", sender: nil)
        
    }
    
    func showerrorAlert (_ title: String, msg: String){
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        
        let action =  UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        present(alert,animated: true,completion: nil)
        
    }
}

