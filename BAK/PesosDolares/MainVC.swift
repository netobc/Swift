//
//  MainVC.swift
//  PesosDolares
//
//  Created by Ernesto De La Trinidad Vidana on 9/18/16.
//  Copyright © 2016 Neto's Co. All rights reserved.
//

import UIKit
import Firebase
import SwiftKeychainWrapper

class MainVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var segmented: UISegmentedControl!
    
    var posts = [Post]()
    static var imagecache: NSCache<NSString, UIImage> = NSCache()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableview.delegate = self
        tableview.dataSource = self

        DataServices.ds.REF_BANKS.observe(.value, with: {(snapshot) in
            
                self.posts = [] // THIS IS THE NEW LINE
                
                if let snapshot = snapshot.children.allObjects as? [FIRDataSnapshot] {
                    for snap in snapshot {
                        print("SNAP: \(snap)")
                        if let postDict = snap.value as? Dictionary< String, AnyObject> {
                            let key = snap.key
                            let post = Post(snapID: key, postData: postDict)
                            print("SNAPi: \(post.idBank)")
                            self.posts.append(post)
                        }
                    }
                }
                self.tableview.reloadData()
        })
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
        
    }
    
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let post = posts[indexPath.row]
        
        if let cell = tableview.dequeueReusableCell(withIdentifier: "CasaCell") as? ItemCell {
            cell.request?.cancel()
            
            if let img = MainVC.imagecache.object(forKey: post.img as NSString) {
                cell.configureCell(post: post, img: img)
            } else {
                cell.configureCell(post: post)
            }
            
            
            return cell
        }else {
            return ItemCell()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    
    @IBAction func SingOutTapped(_ sender: AnyObject) {
        let resultado = KeychainWrapper.defaultKeychainWrapper().removeObjectForKey(KEY_UID)
        print ("Neto: \(resultado)")
        try! FIRAuth.auth()?.signOut()
        performSegue(withIdentifier: "GoToLogIn", sender: nil)
    }


}
