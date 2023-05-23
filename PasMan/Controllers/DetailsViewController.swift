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
    
    lazy var titleView: LabelTextFieldView = {
        let labelTextFieldView = LabelTextFieldView()
        labelTextFieldView.titleLabel.text = "Title".localized()
        labelTextFieldView.textField.delegate = self
        labelTextFieldView.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(labelTextFieldView)
        return labelTextFieldView
    }()
    
    lazy var loginView: LabelTextFieldView = {
        let labelTextFieldView = LabelTextFieldView()
        labelTextFieldView.titleLabel.text = "Username".localized()
        labelTextFieldView.textField.delegate = self
        labelTextFieldView.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(labelTextFieldView)
        return labelTextFieldView
    }()
    
    lazy var passwordView: LabelTextFieldView = {
        let labelTextFieldView = LabelTextFieldView()
        labelTextFieldView.titleLabel.text = "Password".localized()
        labelTextFieldView.textField.delegate = self
        labelTextFieldView.textField.isSecureTextEntry = true
        labelTextFieldView.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(labelTextFieldView)
        return labelTextFieldView
    }()
    
    lazy var additionalInformationView: LabelTextView = {
        let labelTextView = LabelTextView()
        labelTextView.titleLabel.text = "Additional Information".localized()
        labelTextView.textView.delegate = self
        labelTextView.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(labelTextView)
        return labelTextView
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
            guard let data = self.data else { return }
            DataStoreManager.shared.deletePasswordModel(object: data)
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
                self.titleView.textField.text = data.title
                self.loginView.textField.text = kuznyechik.decrypt(data: data.login!)
                self.passwordView.textField.text = kuznyechik.decrypt(data: data.password!)
                guard let additionalInformation = data.additionalInformation else { return }
                self.additionalInformationView.textView.text = kuznyechik.decrypt(data: additionalInformation)
            }
        }
    }
    
    private var calendarButton = UIBarButtonItem()
    private var eyeButton = UIBarButtonItem()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard (_:)))
        self.view.addGestureRecognizer(tapGesture)
        
        calendarButton = UIBarButtonItem(image: UIImage(systemName: "calendar.badge.clock"),
                                             style: .plain, target: self,
                                             action: #selector(calendarButtonClick))
        
        eyeButton = UIBarButtonItem(image: UIImage(systemName: "eye"),
                                        style: .plain, target: self,
                                        action: #selector(eyeButtonClick))
        
        navigationItem.rightBarButtonItems = [calendarButton, eyeButton]
        
        setupAllConstraints()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.view.endEditing(true)

        if titleView.textField.text!.isEmpty {
            DataStoreManager.shared.updateLogin(for: data!, login: "Caption".localized())
        }

        if loginView.textField.text!.isEmpty {
            DataStoreManager.shared.updateLogin(for: data!, login: "Username".localized())
        }

        if passwordView.textField.text!.isEmpty {
            DataStoreManager.shared.updateLogin(for: data!, login: "Password".localized())
        }
    }
    
    @objc
    func eyeButtonClick() {
        
        if passwordView.textField.isSecureTextEntry {
            passwordView.textField.isSecureTextEntry = false
            eyeButton.image = UIImage(systemName: "eye.slash")
        } else {
            passwordView.textField.isSecureTextEntry = true
            eyeButton.image = UIImage(systemName: "eye")
        }
    }
    
    @objc
    func calendarButtonClick() {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        
        var message = String()
        if let expirationDate = data?.expirationDate, expirationDate >= Date() {
            message = "This password expires on ".localized() + dateFormatter.string(from: expirationDate)
        } else {
            message = "This password does not expire".localized()
        }
        
        let alert = UIAlertController(title: "Change expiration date".localized(),
                                      message: message,
                                      preferredStyle: .alert)
        
        alert.addTextField { textField in
            textField.placeholder = "Set the number of days to expire".localized()
            textField.autocorrectionType = .no
            textField.returnKeyType = .done
            textField.keyboardType = .numberPad
        }

        let actionOK = UIAlertAction(title: "OK", style: .default) { _ in
            
            if let numberOfDays = Int((alert.textFields?.first?.text)!), numberOfDays >= 1 && numberOfDays <= 360 {
                let userNotificationsManager = UserNotificationsManager()
                userNotificationsManager.updateNotificationTrigger(withUUID: (self.data?.uuid)!, body: "Your ".localized() + (self.data?.title)! + " password has expired!".localized(), afterDays: numberOfDays)
                let date = Calendar.current.date(byAdding: .day, value: numberOfDays, to: Date())!
                DataStoreManager.shared.updateExpirationDate(for: self.data!, expirationDate: date)
            } else {
                let alert = UIAlertController(title: "Invalid number of days".localized(), message: nil, preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .default)
                alert.addAction(action)
                self.present(alert, animated: true)
            }
        }
        
        let actionCancel = UIAlertAction(title: "Cancel".localized(), style: .cancel)
        
        alert.addAction(actionOK)
        alert.addAction(actionCancel)
        
        present(alert, animated: true)
    }
    
    @objc
    func dismissKeyboard (_ sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    
    private func setupAllConstraints() {
        setupScrollViewConstraints()
        setupContentViewConstraints()
        setupTitleViewConstraints()
        setupLoginViewConstraints()
        setupPasswordViewConstraints()
        setupAdditionalInformationViewConstraints()
        setupDeleteButtonPasswordConstraints()
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

extension DetailsViewController: UITextFieldDelegate {
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        
        switch textField {
        case titleView.textField:
            if let text = self.titleView.textField.text {
                DataStoreManager.shared.updateTitle(for: data!, title: text)
            }
        case loginView.textField:
            if let text = self.loginView.textField.text {
                DataStoreManager.shared.updateLogin(for: data!, login: text)
            }
        case passwordView.textField:
            if let text = self.passwordView.textField.text {
                DataStoreManager.shared.updatePassword(for: data!, password: text)
            }
        default:
            break
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        switch textField {
        case titleView.textField:
            if titleView.textField.text!.isEmpty {
                let alert = AlertManager.createOKAlert(with: "Don't leave an empty caption field".localized())
                present(alert, animated: true)
                titleView.textField.text = "Caption".localized()
                DataStoreManager.shared.updateTitle(for: data!, title: "Caption".localized())
            }
        case loginView.textField:
            if loginView.textField.text!.isEmpty {
                let alert = AlertManager.createOKAlert(with: "Don't leave an empty username field".localized())
                present(alert, animated: true)
                loginView.textField.text = "Username".localized()
                DataStoreManager.shared.updateLogin(for: data!, login: "Username".localized())
            }
        case passwordView.textField:
            if passwordView.textField.text!.isEmpty {
                let alert = AlertManager.createOKAlert(with: "Don't leave an empty password field".localized())
                present(alert, animated: true)
                passwordView.textField.text = "Password".localized()
                DataStoreManager.shared.updatePassword(for: data!, password: "Password".localized())
            }
        default:
            break
        }
    }
}

extension DetailsViewController: UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        
        switch textView {
        case additionalInformationView.textView:
            if let text = self.additionalInformationView.textView.text {
                DataStoreManager.shared.updateAdditionalInformation(for: data!, information: text)
            }
        default:
            break
        }
    }
}
