import UIKit

class LabelTextFieldView: UIView {
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenir Next Demi Bold", size: 15)
        label.textColor =  #colorLiteral(red: 0.67, green: 0.73, blue: 0.78, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(label)
        return label
    }()
    
    lazy var textField: UITextField = {
        let textField = UITextField()
        textField.font = UIFont(name: "Avenir Next", size: 15)
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        textField.backgroundColor = .none
        textField.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(textField)
        return textField
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
        setupTitleLabelConstraints()
        setupInputTextViewConstraints()
    }
    
    private func setupTitleLabelConstraints() {
        titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 5).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 5).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -5).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }
    
    private func setupInputTextViewConstraints() {
        textField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 0).isActive = true
        textField.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 5).isActive = true
        textField.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -5).isActive = true
        textField.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
    }
}
