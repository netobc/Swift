//
//  Post.swift
//  Firebase-1
//
//  Created by Ernesto De La Trinidad Vidana on 5/28/16.
//  Copyright © 2016 NetoCo. All rights reserved.
//

import Foundation
import Firebase

class Post {
    fileprivate var _bankID: String!
    fileprivate var _Bcompra: String!
    fileprivate var _Bventa: String!
    fileprivate var _imageUrl: String!
    fileprivate var _bankUrl: String!
    fileprivate var _postkey: String!
    
    var bankID: String {
        return _bankID
    }
    
    var imageUrl: String {
        return _imageUrl
    }
    
    var Bcompra: String! {
        return _Bcompra
    }
    
    var Bventa: String! {
        return _Bventa
    }
    
    var bankUrl: String {
        return _bankUrl
    }
    
    init(description: String, imagerUrl: String, bankUrl: String, bankVenta: String, bankCompra: String){
        self._bankID = description
        self._imageUrl = imagerUrl
        self._bankUrl = bankUrl
        self._Bcompra = bankCompra
        self._Bventa = bankVenta
    }
    
    init(postkey: String, dictionary: Dictionary <String, AnyObject>){
        self._postkey = postkey
        
        if let bankUrl = dictionary["bankURL"] as? String {
            self._bankUrl = bankUrl
        }
        
        if let imageUrl = dictionary["imageUrl"] as? String {
            self._imageUrl = imageUrl
        }
        
        if let desc = dictionary["id"] as? String {
            self._bankID = desc
        }
        
        if let compra = dictionary["Compra"] as? String {
            self._Bcompra =  "\(compra)"
        }
        
        if let venta = dictionary["Venta"] as? String {
            self._Bventa = "\(venta)"
        }
        
        
        
    }
}
