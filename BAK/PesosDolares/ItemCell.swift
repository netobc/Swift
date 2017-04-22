//
//  ItemCell.swift
//  PesosDolares
//
//  Created by Ernesto De La Trinidad Vidana on 11/17/16.
//  Copyright © 2016 Neto's Co. All rights reserved.
//

import UIKit
import Alamofire

class ItemCell: UITableViewCell {

    @IBOutlet weak var thumb: UIImageView!
    @IBOutlet weak var Title: UILabel!
    @IBOutlet weak var compra: UILabel!
    @IBOutlet weak var venta: UILabel!
    @IBOutlet weak var distancia: UILabel!
    
    var post: Post!
    var request : Request?

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureCell(post: Post, img: UIImage? = nil) {
        self.post = post
        self.compra.text = "$\(String(format: "%.2f", post.compra))"
        self.venta.text = "$\(String(format: "%.2f", post.venta))"
        self.Title.text = "Banco \(post.snapID)"

            if img != nil {
                self.thumb.image = img
            }else{
                
                Alamofire.request(post.img).response { response in // method defaults to `.get`
                    let neto = "http://www.pesosdolares.com/\(response.request!)"
                    //print(response.data)
//                    if let imgData = response.data {
//                        if let img = UIImage(data: imgData) {
//                            self.thumb.image = img
//                            MainVC.imagecache.setObject(img, forKey: post.img as NSString)
//                        }
//                    }
                    
                    if let url = NSURL(string: neto) {
                        if let data = NSData(contentsOf: url as URL) {
                            self.thumb.image = UIImage(data: data as Data)
                            MainVC.imagecache.setObject(self.thumb.image!, forKey: post.img as NSString)
                        }        
                    }
                    
                
                }

            }
       
    }
}
