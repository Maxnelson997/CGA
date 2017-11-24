import UIKit
import Font_Awesome_Swift



class NewClassView: UIStackView, UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        button.isEnabled = true
        
        UIView.animate(withDuration: 0.3) {
            self.button.alpha = 1
            self.type_pick.alpha = 0
            self.titleBox.textColor = UIColor.white
            self.titleBox.attributedPlaceholder = NSAttributedString.init(string: "category name", attributes: [NSAttributedStringKey.foregroundColor:UIColor.white.withAlphaComponent(0.6)])
        }
        self.animateView(direction: .down, distance: 20)
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        type_name = titleBox.text
        UIView.animate(withDuration: 0.3) {
            self.button.alpha = 0
            self.type_pick.alpha = 1
            self.titleBox.textColor = UIColor.cellColor.withAlphaComponent(1)
            self.titleBox.attributedPlaceholder = NSAttributedString.init(string: "category name", attributes: [NSAttributedStringKey.foregroundColor:UIColor.cellColor.withAlphaComponent(0.6)])
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
    

    let model = GPModel.sharedInstance
    
    let percentages:[String] = {
        var p:[String] = []
        for i in 1 ..< 101 {
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
        phaseTwo()
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
        n.font = UIFont.init(customFont: .MavenProBold, withSize: 30)
        n.textAlignment = .center
        n.backgroundColor = .clear
        n.textColor = UIColor.cellColor.withAlphaComponent(1)
        n.attributedPlaceholder = NSAttributedString.init(string: "category name", attributes: [NSAttributedStringKey.foregroundColor:UIColor.cellColor.withAlphaComponent(0.6)])
        return n
    }()

    
    func phaseTwo() {

        self.addSubview(button)
        NSLayoutConstraint.activate(button.getConstraintsOfView(to: self))
   
        button.addTarget(self, action: #selector(self.dismissText), for: .touchUpInside)
        self.axis = .vertical
        self.addArrangedSubview(titleBox)
        self.addArrangedSubview(type_pick)
        self.type_pick.delegate = self
        self.type_pick.dataSource = self
        self.titleBox.delegate = self

        NSLayoutConstraint.activate([
            titleBox.heightAnchor.constraint(equalToConstant: 50),
            type_pick.heightAnchor.constraint(equalTo: self.heightAnchor, constant: -50),
            ])
    }

}

extension NewClassView: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return percentages.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            return "EARNED $"
        }
        return "% OF TOTAL"
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        var titleData:String!

        titleData = percentages[row]

        let myTitle = NSAttributedString(string: titleData!, attributes: [NSAttributedStringKey.font:UIFont.init(customFont: .MavenProRegular, withSize: 15)!,NSAttributedStringKey.foregroundColor:UIColor.black])
        return myTitle
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0 {
            selected_earned_percentage = percentages[row]
        } else {
            selected_percentage_oftotal = percentages[row]
        }
        
    }
    
}
