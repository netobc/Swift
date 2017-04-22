//
//  DataService.swift
//  Firebase-1
//
//  Created by Ernesto De La Trinidad Vidana on 5/19/16.
//  Copyright © 2016 NetoCo. All rights reserved.
//

import Foundation
import Firebase

let URL_BASE = "https://amber-torch-8947.firebaseio.com"

class DataService {
    static let ds = DataService()
    fileprivate var _ref_Base = Firebase(url:"\(URL_BASE)")
    fileprivate var _ref_Banks = Firebase(url: "\(URL_BASE)/Banks")
    fileprivate var _ref_Users = Firebase(url: "\(URL_BASE)/users")
    
    var RefBase: Firebase{
        return _ref_Base!
    }
    
    var RefBanks: Firebase{
        return _ref_Banks!
    }
    
    var RefUsers: Firebase{
        return _ref_Users!
    }
    
    func createFirebaseUser(_ uid: String, user: Dictionary<String, String>){
        RefUsers.child(byAppendingPath: uid).setValue(user)
    }
}
