import UIKit

class LabelStepperView: UIView {
    
    lazy var leftLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenir Next Demi Bold", size: 18)
        label.textColor = #colorLiteral(red: 0.3921568627, green: 0.5843137255, blue: 0.9294117647, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(label)
        return label
    }()
    
    lazy var rightStepper: UIStepper = {
        let stepper = UIStepper()
        stepper.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(stepper)
        return stepper
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        backgroundColor = #colorLiteral(red: 0.3921568627, green: 0.5843137255, blue: 0.9294117647, alpha: 0.15)
        layer.cornerRadius = 12
        
        setupAllConstraints()
    }
    
    private func setupAllConstraints() {
        setupLeftLabelConstraints()
        setupRightStepperConstraints()
    }
    
    private func setupLeftLabelConstraints() {
        leftLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
        leftLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0).isActive = true
    }
    
    private func setupRightStepperConstraints() {
        rightStepper.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true
        rightStepper.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0).isActive = true
    }
}
