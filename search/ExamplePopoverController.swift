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
    var popoverViewWidth: CGFloat { return self.preferredContentSize.width }
    var searchKeyword: String = ""
    
    var filteredAnimals: [String] {
        return animals.filter{ $0.lowercaseString.containsString(searchKeyword.lowercaseString) }
    }
    var tableHeight: CGFloat {
        return CGFloat(filteredAnimals.count) * 44
    }
    
    var newPopoverViewFrameSize: CGSize {
        return CGSize(width: popoverViewWidth, height: tableHeight)
    }
    
    var newTableViewFrame: CGRect {
        return CGRectMake(self.view.bounds.origin.x, self.view.bounds.origin.y, self.view.bounds.width, tableHeight)
        //        return CGRectMake(tableView.bounds.origin.x, tableView.bounds.origin.y, tableView.bounds.width, tableHeight)
        //        return CGRectMake(tableView.frame.origin.x, tableView.frame.origin.y, tableView.frame.width, tableHeight)
    }
    
    func setTableViewHeight() {
        self.preferredContentSize = newPopoverViewFrameSize
        tableView.frame = newTableViewFrame
        print(self.popoverPresentationController?.arrowDirection)
    }
    
    
    override func viewDidLoad() {
        //        let frame = CGRectMake(self.view.frame.minX-self.view.frame.width/2, self.view.frame.minY, self.view.frame.width, self.view.frame.height)
        //        self.view.bounds.origin.x -
        //        CGRectMake(self.view.bounds.origin.x, self.view.bounds.origin.y, self.view.bounds.width, tableHeight)
        let frame = newTableViewFrame
        //        let frame = CGRectMake(self.view.bounds.origin.x,
        //                               self.view.bounds.origin.y,
        //                               self.view.bounds.width,
        //                               tableHeight)
        //        let frame = CGRectMake(self.view.center.x - self.view.bounds.width / 2,
        //                               self.view.bounds.minY,
        //                               self.view.bounds.width,
        //                               self.view.bounds.height)
        //        tableView = UITableView(frame:self.view.frame, style: UITableViewStyle.Plain)
        tableView = UITableView(frame:frame, style: UITableViewStyle.Plain)
        //        tableView = UITableView(frame:self.view.bounds, style: UITableViewStyle.Plain)
        tableView.delegate = self
        tableView.dataSource = self
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
