//
//  SignIn.swift
//  PesosDolares
//
//  Created by Ernesto De La Trinidad Vidana on 9/18/16.
//  Copyright © 2016 Neto's Co. All rights reserved.
//

import Foundation
import UIKit
import FBSDKLoginKit
import FBSDKCoreKit
import Firebase
import SwiftKeychainWrapper
import GoogleSignIn

class SignIn: UIViewController, GIDSignInUIDelegate , GIDSignInDelegate {
    
    @IBOutlet weak var GoogleTapped: GIDSignInButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(SignIn.dismissKeyboard))
        view.addGestureRecognizer(tap)
        GIDSignIn.sharedInstance().clientID = FIRApp.defaultApp()?.options.clientID
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance().uiDelegate = self
        
        
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let error = error {
            print (error.localizedDescription)
            return
        }
        let authentication = user.authentication
        let credential = FIRGoogleAuthProvider.credential(withIDToken: (authentication?.idToken)!, accessToken: (authentication?.accessToken)!)
        FIRAuth.auth()?.signIn(with: credential, completion: {(user, error) in
            if error != nil {
                print(error?.localizedDescription)
                return
            }
             print("User Logged in with Google")
        })
    }
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        if let error = error {
            print (error.localizedDescription)
            return
        }
        
        try! FIRAuth.auth()?.signOut()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if let _ = KeychainWrapper.defaultKeychainWrapper().stringForKey(KEY_UID){
            performSegue(withIdentifier: "SEGUE_LOG_IN", sender: nil)
        }
    }
    
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }

    @IBAction func FBbtnTapped(_ sender: AnyObject) {
        
        let facebooklogin = FBSDKLoginManager()
        facebooklogin.logIn(withReadPermissions: ["email"], from: self, handler: {(result, error) in
            if error != nil {
                print("Neto: Unable to Authenticate with Facebook - \(error)")
            } else if result?.isCancelled ==  true {
                print("Neto: User cancelled Facebook Auth")
            } else {
               print("Neto: Successfully authenticated with Facebook")
                let credential = FIRFacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
                self.firebaseAuth(credential)
            }
        })
    }
    


    
    func firebaseAuth(_ credential: FIRAuthCredential){
        FIRAuth.auth()?.signIn(with: credential, completion: {(user,error) in
            if error != nil {
                print("Neto: Unable to Authenticate with Firebase - \(error)")
            }  else {
                print("Neto: Successfully authenticated with Firebase")// Aqui ya se autoriza con todo!!!
                if let user = user {
                    self.completeSignIn(id: user.uid)
                }
            }
        
        })
    }
    
    
    
    func completeSignIn(id: String){
        let keychainresult = KeychainWrapper.defaultKeychainWrapper().setString(id, forKey: KEY_UID)
        print("Data saved on keychain \(keychainresult)")
        performSegue(withIdentifier: "SEGUE_LOG_IN", sender: nil)
    }
    
    func showMessagePrompt (_ msg: String){
        let alert = UIAlertController(title: "Neto", message: msg, preferredStyle: .alert)
        
        let action =  UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        present(alert,animated: true,completion: nil)
        
    }
}


