import UIKit

class HomeLabelView: UIView {
    
    lazy var mainLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(label)
        return label
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = #colorLiteral(red: 0.3921568627, green: 0.5843137255, blue: 0.9294117647, alpha: 0.15)
        layer.cornerRadius = 12
        
        setupMainLabelConstraints()
    }
    
    private func setupMainLabelConstraints() {
        mainLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 5).isActive = true
        mainLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
        mainLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true
        mainLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5).isActive = true
    }
}
