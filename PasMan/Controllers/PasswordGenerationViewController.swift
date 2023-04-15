import UIKit

class PasswordGenerationViewController: UIViewController {
    
    lazy var passwordTextView: UITextView = {
        let textView = UITextView()
        textView.font = UIFont(name: "Avenir Next Bold", size: 26)
        textView.text = "YOUR STRONG PASSWORD"
        textView.textColor = #colorLiteral(red: 0.3921568627, green: 0.5843137255, blue: 0.9294117647, alpha: 1)
        textView.layer.cornerRadius = 12
        textView.textContainer.maximumNumberOfLines = 1
        textView.textContainer.lineBreakMode = .byTruncatingTail
        textView.isScrollEnabled = false
        textView.isEditable = false
        textView.textAlignment = .center
        textView.backgroundColor = .systemGray5
        textView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(textView)
        return textView
    }()
    
    lazy var lengthLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenir Next Demi Bold", size: 18)
        label.text = "Password length: 8"
        label.textColor = #colorLiteral(red: 0.67, green: 0.73, blue: 0.78, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(label)
        return label
    }()
    
    lazy var lengthSlider: UISlider = {
        let slider = UISlider()
        slider.tintColor = #colorLiteral(red: 0.3921568627, green: 0.5843137255, blue: 0.9294117647, alpha: 1)
        slider.minimumValue = 8
        slider.maximumValue = 20
        let config = UIImage.SymbolConfiguration(pointSize: 30)
        slider.minimumValueImage = UIImage(systemName: "8.circle", withConfiguration: config)
        slider.maximumValueImage = UIImage(systemName: "20.circle", withConfiguration: config)
        let action = UIAction { _ in
            self.lengthLabel.text = "Password length: \(Int(slider.value))"
        }
        slider.addAction(action, for: .valueChanged)
        slider.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(slider)
        return slider
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
    
        setPasswordTextViewConstraints()
        setLengthLabelConstraints()
        setLengthSliderConstraints()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        passwordTextView.alignVerticalCenter()
    }
    
    func setPasswordTextViewConstraints() {
        passwordTextView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        passwordTextView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        passwordTextView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
        passwordTextView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.2).isActive = true
    }
    
    func setLengthLabelConstraints() {
        lengthLabel.topAnchor.constraint(equalTo: passwordTextView.bottomAnchor, constant: 20).isActive = true
        lengthLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        lengthLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
    }
    
    func setLengthSliderConstraints() {
        lengthSlider.topAnchor.constraint(equalTo: lengthLabel.bottomAnchor, constant: 5).isActive = true
        lengthSlider.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        lengthSlider.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
    }
}
