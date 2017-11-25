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
        phaseTwo()
        self.timerStart()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var alertView:TitleView = {

        
        let m = TitleView(title: "heads up", viewRadius: 20, containsCenterLabel: true, centerText: "unk", draws: true)
        m.label.textColor = .white
        m.centerLabel.numberOfLines = 3
        m.centerLabel.font = UIFont.init(customFont: .MavenProBold, withSize: 20)
        m.label.textAlignment = .center
        return m
    }()
    

    let dismissLabel:GPLabel = {
        let g = GPLabel()
        g.backgroundColor = UIColor.clear
        g.textColor = UIColor.white
        g.textAlignment = .center
        g.text = "ok"
        g.font = UIFont.init(customFont: .MavenProBold, withSize: 20)
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
    
    var stack:UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.spacing = 20
        stack.axis = .vertical
        return stack
    }()
    
    func phaseTwo() {
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.dismissAlert)))
        self.backgroundColor = UIColor.boxTitleColor.withAlphaComponent(0.9)
        self.addSubview(stack)
        stack.addArrangedSubview(alertView)
        stack.addArrangedSubview(dismissLabel)
        
        NSLayoutConstraint.activate([
            stack.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            stack.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            stack.widthAnchor.constraint(equalToConstant: 200),
            stack.heightAnchor.constraint(equalToConstant: 400),
            alertView.heightAnchor.constraint(equalTo: stack.heightAnchor, multiplier: 1/2),
            dismissLabel.heightAnchor.constraint(equalTo: stack.heightAnchor, multiplier: 1/2)
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
