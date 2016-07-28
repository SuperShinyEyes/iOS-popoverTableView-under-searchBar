//
//  ExamplePopoverController.swift
//  search
//
//  Created by Park Seyoung on 27/07/16.
//  Copyright © 2016 Park Seyoung. All rights reserved.
//

import UIKit

class ExamplePopoverController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var tableView = UITableView()
    let animals = ["Dog", "cat", "pigeon", "lion", "buffalow"]
    var popoverViewWidth: CGFloat?
    var bounds: CGRect?
    var searchKeyword: String?
    var filteredAnimals: [String] {
        return animals.filter{ $0.lowercaseString.containsString(searchKeyword!.lowercaseString) }
    }
    
    func setTableViewHeight() {
        let tableHeight: CGFloat = CGFloat(filteredAnimals.count) * 44
        print("tableHeight: \(tableHeight)")
        print("    CGFloat(filteredAnimals.count): \(CGFloat(filteredAnimals.count))")
        print("    tableView.rowHeight: \(tableView.rowHeight)")
        
        self.preferredContentSize = CGSize(width: popoverViewWidth!, height: tableHeight)
        tableView.frame = CGRectMake(tableView.frame.origin.x, tableView.frame.origin.y, tableView.frame.width, tableHeight)
        
    }
    
    
    override func viewDidLoad() {
//        self.preferredContentSize.width
        popoverViewWidth = self.preferredContentSize.width
            //self.view.frame.width
        //        let bounds = self.bounds ?? UIScreen.mainScreen().bounds
        tableView = UITableView(frame: self.view.frame, style: UITableViewStyle.Plain)
        tableView.delegate      =   self
        tableView.dataSource    =   self
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.view.addSubview(tableView)
    }
    
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("\(filteredAnimals), filteredAnimals.count: \(filteredAnimals.count)")
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
