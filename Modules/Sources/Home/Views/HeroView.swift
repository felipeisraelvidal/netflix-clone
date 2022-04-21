import UIKit
import SDWebImage
import Core

class HeroView: UIView {
    
    private var viewModel: HeroViewModel
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .black
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.sd_imageTransition = .fade
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let bottomGradientContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let bottomGradientLayer: CAGradientLayer = {
        let layer = CAGradientLayer()
        layer.colors = [
            UIColor.clear.cgColor,
            UIColor.black.cgColor
        ]
        layer.locations = [0.5, 1]
        return layer
    }()
    
    private let topGradientLayer: CAGradientLayer = {
        let layer = CAGradientLayer()
        layer.colors = [
            UIColor.black.cgColor,
            UIColor.clear.cgColor
        ]
        layer.locations = [0, 1]
        return layer
    }()
    
    private let playButton: UIButton = {
        let button = UIButton(type: .system)
        
        let title: String = "Play"
        let baseBackgroundColor: UIColor = .white
        let baseForegroundColor: UIColor = .black
        
        if #available(iOS 15.0, *) {
            var configuration = UIButton.Configuration.filled()
            configuration.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 24, bottom: 10, trailing: 24)
            configuration.baseBackgroundColor = baseBackgroundColor
            configuration.baseForegroundColor = baseForegroundColor
            configuration.title = title
            button.configuration = configuration
        } else {
            button.backgroundColor = baseBackgroundColor
            button.setTitle(title, for: .normal)
            button.setTitleColor(baseForegroundColor, for: .normal)
        }
        
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let downloadButton: UIButton = {
        let button = UIButton(type: .system)
        
        let title: String = "Download"
        let baseForegroundColor: UIColor = .white
        
        if #available(iOS 15.0, *) {
            var configuration = UIButton.Configuration.bordered()
            configuration.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 24, bottom: 10, trailing: 24)
            configuration.title = title
            configuration.baseForegroundColor = baseForegroundColor
            button.configuration = configuration
        } else {
            button.setTitle(title, for: .normal)
            button.setTitleColor(baseForegroundColor, for: .normal)
        }
        
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let aboutButton: UIButton = {
        let button = UIButton(type: .system)
        
        let title: String = "More about this Title"
        
        let symbolConfiguration = UIImage.SymbolConfiguration(
            font: .preferredFont(for: .footnote, weight: .bold)
        )
        let image: UIImage? = UIImage(systemName: "info.circle", withConfiguration: symbolConfiguration)
        
        let baseForegroundColor: UIColor = .white
        
        if #available(iOS 15.0, *) {
            var configuration = UIButton.Configuration.bordered()
            configuration.contentInsets = .zero
            configuration.image = image
            configuration.title = title
            configuration.imagePadding = 12
            configuration.baseForegroundColor = baseForegroundColor
            configuration.baseBackgroundColor = .clear
            button.configuration = configuration
        } else {
            button.setTitle(title, for: .normal)
            button.setImage(image, for: .normal)
            button.tintColor = baseForegroundColor
            button.titleLabel?.font = .preferredFont(for: .body, weight: .semibold)
            button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -12, bottom: 0, right: 0)
        }
        
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var playButtonTapped: ((Title) -> Void)?
    var downloadButtonTapped: ((Title) -> Void)?
    var aboutButtonTapped: ((Title) -> Void)?
    
    init(viewModel: HeroViewModel, frame: CGRect) {
        self.viewModel = viewModel
        super.init(frame: frame)
        
        backgroundColor = .black
        
        setupConstraints()
        
        addGradient()
        
        setupButtons()
        
        viewModel.updateView = { [weak self] title in
            if let path = title.posterPath, let url = URL(string: "\(viewModel.imageRequest.baseURL)/\(path)") {
                self?.imageView.sd_setImage(with: url, completed: nil)
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {
        
        addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        addSubview(bottomGradientContainerView)
        NSLayoutConstraint.activate([
            bottomGradientContainerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            bottomGradientContainerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            bottomGradientContainerView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        addSubview(aboutButton)
        NSLayoutConstraint.activate([
            aboutButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -32),
            aboutButton.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
        
        let buttonsStackView = UIStackView(
            arrangedSubviews: [
                playButton,
                downloadButton
            ]
        )
        buttonsStackView.axis = .horizontal
        buttonsStackView.spacing = 16
        buttonsStackView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(buttonsStackView)
        NSLayoutConstraint.activate([
            playButton.widthAnchor.constraint(equalTo: downloadButton.widthAnchor, multiplier: 1),
            buttonsStackView.bottomAnchor.constraint(equalTo: aboutButton.topAnchor, constant: -24),
            buttonsStackView.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
        
    }
    
    private func addGradient() {
        topGradientLayer.frame = CGRect(x: 0, y: 0, width: bounds.width, height: 150)
        layer.addSublayer(topGradientLayer)
        
        bottomGradientContainerView.layer.addSublayer(bottomGradientLayer)
        
        bottomGradientLayer.frame = self.bounds
        bottomGradientLayer.frame.origin.y = -bounds.height
    }
    
    private func setupButtons() {
        
        if #available(iOS 14.0, *) {
            playButton.addAction(UIAction(handler: { [weak self] _ in
                self?.playTitle()
            }), for: .touchUpInside)
        } else {
            playButton.addTarget(self, action: #selector(handlePlayButtonTap(_:)), for: .touchUpInside)
        }
        
        if #available(iOS 14.0, *) {
            downloadButton.addAction(UIAction(handler: { [weak self] _ in
                self?.downloadTitle()
            }), for: .touchUpInside)
        } else {
            downloadButton.addTarget(self, action: #selector(handleDownloadButtonTap(_:)), for: .touchUpInside)
        }
        
        if #available(iOS 14.0, *) {
            aboutButton.addAction(UIAction(handler: { [weak self] _ in
                self?.aboutTitle()
            }), for: .touchUpInside)
        } else {
            aboutButton.addTarget(self, action: #selector(handleAboutButtonTap(_:)), for: .touchUpInside)
        }
        
    }
    
    private func playTitle() {
        guard let title = viewModel.currentTitle else { return }
        playButtonTapped?(title)
    }
    
    private func downloadTitle() {
        guard let title = viewModel.currentTitle else { return }
        downloadButtonTapped?(title)
    }
    
    private func aboutTitle() {
        guard let title = viewModel.currentTitle else { return }
        aboutButtonTapped?(title)
    }
    
    @objc private func handlePlayButtonTap(_ sender: UIButton) {
        playTitle()
    }
    
    @objc private func handleDownloadButtonTap(_ sender: UIButton) {
        downloadTitle()
    }
    
    @objc private func handleAboutButtonTap(_ sender: UIButton) {
        aboutTitle()
    }
    
}

#if DEBUG
import SwiftUI
struct HeroHeaderViewPreviews: PreviewProvider {
    static var previews: some View {
        ContainerPreview()
            .previewLayout(.fixed(width: 375, height: 450))
    }

    struct ContainerPreview: UIViewRepresentable {
        typealias UIViewControllerType = UIView

        func makeUIView(context: Context) -> some UIView {
            let viewModel = HeroViewModel(
                heroService: DummyHeroService(),
                imageRequest: DummyImageRequest()
            )
            return HeroView(viewModel: viewModel, frame: CGRect(x: 0, y: 0, width: 375, height: 450))
        }

        func updateUIView(_ uiView: UIViewType, context: Context) {}
    }
}
#endif
