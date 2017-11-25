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
        b.layer.masksToBounds = true
        b.layer.cornerRadius = 15
        return b
    }()

    var icon:FAType!
    
    override func awakeFromNib() {
        
        contentView.addSubview(iconView)
        iconView.setFAIcon(icon: icon, iconSize: 35, forState: .normal)
        iconView.setFATitleColor(color: UIColor.boxTitleColor)
//        NSLayoutConstraint.activate(iconView.getConstraintsOfView(to: contentView, withInsets: UIEdgeInsets(top: 10, left: 33.75, bottom: -10, right: -33.75)))
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
//        .FAGrav,
//        .FAMeetup,
//        .FAMicrochip,
//        .FAGithub,
//        .FASend,
//        .FAUniversalAccess,
//        .FAShoppingCart,
//        .FAStackOverflow,
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
//        self.addSubview(bg)
        self.addSubview(label)
        self.addSubview(tb)
        self.backgroundColor = .clear
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: self.topAnchor, constant: 80),
            label.heightAnchor.constraint(equalToConstant: 50),
            label.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 15),
            
            
            tb.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 0),
            tb.leftAnchor.constraint(equalTo: self.leftAnchor),
            tb.rightAnchor.constraint(equalTo: self.rightAnchor),
            tb.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            ])
//        NSLayoutConstraint.activate(bg.getConstraintsOfView(to: self))
        
//        NSLayoutConstraint.activate(tb.getConstraintsOfView(to: self))
        
        tb.dataSource = self
        tb.delegate = self
        
//        self.tb.transform = CGAffineTransform(translationX: -80, y: 0)
        
    }
    

    
    var bg = MaxView()
    
    func transitionTheme() {
        label.textColor = UIColor.boxTitleColor
//        bg.removeFromSuperview()
//        bg = MaxView()
//        bg.translatesAutoresizingMaskIntoConstraints = false
//        self.insertSubview(bg, at: 0)
//        NSLayoutConstraint.activate(bg.getConstraintsOfView(to: self))
 
    }
    
    var tb:UITableView = {
        let t = UITableView()
        t.translatesAutoresizingMaskIntoConstraints = false
        t.backgroundColor = .clear
        t.showsVerticalScrollIndicator = false
        t.separatorColor = .clear
        t.separatorStyle = .none
        t.register(IconCell.self, forCellReuseIdentifier: "IconCell")
        return t
    }()
    
 



}

