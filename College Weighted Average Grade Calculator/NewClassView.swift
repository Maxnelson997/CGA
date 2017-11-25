import UIKit
import Font_Awesome_Swift



class NewClassView: UIStackView, UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        button.isEnabled = true
        
        UIView.animate(withDuration: 0.3) {
            self.button.alpha = 0
            self.type_pick.alpha = 0
            self.titleBox.textColor = UIColor.white
            self.titleBox.attributedPlaceholder = NSAttributedString.init(string: "category name", attributes: [NSAttributedStringKey.foregroundColor:UIColor.white.withAlphaComponent(0.3)])
        }
        self.animateView(direction: .down, distance: 20)
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        type_name = titleBox.text
        UIView.animate(withDuration: 0.3) {
            self.button.alpha = 0
            self.type_pick.alpha = 1
            self.titleBox.textColor = UIColor.white.withAlphaComponent(1)
            self.titleBox.attributedPlaceholder = NSAttributedString.init(string: "category name", attributes: [NSAttributedStringKey.foregroundColor:UIColor.cellColor.withAlphaComponent(0.3)])
        }
        button.isEnabled = false
        self.animateView(direction: .up, distance: 0)
    }
    
    @objc func dismissText() {
        titleBox.resignFirstResponder()
    }
    
    let button:UIButton = {
        let b = UIButton()
        b.alpha = 0
        b.backgroundColor = UIColor.cellColor
        b.isEnabled = false
        b.layer.cornerRadius = 6
//        b.layer.masksToBounds = true
        b.translatesAutoresizingMaskIntoConstraints = false
        return b
    }()
    
    var selected_earned_percentage:String!
    var selected_percentage_oftotal:String!
    var type_name:String!
    
    var formFilled:Bool {
        get {
            return self.isFormFilled()
        }
        set {
            
        }
    }
    
    func updateRemainingPercent() {
        var p:[String] = []
        let ps = get_remaining_percent()
        if ps > 0 { isFull = false } else { isFull = true }
        
        for i in 1 ..< ps { //101
            p.append(String(describing: i) + "%")
        }
        self.percentages = p
        phaseTwo()
        self.type_pick.reloadAllComponents()
    }
    

    let model = GPModel.sharedInstance
    
    var percentages:[String] = {
        var p:[String] = []
        for i in 1 ..< get_remaining_percent() { //101
            p.append(String(describing: i) + "%")
        }
        return p
    }()
    
    let earnPercentages:[String] = {
        var p:[String] = []
        for i in 1 ..< 101 { //101
            p.append(String(describing: i) + "%")
        }
        return p
    }()
    
    fileprivate var type_pick:UIPickerView = {
        let s = UIPickerView()
        s.layer.cornerRadius = 12
//        s.layer.masksToBounds = true
        s.translatesAutoresizingMaskIntoConstraints = false
        return s
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        phaseTwo()
    }
    
    init() {
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        donebtn()
        phaseTwo()
    }
    
    func donebtn()
    {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        doneToolbar.barStyle = .default
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.doneButtonAction))
        
        let items = [flexSpace, done]
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        
        titleBox.inputAccessoryView = doneToolbar
    }
    
    @objc func doneButtonAction()
    {
        titleBox.resignFirstResponder()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func isFormFilled() -> Bool {
        if type_name != nil && selected_earned_percentage != nil && selected_percentage_oftotal != nil {
            return true
        }
        return false
    }
    
    let titleBox:UITextField = {
        let n =  UITextField()
        n.font = UIFont.init(customFont: .MavenProBold, withSize: 25)
        n.textAlignment = .center
        n.backgroundColor = UIColor.cellColor.withAlphaComponent(0.5)
        n.layer.cornerRadius = 5
        n.textColor = UIColor.white.withAlphaComponent(1)
        n.attributedPlaceholder = NSAttributedString.init(string: "category name", attributes: [NSAttributedStringKey.foregroundColor:UIColor.cellColor.withAlphaComponent(0.3)])
        return n
    }()

    var stack:UIStackView = {
       let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        return stack
    }()
    
    let label0:GPLabel = {
        let g = GPLabel(withOutDraw: true)
        g.backgroundColor = UIColor.clear
        g.textColor = UIColor.boxTitleColor
        g.textAlignment = .center
        g.text = "earned %"
        g.font = UIFont.init(customFont: .MavenProBold, withSize: 15)
        return g
    }()
    let label1:GPLabel = {
        let g = GPLabel(withOutDraw: false)
        g.backgroundColor = UIColor.clear
        g.textColor = UIColor.boxTitleColor
        g.textAlignment = .center
        g.text = "weight %"
        g.font = UIFont.init(customFont: .MavenProBold, withSize: 15)
        return g
    }()
    let titleBoxTitle:GPLabel = {
        let g = GPLabel(withOutDraw: false)
        g.backgroundColor = UIColor.clear
        g.textColor = UIColor.boxTitleColor
        g.textAlignment = .center
        g.text = ""
        g.font = UIFont.init(customFont: .MavenProBold, withSize: 15)
        return g
    }()
    
    let maximumLabel:GPLabel = {
        let g = GPLabel(withOutDraw: false)
        g.backgroundColor = UIColor.clear
        g.textColor = UIColor.boxTitleColor
        g.textAlignment = .center
        g.numberOfLines = 3
        g.text = "category weights already add up to 100% remove a category to continue"
        g.font = UIFont.init(customFont: .MavenProBold, withSize: 25)
        return g
    }()
    
    var isFull:Bool = false
    
    
    func phaseTwo() {
        if self.subviews.count != 0 {
            for v in self.subviews {
                v.removeFromSuperview()
            }
        }
        
        if self.percentages.isEmpty {
            isFull = true
            self.addArrangedSubview(maximumLabel)
            NSLayoutConstraint.activate([maximumLabel.heightAnchor.constraint(equalTo: self.heightAnchor)])
        } else {
            isFull = false
            self.addSubview(button)
            NSLayoutConstraint.activate(button.getConstraintsOfView(to: self))
            
            button.addTarget(self, action: #selector(self.dismissText), for: .touchUpInside)
            self.axis = .vertical
            self.addArrangedSubview(titleBoxTitle)
            self.addArrangedSubview(titleBox)
            self.addArrangedSubview(stack)
            self.addArrangedSubview(type_pick)
            stack.addArrangedSubview(label0)
            stack.addArrangedSubview(label1)
            self.type_pick.delegate = self
            self.type_pick.dataSource = self
            self.titleBox.delegate = self
            
            NSLayoutConstraint.activate([
                label0.widthAnchor.constraint(equalTo: stack.widthAnchor, multiplier: 0.5),
                label1.widthAnchor.constraint(equalTo: stack.widthAnchor, multiplier: 0.5),
                titleBoxTitle.heightAnchor.constraint(equalToConstant: 25),
                titleBox.heightAnchor.constraint(equalToConstant: 30),
                stack.heightAnchor.constraint(equalToConstant: 50),
                
                type_pick.heightAnchor.constraint(equalTo: self.heightAnchor, constant: -105),
                ])
        }

    }

}

extension NewClassView: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return earnPercentages.count
        }
        return percentages.count
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            return "EARNED %"
        }
        return "% OF TOTAL"
    }

    
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        var titleData:String!

        titleData = earnPercentages[row]

        let myTitle = NSAttributedString(string: titleData!, attributes: [NSAttributedStringKey.font:UIFont.init(customFont: .MavenProRegular, withSize: 15)!,NSAttributedStringKey.foregroundColor:UIColor.black])
        return myTitle
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0 {
            selected_earned_percentage = earnPercentages[row]
        } else {
            selected_percentage_oftotal = percentages[row]
        }
        
    }
    
}
