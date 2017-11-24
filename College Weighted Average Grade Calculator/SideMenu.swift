//
//  SideMenu.swift
//  College Weighted Average Grade Calculator
//
//  Created by Max Nelson on 11/22/17.
//  Copyright © 2017 AsherApps. All rights reserved.
//

import UIKit
import Font_Awesome_Swift

class IconCell:UITableViewCell {
    var iconView:UIButton = {
        let b = UIButton()
        b.titleLabel?.adjustsFontSizeToFitWidth = true
        b.translatesAutoresizingMaskIntoConstraints = false
        b.backgroundColor = UIColor.boxBottom
        b.clipsToBounds = true
        
        b.layer.cornerRadius = 15
      
        
        return b
    }()
    
    @objc func wassup() {
        print("ayy")
    }

    var icon:FAType!
    
    override func awakeFromNib() {
        self.clipsToBounds = true
        contentView.addSubview(iconView)
        iconView.setFAIcon(icon: icon, iconSize: 35, forState: .normal)
        iconView.setFATitleColor(color: UIColor.boxTextColor)
//        NSLayoutConstraint.activate(iconView.getConstraintsOfView(to: contentView, withInsets: UIEdgeInsets(top: 10, left: 33.75, bottom: -10, right: -33.75)))
        iconView.addTarget(self, action: #selector(self.wassup), for: .touchUpInside)
        NSLayoutConstraint.activate([
            iconView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            iconView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            iconView.widthAnchor.constraint(equalToConstant: 50),
            iconView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor, constant: 15)
            ])
    }
    override func prepareForReuse() {
        iconView.removeFromSuperview()
    }
}

extension SideMenu: UITableViewDelegate, UITableViewDataSource {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print("scrolling")
    }
    //datasource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return icons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "IconCell", for: indexPath) as! IconCell
        cell.icon = icons[indexPath.item]
        cell.awakeFromNib()
        cell.selectionStyle = .none
        cell.backgroundColor = .clear
 cell.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.hmm)))
        return cell
    }
    
    //delegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    
}

class SideMenu: UIView {
    var icons:[FAType] = [
        .FAThumbsUp,
        .FAInstagram,
        .FAShare,
        .FAWPExplorer,
        .FAGrav,
        .FAMeetup,
        .FAMicrochip,
        .FAGithub,
        .FASend,
        .FAUniversalAccess,
        .FAShoppingCart,
        .FAStackOverflow,
        .FASignOut
    ]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        phaseTwo()
    }
    
    init() {
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        phaseTwo()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let v = (UIApplication.shared.delegate as! AppDelegate).main_controller.view
    
    var wid:NSLayoutConstraint!
    var tbwid:NSLayoutConstraint!
    
    let label:GPLabel = {
        let g = GPLabel(withOutDraw: true)
        g.backgroundColor = UIColor.clear
        g.textColor = UIColor.boxTitleColor
        g.textAlignment = .center
        g.text = "settings"
        g.font = UIFont.init(customFont: .MavenProBold, withSize: 20)
        return g
    }()
    
    
    func phaseTwo() {
        label.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.hmm)))
        tb.dataSource = self
        tb.delegate = self
        bg.translatesAutoresizingMaskIntoConstraints = true
//        label.translatesAutoresizingMaskIntoConstraints = true
        tb.translatesAutoresizingMaskIntoConstraints = true
        tb.frame = self.frame
        self.addSubview(bg)
//        self.addSubview(label)
        self.addSubview(tb)
        
        label.alpha = 1
        tb.alpha = 1
    }
    
    
    var bg = MaxView()
    
    func transitionTheme() {
        label.textColor = UIColor.boxTitleColor
        bg.removeFromSuperview()
        bg = MaxView()
        bg.translatesAutoresizingMaskIntoConstraints = false
        self.insertSubview(bg, at: 0)
        NSLayoutConstraint.activate(bg.getConstraintsOfView(to: self))
    }
    
    var tb:UITableView = {
        let t = UITableView(frame: .zero)
        t.translatesAutoresizingMaskIntoConstraints = false
        t.backgroundColor = .clear
        t.separatorColor = .clear
        t.separatorStyle = .none
        t.register(IconCell.self, forCellReuseIdentifier: "IconCell")
        
        return t
    }()
    
    @objc func hmm() {
        print("hmmmmm")
    }
    
    
    func setup() {
//
//        tb.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.hmm)))
//        wid = self.widthAnchor.constraint(equalToConstant: 80)
//        tbwid = tb.widthAnchor.constraint(equalToConstant: 80)
//        label.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.hmm)))
////        self.backgroundColor = UIColor.bgTop
   
//        NSLayoutConstraint.activate([
//            label.topAnchor.constraint(equalTo: (v?.topAnchor)!, constant: 80),
//            label.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 15),
//            label.heightAnchor.constraint(equalToConstant: 50),
//
//            tb.topAnchor.constraint(equalTo: label.bottomAnchor),
//            tb.bottomAnchor.constraint(equalTo: self.bottomAnchor),
//            tbwid,
//            tb.centerXAnchor.constraint(equalTo: self.centerXAnchor),
//
//            ])
//        bg.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate(bg.getConstraintsOfView(to: self))
//        NSLayoutConstraint.activate([
//            self.rightAnchor.constraint(equalTo: (v?.leftAnchor)!),
//            self.topAnchor.constraint(equalTo: (v?.topAnchor)!),
//            self.bottomAnchor.constraint(equalTo: (v?.bottomAnchor)!),
//            wid
//            ])

    }
    
    var alph:CGFloat = 1
    var distance:CGFloat = 80
    
    func showMenu() {
        var anim:Double = 0
        if wid.constant == 1 {
            wid.constant = 80
            alph = 1
            distance = 80
            tbwid.constant = 80
            anim = 0.4
        } else {
            wid.constant = 1
            alph = 0
            distance = 0
            tbwid.constant = 1
            anim = 0.1
        }
        
        UIView.animate(withDuration: anim) {
            self.label.alpha = self.alph
            self.tb.alpha = self.alph
        }
//        UIView.animate(withDuration: anim, delay: 0, usingSpringWithDamping: 3, initialSpringVelocity: 5, options: .curveEaseOut, animations: {
   
//        }, completion: nil)
          self.v?.transform = CGAffineTransform(translationX: self.distance, y: 0)


        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 3, initialSpringVelocity: 8, options: .curveEaseOut, animations: {
            self.v?.layoutIfNeeded()
    


        }, completion: { finished in 
            
            
        })
        
    }


}

