//
//  extension.swift
//  college-gpa-calculator
//
//  Created by Max Nelson on 8/7/17.
//  Copyright © 2017 Max Nelson. All rights reserved.
//

import UIKit
import Font_Awesome_Swift

enum Direction:CGFloat {
    case up = -1
    case down = 1
    case back = 0
}
extension UIView {
    func animateView(direction:Direction, distance:CGFloat) {
        UIView.animate(withDuration: 0.3) {
            self.transform = CGAffineTransform(translationX: 0, y: distance * direction.rawValue)
        }
    }
}

class StackView: UIStackView {
    private var color: UIColor?
    override var backgroundColor: UIColor? {
        get { return color }
        set {
            color = newValue
            self.setNeedsLayout() // EDIT 2017-02-03 thank you @BruceLiu
        }
    }
    
    private lazy var backgroundLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        self.layer.insertSublayer(layer, at: 0)
        return layer
    }()
    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundLayer.path = UIBezierPath(rect: self.bounds).cgPath
        backgroundLayer.fillColor = self.backgroundColor?.cgColor
    }
}
enum CustomFont: String {
    case MavenProRegular = "MavenPro-Regular"
    case MavenProBlack = "MavenPro-Black"
    case MavenProBold = "MavenPro-Bold"
    case MavenProMedium = "MavenPro-Medium"
}

extension UIFont {
    convenience init?(customFont: CustomFont, withSize size: CGFloat) {
        self.init(name: customFont.rawValue, size: size)
    }
}

extension UIColor {
//    open class var topBloo1: UIColor { return UIColor.init(rgb: 0xDDFAFF) }
//    open class var bottomBloo: UIColor { return UIColor.init(rgb: 0xFFFFFF) }
//    open class var bottomBloo: UIColor { return UIColor.init(rgb: 0xDBEEFF) }
    

    
    open class var headerColor: UIColor {  if !GPModel.sharedInstance.dtheme { return UIColor.init(rgb: 0xDDFAFF/*0x9BE8FF*/) } ; return UIColor.init(rgb: 0x00D9FF) }
    open class var headerText: UIColor { if !GPModel.sharedInstance.dtheme { return UIColor.darkGray } ; return .black }
//    open class var bgTop:UIColor { return UIColor.init(rgb: 0xDDFAFF ) }
//    open class var bgBottom:UIColor { return UIColor.init(rgb: 0x00D9FF ) }
    open class var bgTop:UIColor { if !GPModel.sharedInstance.dtheme { return UIColor.init(rgb: 0xDDFAFF ) } ; return UIColor.darkGray.withAlphaComponent(1) }
    open class var bgBottom:UIColor { if !GPModel.sharedInstance.dtheme { return UIColor.init(rgb: 0x00D9FF ) } ; return UIColor.darkGray.withAlphaComponent(0.5)
    }
    
    open class var boxTop:UIColor { if !GPModel.sharedInstance.dtheme { return UIColor.white.withAlphaComponent(0.9) } ; return UIColor.white.withAlphaComponent(0.9) }
    open class var boxBottom:UIColor { if !GPModel.sharedInstance.dtheme { return UIColor.white.withAlphaComponent(0.8)} ; return UIColor.init(rgb: 0xDDFAFF) }
    open class var boxTextColor:UIColor { if !GPModel.sharedInstance.dtheme { return UIColor.darkGray } ; return .darkGray }
    open class var boxTitleColor:UIColor { if !GPModel.sharedInstance.dtheme { return UIColor.darkGray } ; return .white  } //0x00D9FF bloo
    open class var boxShadowColor:UIColor { if !GPModel.sharedInstance.dtheme { return UIColor.darkGray } ; return UIColor.gray.withAlphaComponent(0.2) }
    
