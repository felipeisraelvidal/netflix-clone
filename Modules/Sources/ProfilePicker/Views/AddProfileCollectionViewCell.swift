import UIKit

public class AddProfileCollectionViewCell: UICollectionViewCell {
    
    public static let identifier = "AddProfileCollectionViewCell"
    
    private let plusIcon: UIImageView = {
        let imageView = UIImageView()
        
        let symbolConfiguration = UIImage.SymbolConfiguration(font: .preferredFont(for: .title3, weight: .semibold))
        imageView.image = UIImage(systemName: "plus", withConfiguration: symbolConfiguration)
        
        imageView.tintColor = .white
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let plusIconContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white.withAlphaComponent(0.15)
        view.clipsToBounds = true
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(for: .title3, weight: .bold)
        label.text = "Add a new profile"
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 0
        label.adjustsFontForContentSizeCategory = true
        return label
    }()
    
    public override var isHighlighted: Bool {
        didSet {
            UIView.animate(withDuration: 0.05) {
                self.alpha = self.isHighlighted ? 0.5 : 1
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .black
        
        layer.cornerCurve = .continuous
        layer.cornerRadius = 25
        layer.borderColor = UIColor.white.cgColor
        layer.borderWidth = 1
        clipsToBounds = true
        
        plusIconContainerView.addSubview(plusIcon)
        NSLayoutConstraint.activate([
            plusIcon.topAnchor.constraint(equalTo: plusIconContainerView.topAnchor, constant: 12),
            plusIcon.leadingAnchor.constraint(equalTo: plusIconContainerView.leadingAnchor, constant: 12),
            plusIcon.trailingAnchor.constraint(equalTo: plusIconContainerView.trailingAnchor, constant: -12),
            plusIcon.bottomAnchor.constraint(equalTo: plusIconContainerView.bottomAnchor, constant: -12),
        ])
        
        let stackView = UIStackView(arrangedSubviews: [plusIconContainerView, titleLabel])
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            stackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        plusIconContainerView.layoutIfNeeded()
        plusIconContainerView.layer.cornerRadius = plusIconContainerView.layer.bounds.height / 2
    }
}
