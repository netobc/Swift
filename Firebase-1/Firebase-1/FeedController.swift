//
//  FeedController.swift
//  Firebase-1
//
//  Created by Ernesto De La Trinidad Vidana on 5/21/16.
//  Copyright © 2016 NetoCo. All rights reserved.
//

import UIKit
import Firebase

class FeedController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    var posts = [Post]()
    static var imageCache = NSCache()

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.estimatedRowHeight = 200
        
        DataService.ds.RefBanks.observe(.value, with: {snapshot in
        print(snapshot?.value)
            self.posts = []
            
            if let snapshots = snapshot?.children.allObjects as? [FDataSnapshot] {
            
                for snap in snapshots {
                    print("SNAP: \(snap)")
                    
                    if let postDict = snap.value as? Dictionary<String, AnyObject> {
                        let key = snap.key
                        let post = Post(postkey: key!, dictionary: postDict)
                        self.posts.append(post)
                        
                    }
                }
            }
            
            self.tableView.reloadData()
        })
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let post = posts[(indexPath as NSIndexPath).row]
        print(post.Bcompra)
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell") as? PostCellTableViewCell {
            
            cell.request?.cancel()
            var img: UIImage?
            
            let url = post.imageUrl
                img = FeedController.imageCache.object(forKey: "https://www.currencymood.com/\(url)") as? UIImage
            
            
            cell.configureCell(post, img: img)
            return cell
        } else{
            return PostCellTableViewCell()
        }

    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }

}