    open class var cellTextColor:UIColor { if !GPModel.sharedInstance.dtheme { return UIColor.init(rgb: 0xFFFFFF) } ; return .white }
    open class var cellColor:UIColor { if !GPModel.sharedInstance.dtheme { return UIColor.init(rgb: 0x232020).withAlphaComponent(0.54) } ; return UIColor.init(rgb: 0x232020).withAlphaComponent(0.54)  }
    
    open class var cellHeaderColor:UIColor { if !GPModel.sharedInstance.dtheme { return UIColor.init(rgb: 0x232020).withAlphaComponent(0.54).withAlphaComponent(0.3) } ; return UIColor.init(rgb: 0x00D9FF)  }
    
    
    

    
    
}

func iconView(type:FAType, color:UIColor = UIColor.boxTextColor) -> UIButton {
    let containerButton = UIButton()
    let b = UIButton()
    b.titleLabel?.adjustsFontSizeToFitWidth = true
    b.translatesAutoresizingMaskIntoConstraints = false
    b.backgroundColor = UIColor.boxBottom
    b.layer.cornerRadius = 15
    
    containerButton.addSubview(b)
    b.setFAIcon(icon: type, iconSize: 35, forState: .normal)
    b.setFATitleColor(color: color)
    
    NSLayoutConstraint.activate([
        b.topAnchor.constraint(equalTo: containerButton.topAnchor, constant: 10),
        b.bottomAnchor.constraint(equalTo: containerButton.bottomAnchor, constant: -10),
        b.widthAnchor.constraint(equalToConstant: 50),
        b.centerXAnchor.constraint(equalTo: containerButton.centerXAnchor, constant: 15),
        containerButton.heightAnchor.constraint(equalToConstant: 70),
        containerButton.widthAnchor.constraint(equalToConstant: 70)
        ])
    
    return containerButton
}

func emojiBro(emoji:String) -> UIButton {
    let b = UIButton()
    b.backgroundColor = UIColor.clear
    b.layer.cornerRadius = 15
    let e = UILabel()
    e.font = UIFont.init(customFont: .MavenProBold, withSize: 35)
    e.adjustsFontSizeToFitWidth = true
    e.translatesAutoresizingMaskIntoConstraints = false
    e.backgroundColor = .clear
    e.layer.cornerRadius = 15
    e.text = emoji
    e.textAlignment = .center
    
    b.addSubview(e)
    NSLayoutConstraint.activate(e.getConstraintsOfView(to: b))
    
    return b
}

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }
}

extension UIView {
    func addDropShadowToView(){
        self.layer.masksToBounds =  false
        self.layer.shadowColor = UIColor.boxShadowColor.cgColor
        self.layer.shadowOffset = CGSize(width: 8.0, height: 11.0)
        self.layer.shadowOpacity = 0.8
        self.layer.shadowRadius = 5
    }
}

extension UILabel {
    func animate(toText:String) {
        UIView.animate(withDuration: 0.3, animations: {
            self.alpha = 0
        }, completion: { finished in
            self.text = toText
            UIView.animate(withDuration: 0.35, animations: {
                self.alpha = 1
            })
        })
    }
}

extension UITextField {
    func animate(toText:String) {
        UIView.animate(withDuration: 0.3, animations: {
            self.alpha = 0
        }, completion: { finished in
            self.text = toText
            UIView.animate(withDuration: 0.35, animations: {
                self.alpha = 1
            })
        })
    }
    
    func moveTextField(inView: UIView, moveDistance: Int, up: Bool)
    {
        let moveDuration = 0.3
        //movement similar to isset in php. if up true + if !up true -
        let movement: CGFloat = CGFloat(up ? -moveDistance : moveDistance)
        
        UIView.beginAnimations("animateTextField", context: nil)
        //animated way
        UIView.setAnimationBeginsFromCurrentState(true)
        //completion timer
        UIView.setAnimationDuration(moveDuration)
        //
        inView.frame = inView.frame.offsetBy(dx: 0, dy: movement)
        UIView.commitAnimations()
    }
}
