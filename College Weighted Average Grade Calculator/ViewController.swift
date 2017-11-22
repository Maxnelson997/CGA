//
//  ViewController.swift
//  College Weighted Average Grade Calculator
//
//  Created by Max Nelson on 11/19/17.
//  Copyright © 2017 AsherApps. All rights reserved.
//

import UIKit
import Font_Awesome_Swift

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

protocol DeleteProtocol {
    func ReloadTB()
}

class CatCell:UITableViewCell {

    var removingClass:Bool = false
    var deli:DeleteProtocol!
    
    let cat:UITextField = {
        let n =  UITextField()
        n.font = UIFont.init(customFont: .MavenProBold, withSize: 15)
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

  
    let removeButton:UIButton = {
        let b = UIButton()
        b.translatesAutoresizingMaskIntoConstraints = false
        b.backgroundColor = .clear
        b.setFAIcon(icon: FAType.FARemove, forState: .normal)
        b.setFATitleColor(color: .orange)
        b.alpha = 0
        return b
    }()
 

    var exists:Bool = false
    var rwidth:NSLayoutConstraint!
    var rwidth1:NSLayoutConstraint!
    var rwidth2:NSLayoutConstraint!
    var rwidth3:NSLayoutConstraint!
    override func awakeFromNib() {

        if !exists {
            exists = true
            self.backgroundColor = .clear
            container.backgroundColor = UIColor.cellColor
            contentView.addSubview(container)
            container.addSubview(stack)
            NSLayoutConstraint.activate(container.getConstraintsOfView(to: self.contentView, withInsets: UIEdgeInsets(top: 10, left: 0, bottom: -10, right: 0)))
            NSLayoutConstraint.activate(stack.getConstraintsOfView(to: container))
            
            
            
            stack.addArrangedSubview(removeButton)
            
            stack.addArrangedSubview(cat)
            stack.addArrangedSubview(earnedBox)
            stack.addArrangedSubview(totalBox)
            
            rwidth = removeButton.widthAnchor.constraint(equalToConstant: 5)
            rwidth1 = cat.widthAnchor.constraint(equalTo: stack.widthAnchor, multiplier: 1/3)
            rwidth2 = earnedBox.widthAnchor.constraint(equalTo: stack.widthAnchor, multiplier: 1/3, constant: -5)
            rwidth3 = totalBox.widthAnchor.constraint(equalTo: stack.widthAnchor, multiplier: 1/3)
            
            
            
            NSLayoutConstraint.activate([
                rwidth,
                rwidth1,
                rwidth2,
                rwidth3
                ])
            
            removeButton.addTarget(self, action: #selector(self.removeCategoryFromTB), for: .touchUpInside)

        } else {
            if removingClass {
                removeButton.alpha = 1
                rwidth.constant = 40
                rwidth2.constant = -40/2
                rwidth3.constant = -40/2
                
            } else {
                removeButton.alpha = 0
                rwidth.constant = 5
                rwidth2.constant = -5
                rwidth3.constant = 0
            }
            
            UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: [], animations: {
                self.stack.layoutIfNeeded()
            }, completion: nil)
            
        }

    }
    
    @objc func removeCategoryFromTB() {
        GPModel.sharedInstance.classes.remove(at: removeButton.tag)
        deli.ReloadTB()
    }
    
    override func prepareForReuse() {
//        stack.removeArrangedSubview(removeButton)
//
//        stack.removeArrangedSubview(cat)
//        stack.removeArrangedSubview(earnedBox)
//        stack.removeArrangedSubview(totalBox)
//        stack.removeFromSuperview()
    }
    
}

extension MainController: UITableViewDelegate, UITableViewDataSource, DeleteProtocol {
    
    //deleteprotocol
    func ReloadTB() {
    
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()) {
            self.tb.reloadData()
        }
    }
    
    //datasource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.classes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CatCell", for: indexPath) as! CatCell
        cell.removingClass = removingClass
        cell.awakeFromNib()
        cell.cat.text = model.classes[indexPath.item].name
        cell.earnedBox.text = model.classes[indexPath.item].earned
        cell.totalBox.text = model.classes[indexPath.item].total
        cell.cat.delegate = self
        cell.earnedBox.delegate = self
        cell.totalBox.delegate = self
        cell.deli = self
        cell.removeButton.tag = indexPath.item

        cell.selectionStyle = .none
        return cell
    }
    
    //delegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    
}




class MainController: UIViewController, UITextFieldDelegate {


    var new_class_view:NewClassView = {
        let p = NewClassView()

        p.backgroundColor = UIColor.clear
        return p
    }()
    var new_class_cons:[NSLayoutConstraint]!
    
    @objc func add_class() {
        doneRemoving()
        new_class_cons = new_class_view.getConstraintsOfView(to: catsContainer, withInsets: UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0))
        catsContainer.addSubview(new_class_view)
        NSLayoutConstraint.activate(new_class_cons)
        
        tb.alpha = 0
        
        minusButton.gestureRecognizers?.removeAll()
        plusButton.gestureRecognizers?.removeAll()
        
        minusButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.cancelAddingClass)))
        plusButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.completeAddingClass)))
        
        minusButton.text = "cancel"
        plusButton.text = "add class"
    }
    
    var removingClass:Bool = false
    
    @objc func remove_class() {
        removingClass = true
        minusButton.gestureRecognizers?.removeAll()
        minusButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.doneRemoving)))
        
        minusButton.text = "done"
        tb.reloadData()
    }
    
    @objc func doneRemoving() {
        removingClass = false
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()) {
            self.tb.reloadData()
        }
        minusButton.text = "-"
        minusButton.gestureRecognizers?.removeAll()
        minusButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.remove_class)))
    }
    
    @objc func cancelAddingClass() {
        minusButton.text = "-"
        plusButton.text = "+"
        new_class_view.removeFromSuperview()
        
        minusButton.gestureRecognizers?.removeAll()
        plusButton.gestureRecognizers?.removeAll()
        
        plusButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.add_class)))
        minusButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.remove_class)))
        tb.alpha = 1
    }
    
    @objc func completeAddingClass() {
  
        
        if new_class_view.formFilled {
            cancelAddingClass()
            let newClass = classModel(name: new_class_view.type_name, earned: new_class_view.selected_earned_percentage, total: new_class_view.selected_percentage_oftotal)
            model.classes.append(newClass)
            tb.reloadData()
            //success
        } else {
            //cmon bill, pls fill the damn form out.
        }
    

    }
    
    var currentField:UITextField = UITextField()
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        view.animateView(direction: .up, distance: 150)
//        dismissButton.alpha = 0.01
        dismissButton.isEnabled = true
        currentField = textField
    }
    
    @objc func dismissField() {
        currentField.resignFirstResponder()
        view.animateView(direction: .down, distance: 0)
//        dismissButton.alpha = 0
        dismissButton.isEnabled = false
    }
    
    let model = GPModel.sharedInstance

    var dismissButton:UIButton = {
        let n = UIButton()
//        n.backgroundColor = UIColor.cellColor.withAlphaComponent(0.54)
        n.backgroundColor = .clear
        n.isEnabled = false
        n.translatesAutoresizingMaskIntoConstraints = false
        n.alpha = 1
        return n
    }()
    
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
        plusButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.add_class)))
        minusButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.remove_class)))
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
        
        view.addSubview(dismissButton)
        NSLayoutConstraint.activate(dismissButton.getConstraintsOfView(to: view))
        dismissButton.addTarget(self, action: #selector(self.dismissField), for: .touchUpInside)
        
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

