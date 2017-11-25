//
//  alert.swift
//  College Weighted Average Grade Calculator
//
//  Created by Max Nelson on 11/24/17.
//  Copyright © 2017 AsherApps. All rights reserved.
//

import UIKit

class Alert:UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        phaseTwo()
    }
    
    func timerStart() {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + self.duration) {
            self.dismissAlert()
        }
    }
    
    var duration:Double!
    
    init(title:String, message:String, duration:Double = 4) {
        super.init(frame: UIScreen.main.bounds)
        self.duration = duration
        self.alertTitle = title
        self.alertMessage = message
        self.timerStart()
        phaseTwo()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var alertView:TitleView = {
        let m = TitleView(title: "heads up", viewRadius: 23, containsCenterLabel: true, centerText: "this is an alert boi.")
//        m.label.font = UIFont.init(customFont: .MavenProRegular, withSize: 20)
//        m.label.numberOfLines = 3
        return m
    }()
    
    let dismissLabel:GPLabel = {
        let g = GPLabel()
        g.backgroundColor = UIColor.clear
        g.textColor = UIColor.boxTitleColor
        g.textAlignment = .center
        g.text = "ok"
        g.font = UIFont.init(customFont: .MavenProBold, withSize: 25)
        return g
    }()
    
    @objc func dismissAlert() {
        UIView.animate(withDuration: 0.2) {
            self.alpha = 0
        }
        UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 4, initialSpringVelocity: 5, options: .curveEaseOut, animations: {
            self.alertView.transform = CGAffineTransform(translationX: 0, y: 200)
            self.alpha = 0
        }) { (true) in
            self.removeFromSuperview()
        }
    }
    
    func phaseTwo() {
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.dismissAlert)))
        self.backgroundColor = UIColor.boxTitleColor.withAlphaComponent(0.9)
        self.addSubview(alertView)
        self.addSubview(dismissLabel)
        NSLayoutConstraint.activate([
            alertView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            alertView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            alertView.widthAnchor.constraint(equalToConstant: 250),
            alertView.heightAnchor.constraint(equalToConstant: 250),
            
            dismissLabel.topAnchor.constraint(equalTo: alertView.bottomAnchor, constant: 10),
            dismissLabel.widthAnchor.constraint(equalTo: alertView.widthAnchor, multiplier: 1),
            dismissLabel.heightAnchor.constraint(equalToConstant: 50)
            ])
        
    }
    
    var alertTitle:String {
        get {
            return alertView.label.text!
        }
        set {
            alertView.label.text = newValue
        }
    }
    
    var alertMessage:String {
        get {
            return alertView.centerLabel.text!
        }
        set {
            alertView.centerLabel.text = newValue
        }
    }
    
}
