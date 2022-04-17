import UIKit
import Core

public class TitlePlayerViewController: UIViewController {
    
    private let viewModel: TitlePlayerViewModel
    
    private lazy var cancelButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Close", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(for: .title2, weight: .bold)
        label.text = "Title name"
        label.textColor = .white
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    public override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return [.landscapeLeft, .landscapeRight]
    }
    
    public override var shouldAutorotate: Bool {
        return true
    }
    
    // MARK: - Initializers
    public init(viewModel: TitlePlayerViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle

    public override func viewDidLoad() {
        super.viewDidLoad()
        
        UIDevice.current.setValue(UIInterfaceOrientation.landscapeRight.rawValue, forKey: "orientation")
        
        view.backgroundColor = .black
        
        configureNavigationBar()
        
        configure(with: viewModel.title)
    }
    
    public override func loadView() {
        super.loadView()
        
        setupConstraints()
    }
    
    // MARK: - Private methods
    
    private func setupConstraints() {
        
        view.addSubview(nameLabel)
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            nameLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16)
        ])
        
        view.addSubview(cancelButton)
        NSLayoutConstraint.activate([
            cancelButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            cancelButton.centerYAnchor.constraint(equalTo: nameLabel.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            nameLabel.trailingAnchor.constraint(equalTo: cancelButton.leadingAnchor, constant: -16)
        ])
        
    }
    
    private func configureNavigationBar() {
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    private func configure(with model: Title) {
        nameLabel.text = model.safeName
    }

}

#if DEBUG
import SwiftUI
struct TitlePlayerViewControllerPreviews: PreviewProvider {
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
            let viewModel = TitlePlayerViewModel(
                title: .init(
                    id: 0,
                    originalName: "Harry Potter"
                )
            )
            
            let viewController = TitlePlayerViewController(
                viewModel: viewModel
            )
            
            let navController = UINavigationController(rootViewController: viewController)
            return navController
        }
        
        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {}
    }
}
#endif
