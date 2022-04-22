import UIKit
import WebKit
import Core

public class TitlePreviewViewController: UIViewController {
    
    private var viewModel: TitlePreviewViewModel
    
    private let webView: WKWebView = {
        let webView = WKWebView()
        webView.translatesAutoresizingMaskIntoConstraints = false
        return webView
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.backgroundColor = .black
        tableView.allowsSelection = false
        tableView.separatorStyle = .none
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.register(TopInfoTableViewCell.self, forCellReuseIdentifier: TopInfoTableViewCell.identifier)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    // MARK: - Initializers
    
    public init(viewModel: TitlePreviewViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Overrides
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationBar()
        
        view.backgroundColor = .black
        
        tableView.dataSource = self
        tableView.delegate = self
        
        getTitleDetails()
    }
    
    public override func loadView() {
        super.loadView()
        
        setupConstraints()
    }
    
    // MARK: - Private methods
    
    private func setupConstraints() {
        
        view.addSubview(webView)
        NSLayoutConstraint.activate([
            webView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            webView.heightAnchor.constraint(equalTo: webView.widthAnchor, multiplier: 9/16)
        ])
        
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: webView.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
    }
    
    private func configureNavigationBar() {
        
        navigationItem.largeTitleDisplayMode = .never
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.barStyle = .black
        
    }
    
    private func configureLabels(with model: Title) {
        self.title = model.safeName
        
        tableView.reloadData()
    }
    
    private func getTitleDetails() {
        viewModel.getTitleDetails { error in
            if let error = error {
                print(error.localizedDescription)
            } else {
                guard let title = self.viewModel.title else { return }
                DispatchQueue.main.async {
                    self.configureLabels(with: title)
                }
            }
        }
    }
    
    // MARK: - Actions
    
}

extension TitlePreviewViewController: UITableViewDataSource, UITableViewDelegate {
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            guard let title = viewModel.title,
                    let cell = tableView.dequeueReusableCell(withIdentifier: TopInfoTableViewCell.identifier, for: indexPath) as? TopInfoTableViewCell else {
                return UITableViewCell()
            }
            
            cell.backgroundColor = .black
            cell.configure(with: title)
            
            return cell
        default:
            return UITableViewCell()
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
            let viewModel = TitlePreviewViewModel(
                titleID: 0,
                mediaType: "movie",
                titlePreviewService: DummyTitlePreviewService()
            )
            let viewController = TitlePreviewViewController(
                viewModel: viewModel
            )
            let navController = UINavigationController(rootViewController: viewController)
            return navController
        }
        
        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {}
    }
}
#endif
