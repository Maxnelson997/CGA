//
//  MenuActions.swift
//  College Weighted Average Grade Calculator
//
//  Created by Max Nelson on 11/24/17.
//  Copyright © 2017 AsherApps. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseCore

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
            var ref: DatabaseReference!
    var feedbackView:FeedbackView!
    
    @objc func feedback() {
        feedbackView = FeedbackView()
        deli.main_controller.view.addSubview(feedbackView)
        
        feedbackView.s0.addTarget(self, action: #selector(self.sendFeedback(sender:)), for: .touchUpInside)
        feedbackView.s1.addTarget(self, action: #selector(self.sendFeedback(sender:)), for: .touchUpInside)
        feedbackView.s2.addTarget(self, action: #selector(self.sendFeedback(sender:)), for: .touchUpInside)
    }
    
    @objc func sendFeedback(sender:UIButton) {
        var message:String = feedbackView.message
        var satisfaction:CGFloat!
//        var satisfactionRatio:CGFloat!
    
        switch sender.tag {
        case 0:
            satisfaction = 1
//            satisfactionRatio = 3/3 //frown
        case 1:
            satisfaction = 2
//            satisfactionRatio = 2/3 //hmm
        case 2:
            satisfaction = 3
//            satisfactionRatio = 1/3 //smile
        default:
            break
        }
    
        if message == "tap here to tell us here what you want to see differently then choose an emoji matching how you feel about this app. or just tap an emoji." {
            message = "no written feedback."
        }
        
        ref = Database.database().reference()
      
//        self.ref.child("cgafeedback").childByAutoId()
//        self.ref.child("cgafeedback").setValuesForKeys(["message":message, "satisfaction":satisfaction])
     
        let key = ref.child("cgafeedback").childByAutoId().key
        let post = ["message": message,
                    "satisfaction": satisfaction] as [String : Any]
        let childUpdates = ["/cgafeedback/\(key)": post]
        ref.updateChildValues(childUpdates)
//        self.db.child("users").child(uid!).updateChildValues(["scanHistory":Model.instance.userSettings.getScanHistoryArray()])
//        ref.database.setValue(["message":message, "satisfaction":satisfaction], forKey: "cgafeedback")
        //request with feedback
        //satisfactionRequestse params being -> ?message=message&satisfaction=satisfaction&satisfactionRatio=satisfactionRatio
     
    }
    
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


