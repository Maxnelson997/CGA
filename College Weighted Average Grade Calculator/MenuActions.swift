//
//  MenuActions.swift
//  College Weighted Average Grade Calculator
//
//  Created by Max Nelson on 11/24/17.
//  Copyright © 2017 AsherApps. All rights reserved.
//

import UIKit


class Actions {
    
    init() {}
    
//    .FACircleO,
//    .FAInstagram,
//    .FAWPExplorer,
//    .FAInstagram,
//    .FAShare,
//    .FASignOut
    
    let deli = UIApplication.shared.delegate as! AppDelegate
    
    //
    
    @objc func moon() {
        //change theme
        deli.ChangeTheme()
    }
    
    @objc func instagram() {
        //guide to my instagram page on instagram
        let instagram = URL(string: "instagram://user?username=maxcodes")!
        
        if UIApplication.shared.canOpenURL(instagram) {
            UIApplication.shared.open(instagram, options: ["":""], completionHandler: nil)
        }
    }
    
    @objc func explore() {
        //guide to developer page in appstore
        openInBrowser(url: URL(string: "http://www.maxthedev.com/apps")!)
    }
    
    @objc func share() {
        //share
        let message = "This app calculates grades that are weighted. Its Lit 🔥. \n"
        let link = "http://apple.co/2BlWVT0"
        
        let activityViewController: UIActivityViewController = UIActivityViewController(activityItems: [message, link], applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = (UIApplication.shared.delegate as! AppDelegate).main_controller.menu.tb
        (UIApplication.shared.delegate as! AppDelegate).main_controller.present(activityViewController, animated: true, completion: nil)
    }
 
    @objc func exit() {
        deli.PopSide()
    }
    
    
    @objc func openInBrowser(url:URL) {
        //open in preferred browser
        //preferred browser is set in settings
        //defualt browser is safari.
        //use FAIcon for safari or chrome / preferred browser, ya feel Maxwell? ya I feel bruh. :D
        print("open in preferred browswer")
        
        var browser = "safari"
        if browser == "opera" {
            browser = "opera://open-url?url=http://"
        } else if browser == "firefox" {
            browser = "firefox://open-url?url=http://"
        } else if browser == "chrome" {
            browser = "googlechrome://"
        } else if browser == "safari" {
            browser = "safari://"
        }
        
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: ["":""], completionHandler: nil)
        } else {
            let alertController = UIAlertController(title: "Heads Up", message: "your preferred browser is not installed on your phone.", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(okAction)
            (UIApplication.shared.delegate as! AppDelegate).main_controller.present(alertController, animated: true, completion: nil)
        }
    }
    

}


