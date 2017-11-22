//
//  ViewController.swift
//  College Weighted Average Grade Calculator
//
//  Created by Max Nelson on 11/19/17.
//  Copyright © 2017 AsherApps. All rights reserved.
//

import UIKit



class MainController: UIViewController {
    
    
    var percentView:TitleView = {
        let m = TitleView(title: "Percent")
        m.layer.cornerRadius = 12
        return m
    }()
    
    var gradeView:TitleView = {
        let m = TitleView(title: "Grade")
        m.layer.cornerRadius = 12
        return m
    }()
    
    var catsContainer:TitleView = {
        let m = TitleView(title: "Class Categories", perfectSquare: false)
        m.layer.cornerRadius = 20
        return m
    }()
    
    var plusButton:TitleInView = {
        let m = TitleInView(title: "+")
        m.layer.cornerRadius = 20
        return m
    }()
    
    var minusButton:TitleInView = {
        let m = TitleInView(title: "-")
        m.layer.cornerRadius = 20
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
        return s
    }()
    
    var controlStack:UIStackView = {
        let s = UIStackView()
        s.translatesAutoresizingMaskIntoConstraints = false
        s.axis = .horizontal
        return s
    }()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = MaxView(frame: UIScreen.main.bounds)
        
        view.addSubview(mainStack)
        NSLayoutConstraint.activate(mainStack.getConstraintsOfView(to: view, withInsets: UIEdgeInsets(top: 80, left: 20, bottom: 20, right: -20)))

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
        
        
        NSLayoutConstraint.activate([
            minusButton.widthAnchor.constraint(equalTo: percentView.widthAnchor),
            plusButton.widthAnchor.constraint(equalTo: percentView.widthAnchor),
            plusButton.heightAnchor.constraint(equalToConstant: 50),
            minusButton.heightAnchor.constraint(equalToConstant: 50),
            percentView.widthAnchor.constraint(equalTo: mainStack.widthAnchor, multiplier: 0.5),
            percentView.heightAnchor.constraint(equalTo: percentView.widthAnchor),
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

