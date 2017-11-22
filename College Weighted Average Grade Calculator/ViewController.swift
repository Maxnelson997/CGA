//
//  ViewController.swift
//  College Weighted Average Grade Calculator
//
//  Created by Max Nelson on 11/19/17.
//  Copyright © 2017 AsherApps. All rights reserved.
//

import UIKit

class TBHeader:UIStackView {
    
    let cat:GPLabel = {
        let n =  GPLabel()
        n.text = "category"
        n.textAlignment = .center
        return n
    }()
    
    let earned:GPLabel = {
        let n =  GPLabel()
        n.text = "earned %"
        n.textAlignment = .center
        return n
    }()
    
    let total:GPLabel = {
        let n =  GPLabel()
        n.text = "$ of total"
        n.textAlignment = .center
        return n
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        phaseTwo()
    }
    
    init() {
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        phaseTwo()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func phaseTwo() {
        self.addArrangedSubview(cat)
        self.addArrangedSubview(earned)
        self.addArrangedSubview(total)
        self.axis = .horizontal
        NSLayoutConstraint.activate([cat.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1/3), earned.widthAnchor.constraint(equalTo: earned.widthAnchor), total.widthAnchor.constraint(equalTo: cat.widthAnchor)])
    }
}

class CatCell:UITableViewCell {

    
    let cat:GPLabel = {
        let n =  GPLabel()
        n.text = "category"
        n.textAlignment = .left
        n.backgroundColor = .clear
        n.textColor = UIColor.white
        return n
    }()
    
    let earnedBox:UITextField = {
        let t = UITextField()
        t.font = UIFont.init(customFont: .MavenProBold, withSize: 15)
        t.backgroundColor = .clear
        t.textAlignment = .center
        t.textColor = .white
        return t
    }()
    
    let totalBox:UITextField = {
        let t = UITextField()
        t.font = UIFont.init(customFont: .MavenProBold, withSize: 15)
        t.backgroundColor = .clear
        t.textAlignment = .center
        t.textColor = .white

        return t
    }()
    
    let stack:UIStackView = {
       let s = UIStackView()
        s.translatesAutoresizingMaskIntoConstraints = false
        s.axis = .horizontal
//        s.backgroundColor = .clear
        s.layer.cornerRadius = 6
        s.layer.masksToBounds = true
        return s
    }()

    let container:UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.layer.cornerRadius = 6
        v.layer.masksToBounds = true
        return v
    }()
    
    override func awakeFromNib() {
        self.backgroundColor = .clear
        container.backgroundColor = UIColor.cellColor
        contentView.addSubview(container)
        container.addSubview(stack)
        NSLayoutConstraint.activate(container.getConstraintsOfView(to: self.contentView, withInsets: UIEdgeInsets(top: 10, left: 0, bottom: -10, right: 0)))
        NSLayoutConstraint.activate(stack.getConstraintsOfView(to: container))
        
        stack.addArrangedSubview(cat)
        stack.addArrangedSubview(earnedBox)
        stack.addArrangedSubview(totalBox)
        
        NSLayoutConstraint.activate([
            cat.widthAnchor.constraint(equalTo: stack.widthAnchor, multiplier: 1/3),
            earnedBox.widthAnchor.constraint(equalTo: cat.widthAnchor),
            totalBox.widthAnchor.constraint(equalTo: cat.widthAnchor)
            ])
        
    }
    
    override func prepareForReuse() {
        stack.removeArrangedSubview(cat)
        stack.removeArrangedSubview(earnedBox)
        stack.removeArrangedSubview(totalBox)
        stack.removeFromSuperview()
    }
    
}

extension MainController: UITableViewDelegate, UITableViewDataSource {
    //datasource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.classes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CatCell", for: indexPath) as! CatCell
        cell.awakeFromNib()
        cell.cat.text = model.classes[indexPath.item].name
        cell.earnedBox.text = model.classes[indexPath.item].earned
        cell.totalBox.text = model.classes[indexPath.item].total
        cell.selectionStyle = .none
        return cell
    }
    
    //delegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    
}

class MainController: UIViewController {
    
    let model = GPModel.sharedInstance

    var tb:UITableView = {
        let t = UITableView(frame: .zero)
        t.translatesAutoresizingMaskIntoConstraints = false
        t.backgroundColor = .clear
        t.separatorColor = .clear
        t.separatorStyle = .none
        t.register(CatCell.self, forCellReuseIdentifier: "CatCell")
        return t
    }()

