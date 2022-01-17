//
//  TitlePreviewViewController.swift
//  Netflix Clone
//
//  Created by Felipe Vidal on 09/01/22.
//

import UIKit
import WebKit

class TitlePreviewViewController: UIViewController {
    
    private let webView: WKWebView = {
        let webView = WKWebView()
        webView.translatesAutoresizingMaskIntoConstraints = false
        return webView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(for: .title2, weight: .bold)
        label.text = "Title name"
        label.textColor = .white
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let watchButton: UIButton = {
        
        let backgroundColor: UIColor = .white
        let foregroundColor: UIColor = .black
        let button = UIButton(type: .system)
        
        let symbolConfiguration = UIImage.SymbolConfiguration(font: .preferredFont(for: .footnote, weight: .bold))
        let image = UIImage(systemName: "play.fill", withConfiguration: symbolConfiguration)
        
        let title = "Watch"
        let titleFont: UIFont = .preferredFont(for: .body, weight: .semibold)
        
        let verticalInsets: CGFloat = 8
        let horizontalInsets: CGFloat = 0
        
        if #available(iOS 15.0, *) {
            var configuration = UIButton.Configuration.filled()
            configuration.baseBackgroundColor = backgroundColor
            configuration.baseForegroundColor = foregroundColor
            configuration.contentInsets = NSDirectionalEdgeInsets(top: verticalInsets, leading: horizontalInsets, bottom: verticalInsets, trailing: horizontalInsets)
            
            configuration.imagePlacement = .leading
            configuration.imagePadding = 12
            configuration.image = image
            
            var attributedTitle = AttributedString(title)
            attributedTitle.font = titleFont
            configuration.attributedTitle = attributedTitle
            
            button.configuration = configuration
        } else {
            button.backgroundColor = .white
            button.setTitleColor(.black, for: .normal)
            button.titleLabel?.font = titleFont
            
            button.setTitle(title, for: .normal)
            button.setImage(image, for: .normal)
            button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 12)
            
            button.contentEdgeInsets = UIEdgeInsets(top: verticalInsets, left: horizontalInsets, bottom: verticalInsets, right: horizontalInsets)
        }
        
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let downloadButton: UIButton = {
        let button = UIButton(type: .system)
        
        let backgroundColor: UIColor = UIColor(named: "dark_gray")!
        let foregroundColor: UIColor = .white
        
        let symbolConfiguration = UIImage.SymbolConfiguration(font: .preferredFont(for: .footnote, weight: .bold))
        let image = UIImage(systemName: "arrow.down.to.line", withConfiguration: symbolConfiguration)
        
        let title = "Download"
        let titleFont: UIFont = .preferredFont(for: .body, weight: .semibold)
        
        let verticalInsets: CGFloat = 8
        let horizontalInsets: CGFloat = 0
        
        if #available(iOS 15.0, *) {
            var configuration = UIButton.Configuration.gray()
            configuration.baseBackgroundColor = backgroundColor
            configuration.baseForegroundColor = foregroundColor
            configuration.contentInsets = NSDirectionalEdgeInsets(top: verticalInsets, leading: horizontalInsets, bottom: verticalInsets, trailing: horizontalInsets)
            
            configuration.imagePlacement = .leading
            configuration.imagePadding = 12
            configuration.image = image
            
            var attributedTitle = AttributedString(title)
            attributedTitle.font = titleFont
            configuration.attributedTitle = attributedTitle
            
            button.configuration = configuration
        } else {
            button.backgroundColor = .white
            button.setTitleColor(.black, for: .normal)
            button.titleLabel?.font = titleFont
            
            button.setTitle(title, for: .normal)
            button.setImage(image, for: .normal)
            button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 12)
            
            button.contentEdgeInsets = UIEdgeInsets(top: verticalInsets, left: horizontalInsets, bottom: verticalInsets, right: horizontalInsets)
        }
        
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let overviewLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(for: .subheadline, weight: .regular)
        label.text = "Overview"
        label.textColor = .white
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.transform = .identity
        
        view.backgroundColor = .black

        view.addSubview(webView)
        view.addSubview(nameLabel)
        view.addSubview(watchButton)
        view.addSubview(downloadButton)
        view.addSubview(overviewLabel)
        
        applyConstraints()
    }
    
    private func applyConstraints() {
        
        NSLayoutConstraint.activate([
            webView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            webView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            webView.heightAnchor.constraint(equalTo: webView.widthAnchor, multiplier: 9/16)
        ])
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: webView.bottomAnchor, constant: 16),
            nameLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            nameLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -8)
        ])
        
        NSLayoutConstraint.activate([
            watchButton.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 12),
            watchButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            watchButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -8)
        ])
        
        NSLayoutConstraint.activate([
            downloadButton.topAnchor.constraint(equalTo: watchButton.bottomAnchor, constant: 10),
            downloadButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            downloadButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -8)
        ])
        
        NSLayoutConstraint.activate([
            overviewLabel.topAnchor.constraint(equalTo: downloadButton.bottomAnchor, constant: 16),
            overviewLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            overviewLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -8)
        ])
        
    }
    
    func configure(with model: Title) {
        nameLabel.text = model.safeName
        overviewLabel.text = model.overview ?? "No overview"
        
        guard let name = model.originalTitle ?? model.originalName else { return }
        APICaller.shared.getMovieTrailer(with: "\(name) trailer") { [weak self] result in
            switch result {
            case .success(let topItem):
                guard let videoId = topItem?.id.videoId, let url = URL(string: "https://www.youtube.com/embed/\(videoId)") else { return }
                
                DispatchQueue.main.async {
                    self?.webView.load(URLRequest(url: url))
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

}

#if DEBUG
import SwiftUI

struct TitlePreviewViewControllerPreviews: PreviewProvider {
    static var previews: some View {
        if #available(iOS 14.0, *) {
            ContainerPreview()
                .ignoresSafeArea()
        } else {
            ContainerPreview()
                .environment(\.colorScheme, .dark)
        }
    }
    
    struct ContainerPreview: UIViewControllerRepresentable {
        typealias UIViewControllerType = UINavigationController
        
        func makeUIViewController(context: Context) -> UIViewControllerType {
            let navController = UINavigationController(rootViewController: TitlePreviewViewController())
            
            return navController
        }
        
        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {}
    }
}
#endif
