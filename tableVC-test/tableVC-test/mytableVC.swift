//
//  mytableVC.swift
//  tableVC-test
//
//  Created by Ernesto De La Trinidad Vidana on 4/23/16.
//  Copyright © 2016 NetoCo. All rights reserved.
//

import UIKit

class mytableVC: UITableViewController {
    
    var cars = ["BMW","Ford","Chevy","Volvo","Subaru"]

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }


    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return cars.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("netoek", forIndexPath: indexPath)

        cell.textLabel?.text = cars[indexPath.row]
        cell.detailTextLabel?.text = "I like my \(cars[indexPath.row])"

        return cell
    }


}
