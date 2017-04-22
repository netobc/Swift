//
//  PostCellTableViewCell.swift
//  Firebase-1
//
//  Created by Ernesto De La Trinidad Vidana on 5/21/16.
//  Copyright © 2016 NetoCo. All rights reserved.
//

import UIKit
import Alamofire

class PostCellTableViewCell: UITableViewCell {
    
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var compralbl : UILabel!
    @IBOutlet weak var ventalbl : UILabel!
    
    var post: Post!
    var request: Request?


    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func draw(_ rect: CGRect) {
       // profileImg.layer.cornerRadius =  profileImg.frame.size.width/2
        //profileImg.clipsToBounds = true

    }

//    override func setSelected(selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }

    func configureCell(_ post: Post, img: UIImage?){
        self.post = post

        self.compralbl.text = "$\(post.Bcompra)"
        self.ventalbl.text = "$\(post.Bventa)"
        
//        self.bankname.text = post.bankID
        
        //var img : UIImage!
        
//        let url = NSURL(string: "https://www.currencymood.com/\(post.imageUrl)")!
//        print(url)
//        if let data = NSData(contentsOfURL: url){
//            img = UIImage(data: data)
//        } else{
//            img = UIImage(named: "CMlogo")
//        }
        
//        self.profileImg.image = img

            
            if img != nil {
                self.profileImg.image = img
            } else {
                
                request = Alamofire.request(.GET, "https://www.currencymood.com/\(post.imageUrl)").validate(contentType: ["image/*"]).response(completionHandler: { request, response, data, err in
                    
                    if err == nil {
                        let img = UIImage(data: data!)!
                        self.profileImg.image = img
                        FeedController.imageCache.setObject(img, forKey: "https://www.currencymood.com/\(self.post.imageUrl)")
                    }
                    
                })
                
            }
        
        

    }
    
}
