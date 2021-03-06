//
//  Post.swift
//  PesosDolares
//
//  Created by Ernesto De La Trinidad Vidana on 11/21/16.
//  Copyright © 2016 Neto's Co. All rights reserved.
//

import Foundation

class Post{
    fileprivate var _compra: Float!
    fileprivate var _venta: Float!
    fileprivate var _mainURL: String!
    fileprivate var _id: String!
    fileprivate var _img: String!
    fileprivate var _snapID : String!
    
    var compra: Float {
        return _compra
    }
    
    var venta: Float {
        return _venta
    }
    
    var mainURL: String {
        return _mainURL
    }
    
    var idBank: String {
        return _id
    }
    
    var img: String {
        return _img
    }
    
    var snapID: String {
        return _snapID
    }
    
    init (compra: Float, venta: Float, mainURL: String, idBank: String, img: String){
        self._compra = compra
        self._venta = venta
        self._id = idBank
        self._mainURL = mainURL
        self._img = img
    }
    
    init (snapID: String, postData: Dictionary<String, AnyObject>)
    {
        self._snapID = snapID
        
        if let compra = postData["Compra"] as? Float {
            self._compra = compra
        }
        
        if let venta = postData["Venta"] as? Float {
            self._venta = venta
        }
        
        if let mainURL = postData["bankURL"] as? String {
            self._mainURL = mainURL
        }
        
        if let idBank = postData["id"] as? String {
            self._id = idBank
        }
        
        if let img = postData["imageUrl"] as? String {
            self._img = img
        }
        
    }
    
}

