import UIKit

class LabelSwitchView : UIView {
    
    lazy var leftLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenir Next Demi Bold", size: 18)
        label.textColor = #colorLiteral(red: 0.3921568627, green: 0.5843137255, blue: 0.9294117647, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(label)
        return label
    }()
    
    lazy var rightSwitch: UISwitch = {
        let switcher = UISwitch()
        switcher.onTintColor = #colorLiteral(red: 0.3921568627, green: 0.5843137255, blue: 0.9294117647, alpha: 1)
        switcher.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(switcher)
        return switcher
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        backgroundColor = #colorLiteral(red: 0.3921568627, green: 0.5843137255, blue: 0.9294117647, alpha: 0.15)
        layer.cornerRadius = 12
        
        setupLeftLabelConstraints()
        setupRightSwitchConstraints()
    }
    
    func setupLeftLabelConstraints() {
        leftLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
        leftLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0).isActive = true
    }
    
    func setupRightSwitchConstraints() {
        rightSwitch.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true
        rightSwitch.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0).isActive = true
    }
}
