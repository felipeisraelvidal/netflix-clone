import UIKit

public class TitleHeaderView: UICollectionReusableView {
    
    public static let identifier = "ProfilePickerHeaderView"
    
    public var editButtonTapped: (() -> Void)?
    
    private let iconImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "netflix_logo"))
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(for: .largeTitle, weight: .bold)
        label.text = "Who is \nwatching?"
        label.textColor = .white
        label.numberOfLines = 0
        label.textAlignment = .center
        label.adjustsFontForContentSizeCategory = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let editButton: UIButton = {
        let button = UIButton(type: .system)
        
        let imageConfiguration = UIImage.SymbolConfiguration(font: .preferredFont(for: .title3, weight: .bold))
        let image = UIImage(systemName: "pencil", withConfiguration: imageConfiguration)
        
        if #available(iOS 15.0, *) {
            var configuration = UIButton.Configuration.plain()
            
            configuration.baseForegroundColor = .white
            configuration.image = image
            
            button.configuration = configuration
        } else {
            button.setImage(image, for: .normal)
            button.tintColor = .white
        }
        
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        editButton.addTarget(self, action: #selector(toggleEdit(_:)), for: .touchUpInside)
        
        addSubview(editButton)
        NSLayoutConstraint.activate([
            editButton.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            editButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ])
        
        addSubview(iconImageView)
        NSLayoutConstraint.activate([
            iconImageView.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            iconImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            iconImageView.widthAnchor.constraint(equalToConstant: 60),
            iconImageView.heightAnchor.constraint(equalToConstant: 60)
        ])
        
        addSubview(label)
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: iconImageView.bottomAnchor, constant: 32),
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    @objc private func toggleEdit(_ sender: UIButton) {
        editButtonTapped?()
    }
    
}
