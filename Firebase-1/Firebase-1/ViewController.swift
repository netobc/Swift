//
//  ViewController.swift
//  Firebase-1
//
//  Created by Ernesto De La Trinidad Vidana on 5/14/16.
//  Copyright © 2016 NetoCo. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit

class ViewController: UIViewController {
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
    }
    
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }

    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if UserDefaults.standard.value(forKey: KEY_UID) != nil{
            self.performSegue(withIdentifier: SEGUE_LOG_IN, sender: nil)
        }
    }

    @IBAction func FBButtonPressed (_ sender: UIButton!){
        let facebookLogin = FBSDKLoginManager()
        facebookLogin.logIn(withReadPermissions: ["email"]) { (facebookResult:FBSDKLoginManagerLoginResult!, facebookError:NSError!) in
            if facebookError != nil{
                print ("Facebook login fail. Error \(facebookError)")
            }else{
                let accessToken = FBSDKAccessToken.current().tokenString
                print("Successfully logged in with Facebook. \(accessToken)")
                
                DataService.ds.RefBase.auth(withOAuthProvider: "facebook", token: accessToken, withCompletionBlock: {error, authData in
                    if error != nil{
                        print ("Login failed! \(error)")
                    } else {
                        print ("Great!\(authData)")
                        
                        let user = ["provider": authData.provider!, "blah":"test"]
                        DataService.ds.createFirebaseUser(authData.uid, user: user)
                        
                        UserDefaults.standard.setValue(authData.uid, forKey: KEY_UID)
                        self.performSegue(withIdentifier: SEGUE_LOG_IN, sender: nil)
                    }
                })
            }
        }
    }
    
    @IBAction func attemptlogin (_ sender: UIButton!){
        
        dismissKeyboard()
        
        if let email =  emailField.text , email != "", let pwd = passwordField.text , pwd != "" {
            
            DataService.ds.RefBase.authUser(email, password: pwd, withCompletionBlock:{error, authData in
                if error != nil {
                    print(error)
                    
                    if error.code == STATUS_ACCOUNT_NOEXIST {
                        DataService.ds.RefBase.createUser(email, password: pwd, withValueCompletionBlock: {error, result in
                            
                            if error != nil {
                                self.showerrorAlert("Could not create Account!", msg: "Problem creating the code :(")
                            } else {
                                UserDefaults.standard.setValue(result?[KEY_UID], forKey: KEY_UID)
                                
                                
                                DataService.ds.RefBase.authUser(email, password: pwd, withCompletionBlock: {err,authData in
                                
                                    let user = ["provider": authData?.provider!, "blah":"emailtest"]
                                    DataService.ds.createFirebaseUser(authData.uid, user: user)
                                
                                })
                                self.performSegue(withIdentifier: SEGUE_LOG_IN, sender: nil)
                            }
                            
                        })
                    }
                    
                    if error.code == STATUS_PASSWORD_WRONG {
                        if error != nil {
                            self.showerrorAlert("Wrong passoword!", msg: "Try again.")
                        }
                    }
                    
                }
                else{
                    
                    self.performSegue(withIdentifier: SEGUE_LOG_IN, sender: nil)
                    
                }
                
            })
            
            
            
        } else {
            showerrorAlert("Email and password required.", msg: "You must enter email/Password")
        }
    }
    
    func showerrorAlert (_ title: String, msg: String){
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        let action =  UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        present(alert,animated: true,completion: nil)
        
    }

}

