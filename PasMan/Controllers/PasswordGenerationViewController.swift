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


    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
    
        setPasswordTextViewConstraints()
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
}
