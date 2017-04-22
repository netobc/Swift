//
//  person.swift
//  MVCTest
//
//  Created by Ernesto De La Trinidad Vidana on 4/9/16.
//  Copyright © 2016 NetoCo. All rights reserved.
//

import Foundation

class Person {
    private var _firstname: String!
    private var _lastname: String!
    
    var firstName: String! {
        get{
            return _firstname
        }
        set {
            _firstname = newValue            
        }
    }
    
    var lastName: String {
        return _lastname
    }
    
    init(first: String, last: String){
        self._firstname = first
        self._lastname = last 
        
    }
    var fullName: String {
        return "\(_firstname) \(_lastname)"
    }
}