//
//  ViewController.swift
//  search
//
//  Created by Park Seyoung on 25/07/16.
//  Copyright © 2016 Park Seyoung. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPopoverPresentationControllerDelegate, UISearchBarDelegate {
    
    
    var searchBarCGPointForArrow: CGPoint {
        let y = self.navigationController!.navigationBar.frame.height + self.searchBar.bounds.height * 1.5
        return CGPoint(x: self.searchBar.bounds.midX, y: y)
    }
    
    var searchBarBounds: CGRect { return searchBar.bounds }
    
    var popoverView: ExamplePopoverController?
    
    func showPopoverView(){
        popoverView = ExamplePopoverController()
        popoverView!.modalPresentationStyle = .Popover
//        popoverView!.bounds = searchBarBounds
        popoverView!.searchKeyword = "lion"
        
        let popoverViewController = popoverView!.popoverPresentationController
        
        popoverViewController?.permittedArrowDirections = .Any
        popoverViewController?.delegate = self
        popoverViewController?.sourceView = contentViewController.view
        
        popoverViewController?.sourceRect = CGRect(
            x: searchBarCGPointForArrow.x ?? 430,
            y: searchBarCGPointForArrow.y ?? 430,
            width: 1,
            height: 1)
        presentViewController(
            popoverView!,
            animated: true,
            completion: nil)
    }
    
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        showPopoverView()
        print("searchBarTextDidBeginEditing")
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        //        guard popoverView != nil else { return }
        popoverView?.searchKeyword = searchText
        popoverView?.setTableViewHeight()
        //        let popoverViewFrame = popoverView?.popoverPresentationController?.sourceView view.frame
        //        let tableHeight: CGFloat = CGFloat((popoverView?.filteredAnimals.count)!) * 44
        //        popoverView?.view.frame = CGRectMake(popoverViewFrame!.origin.x, popoverViewFrame!.origin.y, popoverViewFrame!.width, tableHeight)
        //        self.view.frame = CGRectMake(tableView.frame.origin.x, tableView.frame.origin.y, tableView.frame.width, tableHeight)
        popoverView?.tableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        print("searchBarSearchButtonClicked")
        self.searchBar.resignFirstResponder()
        
        
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        self.searchBar.resignFirstResponder()
        self.searchBar.text = ""
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "Show Popover" {
            
            let popoverViewController = segue.destinationViewController as! ExamplePopoverController
            popoverViewController.popoverPresentationController?.delegate = self
            print("prepareForSegue")
            //            popoverViewController.bounds = self.searchBar.bounds
            //            popoverViewController.searchKeyword
            
        }
    }
    
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
        return .None
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        searchBar.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    
}


extension UIViewController {
    var contentViewController: UIViewController {
        if let navcon = self as? UINavigationController {
            return navcon.visibleViewController ?? navcon
        } else {
            return self
        }
    }
}