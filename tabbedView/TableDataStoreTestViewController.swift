//
//  TableDataStoreTestViewController.swift
//  tabbedView
//
//  Created by ジエーンポール ソリバ on 2/12/15.
//  Copyright (c) 2015 ジエーンポール ソリバ. All rights reserved.
//

import UIKit

class TableDataStoreTestViewController: UIViewController, UITableViewDataSource {

    let people = [
        ("mami", "dina"),
        ("baby", "daena"),
        ("daddy", "jeane")
    ]
    
    var counter = 0
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return people.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
//        cell.textLabel?.text = "\(counter): test"
        
        var (role, name) = people[indexPath.row]
        counter++
        cell.textLabel?.text = "\(counter): \(name)"
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
}
