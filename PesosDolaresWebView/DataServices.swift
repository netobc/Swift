//
//  DataServices.swift
//  PesosDolares
//
//  Created by Ernesto De La Trinidad Vidana on 11/12/16.
//  Copyright © 2016 Neto's Co. All rights reserved.
//

import Foundation
import Firebase

let DB_BASE = FIRDatabase.database().reference()

class DataServices {
    static let ds = DataServices()
    
    fileprivate var _REF_BASE = DB_BASE
    fileprivate var _REF_BANKS = DB_BASE.child("Banks")
    fileprivate var _REF_BANKST = DB_BASE.child("BanksT")
    fileprivate var _REF_CASASLOC = DB_BASE.child("CasasGeoLoc")

    
    var REF_BASE: FIRDatabaseReference {
        return _REF_BASE
    }
    
    var REF_BANKS:FIRDatabaseReference {
        return _REF_BANKS
    }
    
    var REF_BANKST: FIRDatabaseReference {
        return _REF_BANKST
    }
    var REF_CASASLOC: FIRDatabaseReference {
        return _REF_CASASLOC
    }
    
//    func createFirebaseDBUser(uid: String, userData: Dictionary<String, String>){
//        REF
//    }a
    
}
