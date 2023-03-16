import UIKit

class PasswordTableViewCell: UITableViewCell {
    
    static let identifier = "PasswordTableViewController"
    
    let mainView: UIView = {
        var view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: 345, height: 100)
        view.layer.cornerRadius = 12
        view.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        view.layer.shadowOpacity = 1
        view.layer.shadowRadius = 4
        view.layer.shadowOffset = CGSize(width: 1, height: 5)
        view.backgroundColor = #colorLiteral(red: 0.3921568627, green: 0.5843137255, blue: 0.9294117647, alpha: 1)
        return view
    }()
    
    let titleLabel: UILabel = {
        var view = UILabel()
        view.frame = CGRect(x: 0, y: 0, width: 310, height: 40)
        view.font = UIFont(name: "Avenir Next Demi Bold", size: 20)
        return view
    }()
    
    let loginLabel: UILabel = {
        var view = UILabel()
        view.frame = CGRect(x: 0, y: 0, width: 310, height: 40)
        view.font = UIFont(name: "Avenir Next", size: 16)
        return view
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setMainViewConstraints()
        setTitleLabelConstraints()
        setLoginLabelConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setMainViewConstraints() {
        contentView.addSubview(mainView)
        mainView.translatesAutoresizingMaskIntoConstraints = false
        mainView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24).isActive = true
        mainView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24).isActive = true
        mainView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        mainView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive = true
    }
    
    func setTitleLabelConstraints() {
        mainView.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 18).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -17).isActive = true
        titleLabel.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 10).isActive = true
    }
    
    func setLoginLabelConstraints() {
        mainView.addSubview(loginLabel)
        loginLabel.translatesAutoresizingMaskIntoConstraints = false
        loginLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        loginLabel.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 18).isActive = true
        loginLabel.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -17).isActive = true
        loginLabel.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 50).isActive = true
    }
}
