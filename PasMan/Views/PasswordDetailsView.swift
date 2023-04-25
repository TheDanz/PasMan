import UIKit

class PasswordDetailsView: UIView {
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenir Next Demi Bold", size: 15)
        label.textColor =  #colorLiteral(red: 0.67, green: 0.73, blue: 0.78, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(label)
        return label
    }()
    
    lazy var inputTextView: UITextView = {
        let textView = UITextView()
        textView.font = UIFont(name: "Avenir Next", size: 15)
        textView.textContainer.maximumNumberOfLines = 1
        textView.textContainer.lineBreakMode = .byTruncatingTail
        textView.isScrollEnabled = false
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.backgroundColor = .none
        self.addSubview(textView)
        return textView
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        backgroundColor = #colorLiteral(red: 0.3921568627, green: 0.5843137255, blue: 0.9294117647, alpha: 0.15)
        layer.cornerRadius = 12
        
        setTitleLabelConstraints()
        setInputTextViewConstraints()
    }
    
    func setTitleLabelConstraints() {
        titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 5).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 5).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -5).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }
    
    func setInputTextViewConstraints() {
        inputTextView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 0).isActive = true
        inputTextView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 5).isActive = true
        inputTextView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -5).isActive = true
        inputTextView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
    }
}
