//
//  ExamplePopoverController.swift
//  search
//
//  Created by Park Seyoung on 27/07/16.
//  Copyright © 2016 Park Seyoung. All rights reserved.
//

import UIKit

class ExamplePopoverController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    //class ExamplePopoverController: UIViewController {
    var tableView = UITableView()
    let animals = ["Dog", "cat", "pigeon", "lion", "buffalow"]
    var bounds: CGRect?
    var searchKeyword: String?
    var filteredAnimals: [String] {
        return animals.filter{ $0.lowercaseString.containsString(searchKeyword!) }
    }
    
    
    override func viewDidLoad() {
        let bounds = self.bounds ?? UIScreen.mainScreen().bounds
        tableView = UITableView(frame: bounds, style: UITableViewStyle.Plain)
        tableView.delegate      =   self
        tableView.dataSource    =   self
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.view.addSubview(tableView)
    }
    
    override func viewDidAppear(animated: Bool) {
        <#code#>
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredAnimals.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "cell")
        cell.textLabel!.text = filteredAnimals[indexPath.row]
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print(filteredAnimals[indexPath.row])
    }
    
    
}
