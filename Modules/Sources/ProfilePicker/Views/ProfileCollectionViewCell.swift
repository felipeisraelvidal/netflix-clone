import UIKit
import Core

public class ProfileCollectionViewCell: UICollectionViewCell {
    
    public static let identifier = "ProfileCollectionViewCell"
    
    private var isAnimate = true
    
    private let nameContainerView: UIVisualEffectView = {
        let view = UIVisualEffectView(effect: UIBlurEffect(style: .systemMaterialDark))
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(for: .body, weight: .semibold)
        label.textColor = .white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        layer.cornerCurve = .continuous
        layer.cornerRadius = 25
        clipsToBounds = true
        
        nameContainerView.contentView.addSubview(nameLabel)
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: nameContainerView.contentView.topAnchor, constant: 8),
            nameLabel.leadingAnchor.constraint(equalTo: nameContainerView.contentView.leadingAnchor, constant: 4),
            nameLabel.trailingAnchor.constraint(equalTo: nameContainerView.contentView.trailingAnchor, constant: -4),
            nameLabel.bottomAnchor.constraint(equalTo: nameContainerView.contentView.bottomAnchor, constant: -8)
        ])
        
        contentView.addSubview(nameContainerView)
        NSLayoutConstraint.activate([
            nameContainerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            nameContainerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            nameContainerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
        ])
        
        nameContainerView.layer.cornerCurve = .continuous
        nameContainerView.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(with profile: Profile) {
        backgroundColor = profile.color
        nameLabel.text = profile.name
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        nameContainerView.layoutIfNeeded()
        nameContainerView.layer.cornerRadius = nameContainerView.bounds.height / 2
    }
    
    func startAnimate() {
        let shakeAnimation = CABasicAnimation(keyPath: "transform.rotation")
        shakeAnimation.duration = 0.05
        shakeAnimation.repeatCount = 4
        shakeAnimation.autoreverses = true
        shakeAnimation.duration = 0.2
        shakeAnimation.repeatCount = 99999
        
        let startAngle: Float = (-2) * .pi / 180
        let stopAngle = -startAngle
        
        shakeAnimation.fromValue = NSNumber(value: startAngle as Float)
        shakeAnimation.toValue = NSNumber(value: 3 * stopAngle as Float)
        shakeAnimation.autoreverses = true
        shakeAnimation.timeOffset = 290 * drand48()
        
        let layer: CALayer = self.layer
        layer.add(shakeAnimation, forKey:"animate")
        isAnimate = true
    }
    
    func stopAnimate() {
        let layer: CALayer = self.layer
        layer.removeAnimation(forKey: "animate")
        isAnimate = false
    }
    
}

#if DEBUG
import SwiftUI
struct ProfileCollectionViewCellPreviews: PreviewProvider {
    static var previews: some View {
        if #available(iOS 14.0, *) {
            ContainerPreview()
                .ignoresSafeArea()
                .previewLayout(.fixed(width: 200, height: 245))
        } else {
            ContainerPreview()
                .environment(\.colorScheme, .dark)
                .previewLayout(.fixed(width: 200, height: 245))
        }
    }
    
    struct ContainerPreview: UIViewRepresentable {
        typealias UIViewType = UICollectionViewCell
        
        func makeUIView(context: Context) -> UIViewType {
            let profile: Profile = .init(
                name: "Stella",
                color: .systemPink
            )
            
            let cell = ProfileCollectionViewCell(frame: .zero)
            cell.configure(with: profile)
            
            return cell
        }
        
        func updateUIView(_ uiView: UICollectionViewCell, context: Context) {}
    }
}
#endif
