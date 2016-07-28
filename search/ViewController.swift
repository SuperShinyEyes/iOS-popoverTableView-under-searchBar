//
//  ViewController.swift
//  search
//
//  Created by Park Seyoung on 25/07/16.
//  Copyright © 2016 Park Seyoung. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPopoverPresentationControllerDelegate, UISearchBarDelegate {
    
    var location: CGPoint {
        let y = self.navigationController!.navigationBar.frame.height + self.searchBar.bounds.height * 1.5
        return CGPoint(x: self.searchBar.bounds.midX, y: y)
    }
    
    func showPopoverView(){
        let examplePopoverController = ExamplePopoverController()
        examplePopoverController.modalPresentationStyle = .Popover
        let popoverViewController = examplePopoverController.popoverPresentationController
        
        popoverViewController?.permittedArrowDirections = .Any
        popoverViewController?.delegate = self
        popoverViewController?.sourceView = contentViewController.view
        popoverViewController?.sourceRect = CGRect(
            x: location.x ?? 430,
            y: location.y ?? 430,
            width: 1,
            height: 1)
        presentViewController(
            examplePopoverController,
            animated: true,
            completion: nil)
    }
    
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        showPopoverView()
        print("searchBarTextDidBeginEditing")
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