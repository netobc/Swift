//
//  FIRmapLoc.swift
//  PesosDolares
//
//  Created by Ernesto De La Trinidad Vidana on 4/6/17.
//  Copyright © 2017 Neto's Co. All rights reserved.
//

import Foundation

class FIRmapLoc{
    fileprivate var _latitud: Float!
    fileprivate var _longitud: Float!
    fileprivate var _snapID : String!
    
    var latitud: Float {
        return _latitud
    }
    
    var longitud: Float {
        return _longitud
    }
    var snapID: String {
        return _snapID
    }

    
    init (latitud: Float, longitud: Float){
        self._latitud = latitud
        self._longitud = longitud

    }
    
    init (snapID: String, postData: Dictionary<String, AnyObject>)
    {
        self._snapID = snapID
        
        if let latitud = postData["l"] as? Float {
            self._latitud = latitud
        }
        
        if let longitud = postData["1"] as? Float {
            self._longitud = longitud
        }

        
    }
    
}