    var percentView:TitleView = {
        let m = TitleView(title: "Percent", viewRadius: 20, containsCenterLabel: true, centerText: "81%")

        return m
    }()
    
    var gradeView:TitleView = {
        let m = TitleView(title: "Grade", viewRadius: 20, containsCenterLabel: true, centerText: "B-")
        return m
    }()
    
    var catsContainer:TitleView = {
        let m = TitleView(title: "Class Categories", perfectSquare: false, viewRadius: 20)
    
        return m
    }()
    
    var plusButton:TitleInView = {
        let m = TitleInView(title: "+", viewRadius: 20)

        return m
    }()
    
    var minusButton:TitleInView = {
        let m = TitleInView(title: "-", viewRadius: 20)

        return m
    }()
    
    var mainStack:UIStackView = {
        let s = UIStackView()
        s.translatesAutoresizingMaskIntoConstraints = false
        s.axis = .vertical
        s.spacing = 10
        return s
    }()
    
    var topStack:UIStackView = {
        let s = UIStackView()
        s.translatesAutoresizingMaskIntoConstraints = false
        s.axis = UILayoutConstraintAxis.horizontal
        s.spacing = 20
        return s
    }()
    
    var controlStack:UIStackView = {
        let s = UIStackView()
        s.translatesAutoresizingMaskIntoConstraints = false
        s.axis = .horizontal
        s.spacing = 20
        
        return s
    }()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = MaxView(frame: UIScreen.main.bounds)
        
        view.addSubview(mainStack)
        NSLayoutConstraint.activate(mainStack.getConstraintsOfView(to: view, withInsets: UIEdgeInsets(top: 80, left: 30, bottom: 20, right: -30)))

        topStack.addArrangedSubview(percentView)
//        topStack.addArrangedSubview(UIView())
        topStack.addArrangedSubview(gradeView)
        
        controlStack.addArrangedSubview(minusButton)
        controlStack.addArrangedSubview(plusButton)
        
//        let spacer0 = UIView()
//        spacer0.translatesAutoresizingMaskIntoConstraints = false
        let spacer1 = UIView()
        spacer1.translatesAutoresizingMaskIntoConstraints = false
        mainStack.addArrangedSubview(topStack)
 
        mainStack.addArrangedSubview(catsContainer)
        mainStack.addArrangedSubview(controlStack)
        mainStack.addArrangedSubview(spacer1)
        
        catsContainer.addSubview(tb)
        NSLayoutConstraint.activate(tb.getConstraintsOfView(to: catsContainer, withInsets: UIEdgeInsets(top: 60, left: 10, bottom: -5, right: -10)))
        
        tb.delegate = self
        tb.dataSource = self
        
        NSLayoutConstraint.activate([
            minusButton.widthAnchor.constraint(equalTo: percentView.widthAnchor),
            plusButton.widthAnchor.constraint(equalTo: percentView.widthAnchor),
            plusButton.heightAnchor.constraint(equalToConstant: 35),
            minusButton.heightAnchor.constraint(equalToConstant: 35),
            percentView.widthAnchor.constraint(equalTo: mainStack.widthAnchor, multiplier: 0.5, constant: -10),
            percentView.heightAnchor.constraint(greaterThanOrEqualTo: percentView.widthAnchor, constant: 50),
            gradeView.widthAnchor.constraint(equalTo: percentView.widthAnchor),
            gradeView.heightAnchor.constraint(equalTo: percentView.heightAnchor),
     
            spacer1.heightAnchor.constraint(equalToConstant: 50),
            topStack.heightAnchor.constraint(equalTo: percentView.widthAnchor),
            catsContainer.heightAnchor.constraint(lessThanOrEqualTo: mainStack.heightAnchor, multiplier: 1),
            catsContainer.widthAnchor.constraint(equalTo: mainStack.widthAnchor, multiplier: 1)
            ])
        //stackview
        
            //let percentContainer = LabeledContainerView(name: percent)
            //let gradeContainer = LabeledContainerView(name: grade)
        
            //let categoriesContainer = classCategoriesContainer() -- LabeledContainerView(name: class categories)
        
                    //let classCategoriesTable = ClassCategoriesTableView() -- uistackview()
                        //let header = categoriesheader()
                            //categoriesheader = uistackview()
                                //categoriesheader.addarrangedsubview(categorylabel); (earned%); (% of total)
                    //classcategoriestable.addArrangedSubview(categories header) 0.2
                    //classcategoriestable.
        
            //categoriesContainer.addSubview(classCategoriesTable)
        
        
        
        
        
    }


}

