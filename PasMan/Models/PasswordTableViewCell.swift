import UIKit

class PasswordTableViewCell: UITableViewCell {
    
    static let identifier = "PasswordTableViewController"
    
    lazy var mainView: UIView = {
        var view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: 345, height: 100)
        view.layer.cornerRadius = 12
        view.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        view.layer.shadowOpacity = 1
        view.layer.shadowRadius = 4
        view.layer.shadowOffset = CGSize(width: 1, height: 5)
        view.backgroundColor = #colorLiteral(red: 0.3921568627, green: 0.5843137255, blue: 0.9294117647, alpha: 0.8)
        view.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(view)
        return view
    }()
    
    lazy var titleLabel: UILabel = {
        var view = UILabel()
        view.frame = CGRect(x: 0, y: 0, width: 310, height: 40)
        view.font = UIFont(name: "Avenir Next Demi Bold", size: 20)
        view.translatesAutoresizingMaskIntoConstraints = false
        self.mainView.addSubview(view)
        return view
    }()
    
    lazy var loginLabel: UILabel = {
        var view = UILabel()
        view.frame = CGRect(x: 0, y: 0, width: 310, height: 40)
        view.font = UIFont(name: "Avenir Next", size: 16)
        view.translatesAutoresizingMaskIntoConstraints = false
        self.mainView.addSubview(view)
        return view
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupMainViewConstraints()
        setupTitleLabelConstraints()
        setupLoginLabelConstraints()
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
    
    func setupMainViewConstraints() {
        mainView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        mainView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 24).isActive = true
        mainView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -24).isActive = true
        mainView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive = true
    }
    
    func setupTitleLabelConstraints() {
        titleLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        titleLabel.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 10).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: mainView.leftAnchor, constant: 18).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: mainView.rightAnchor, constant: -17).isActive = true
    }
    
    func setupLoginLabelConstraints() {
        loginLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        loginLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 0).isActive = true
        loginLabel.leftAnchor.constraint(equalTo: mainView.leftAnchor, constant: 18).isActive = true
        loginLabel.rightAnchor.constraint(equalTo: mainView.rightAnchor, constant: -17).isActive = true
    }
}
