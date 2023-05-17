import UIKit

class DetailsViewController: UIViewController {
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(scrollView)
        return scrollView
    }()
    
    lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        self.scrollView.addSubview(view)
        return view
    }()
    
    lazy var titleView: PasswordDetailsView = {
        let passwordDetailsView = PasswordDetailsView()
        passwordDetailsView.titleLabel.text = "Title".localized()
        passwordDetailsView.inputTextView.delegate = self
        passwordDetailsView.inputTextView.setScreenCaptureProtection()
        passwordDetailsView.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(passwordDetailsView)
        return passwordDetailsView
    }()
    
    lazy var loginView: PasswordDetailsView = {
        let passwordDetailsView = PasswordDetailsView()
        passwordDetailsView.titleLabel.text = "Username".localized()
        passwordDetailsView.inputTextView.delegate = self
        passwordDetailsView.inputTextView.setScreenCaptureProtection()
        passwordDetailsView.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(passwordDetailsView)
        return passwordDetailsView
    }()
    
    lazy var passwordView: PasswordDetailsView = {
        let passwordDetailsView = PasswordDetailsView()
        passwordDetailsView.titleLabel.text = "Password".localized()
        passwordDetailsView.inputTextView.delegate = self
        passwordDetailsView.inputTextView.setScreenCaptureProtection()
        passwordDetailsView.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(passwordDetailsView)
        return passwordDetailsView
    }()
    
    lazy var additionalInformationView: PasswordDetailsView = {
        let passwordDetailsView = PasswordDetailsView()
        passwordDetailsView.titleLabel.text = "Additional Information".localized()
        passwordDetailsView.inputTextView.textContainer.maximumNumberOfLines = 10
        passwordDetailsView.inputTextView.delegate = self
        passwordDetailsView.inputTextView.setScreenCaptureProtection()
        passwordDetailsView.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(passwordDetailsView)
        return passwordDetailsView
    }()
    
    lazy var deletePasswordButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 12
        button.layer.borderWidth = 0.3
        button.layer.borderColor = UIColor.red.cgColor
        button.backgroundColor = #colorLiteral(red: 1, green: 0, blue: 0, alpha: 0.2)
        button.setTitleColor(.systemRed, for: .normal)
        button.setTitle("Delete password".localized(), for: .normal)
        button.titleLabel?.font = UIFont(name: "Avenir Next Demi Bold", size: 18)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        let action = UIAction { _ in
            guard let index = self.index else { return }
            self.deletePasswordModelDelegate?.deletePasswordModel(at: index)
            self.navigationController?.popViewController(animated: true)
        }
        button.addAction(action, for: .touchUpInside)
        
        self.contentView.addSubview(button)
        return button
    }()
    
    var data: PasswordModel? {
        didSet {
            guard let data = data else { return }
            DispatchQueue.main.async {
                let kuznyechik = Kuznyechik()
                self.titleView.inputTextView.text = data.title
                self.loginView.inputTextView.text = kuznyechik.decrypt(data: data.login!)
                self.passwordView.inputTextView.text = kuznyechik.decrypt(data: data.password!)
                guard let additionalInformation = data.additionalInformation else { return }
                self.additionalInformationView.inputTextView.text = kuznyechik.decrypt(data: additionalInformation)
            }
        }
    }
    
    var deletePasswordModelDelegate: DeletePasswordModelDelegate?
    var reloadRowsDelegate: ReloadRowsDelegate?
    var index: IndexPath?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard (_:)))
        self.view.addGestureRecognizer(tapGesture)
        
        setupScrollViewConstraints()
        setupContentViewConstraints()
        setupTitleViewConstraints()
        setupLoginViewConstraints()
        setupPasswordViewConstraints()
        setupAdditionalInformationViewConstraints()
        setupDeleteButtonPasswordConstraints()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if let index = index {
            reloadRowsDelegate?.reloadRows(indexPath: [index], animation: .automatic)
        }
        navigationController?.popViewController(animated: true)
        self.view.endEditing(true)
    }
    
    @objc func dismissKeyboard (_ sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    
    private func setupScrollViewConstraints() {
        scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        scrollView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        scrollView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
    }
    
    private func setupContentViewConstraints() {
        let heightConstraint = contentView.heightAnchor.constraint(equalTo: scrollView.heightAnchor)
        heightConstraint.priority = UILayoutPriority(250)
        heightConstraint.isActive = true
        contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        contentView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 0).isActive = true
        contentView.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 0).isActive = true
        contentView.rightAnchor.constraint(equalTo: scrollView.rightAnchor, constant: 0).isActive = true
        contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: 0).isActive = true
    }
    
    private func setupTitleViewConstraints() {
        titleView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        titleView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20).isActive = true
        titleView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -20).isActive = true
        titleView.heightAnchor.constraint(equalToConstant: 65).isActive = true
    }
    
    private func setupLoginViewConstraints() {
        loginView.topAnchor.constraint(equalTo: titleView.bottomAnchor, constant: 10).isActive = true
        loginView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20).isActive = true
        loginView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -20).isActive = true
        loginView.heightAnchor.constraint(equalToConstant: 65).isActive = true
    }
    
    private func setupPasswordViewConstraints() {
        passwordView.topAnchor.constraint(equalTo: loginView.bottomAnchor, constant: 10).isActive = true
        passwordView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20).isActive = true
        passwordView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -20).isActive = true
        passwordView.heightAnchor.constraint(equalToConstant: 65).isActive = true
    }
    
    private func setupAdditionalInformationViewConstraints() {
        additionalInformationView.topAnchor.constraint(equalTo: passwordView.bottomAnchor, constant: 10).isActive = true
        additionalInformationView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20).isActive = true
        additionalInformationView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -20).isActive = true
        additionalInformationView.heightAnchor.constraint(equalToConstant: 250).isActive = true
    }
    
    private func setupDeleteButtonPasswordConstraints() {
        deletePasswordButton.topAnchor.constraint(equalTo: additionalInformationView.bottomAnchor, constant: 10).isActive = true
        deletePasswordButton.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20).isActive = true
        deletePasswordButton.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -20).isActive = true
        deletePasswordButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
}

extension DetailsViewController: UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        
        switch textView {
        case titleView.inputTextView:
            if let text = self.titleView.inputTextView.text {
                DataStoreManager.shared.updateTitle(for: data!, title: text)
            }
        case loginView.inputTextView:
            if let text = self.loginView.inputTextView.text {
                DataStoreManager.shared.updateLogin(for: data!, login: text)
            }
        case passwordView.inputTextView:
            if let text = self.passwordView.inputTextView.text {
                DataStoreManager.shared.updatePassword(for: data!, password: text)
            }
        case additionalInformationView.inputTextView:
            if let text = self.additionalInformationView.inputTextView.text {
                DataStoreManager.shared.updateAdditionalInformation(for: data!, information: text)
            }
        default:
            break
        }
    }
}
