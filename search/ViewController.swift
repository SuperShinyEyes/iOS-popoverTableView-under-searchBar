//
//  ViewController.swift
//  search
//
//  Created by Park Seyoung on 25/07/16.
//  Copyright © 2016 Park Seyoung. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPopoverPresentationControllerDelegate, UISearchBarDelegate {
    
    
    var popoverViewAnchor: CGPoint {
        if UIDevice.currentDevice().orientation.isPortrait {
            let y = self.navigationController!.navigationBar.frame.height + self.searchBar.bounds.height * 1.5
            return CGPoint(x: self.searchBar.bounds.midX, y: y)
        } else {
            let y = self.navigationController!.navigationBar.frame.height + self.searchBar.bounds.height
            return CGPoint(x: self.searchBar.bounds.midX, y: y)
        }
    }
    
    var popoverView: ExamplePopoverController?
    
    var isPopoverViewOn = false {
        didSet {
            if isPopoverViewOn == false {
                view.endEditing(true)
            }
        }
    }
    
    func showPopoverView(){
        popoverView = ExamplePopoverController()
        popoverView!.modalPresentationStyle = .Popover
        
        let popoverViewController = popoverView!.popoverPresentationController
        popoverViewController?.permittedArrowDirections = .Up
        popoverViewController?.delegate = self
        popoverViewController?.sourceView = contentViewController.view
        popoverViewController?.backgroundColor = UIColor.orangeColor()
        
        popoverViewController?.sourceRect = CGRect(
            x: popoverViewAnchor.x ?? 430,
            y: popoverViewAnchor.y ?? 430,
            width: 1,
            height: 1)
        presentViewController(
            popoverView!,
            animated: true,
            completion: nil)
        
        isPopoverViewOn = true
        
    }
    
    
    // Called when the searchBar becomes the first responder
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        
        print("searchBarTextDidBeginEditing")
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        if !isPopoverViewOn {
            showPopoverView()
        }
        popoverView?.searchKeyword = searchText
        popoverView?.setTableViewHeight()
        popoverView?.tableView.reloadData()
    }
    
    func dismissPopoverView(){
        self.dismissViewControllerAnimated(true) { [weak self] in
            self?.popoverView?.dismissViewControllerAnimated(true, completion: nil)
        }
        //        popoverView?.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        print("searchBarSearchButtonClicked")
        self.searchBar.resignFirstResponder()
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        self.searchBar.resignFirstResponder()
        self.searchBar.text = ""
        dismissPopoverView()
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
        self.hideKeyboardWhenTappedAround()
        // Do any additional setup after loading the view, typically from a nib.
        searchBar.delegate = self
        //        NSNotificationCenter.defaultCenter().addObserver(self, selector:Selector("keyboardWillDisappear:"), name: UIKeyboardWillHideNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "rotated", name: UIDeviceOrientationDidChangeNotification, object: nil)
    }
    
    func keyboardWillDisappear(notification: NSNotification){
        print("Keyboard disappeared!")
    }
    
    func popoverPresentationControllerShouldDismissPopover(popoverPresentationController: UIPopoverPresentationController) -> Bool {
        isPopoverViewOn = false
        return true
    }
    
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    func rotated() {
        print("navbar height: \(self.navigationController!.navigationBar.frame.height)")
        print("searchbar height: \( self.searchBar.bounds.height)")
        print("self.searchBar.bounds.midX: \( self.searchBar.bounds.midX)")
        guard popoverView != nil else { return }
        let popoverViewController = popoverView!.popoverPresentationController
        popoverViewController?.sourceRect = CGRect(
            x: popoverViewAnchor.x ?? 430,
            y: popoverViewAnchor.y ?? 430,
            width: 1,
            height: 1)
        if UIDevice.currentDevice().orientation.isPortrait {
            
        } else {
            
        }
    }
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

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
}

extension UIViewController {
    
}