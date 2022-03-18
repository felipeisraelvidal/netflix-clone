import UIKit
import WebKit

public class TitlePreviewViewController: UIViewController {
    
    private var viewModel: TitlePreviewViewModel
    
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.backgroundColor = .black
        tableView.allowsSelection = false
        tableView.separatorStyle = .none
        
        tableView.register(TrailerPreviewSectionHeaderView.self, forHeaderFooterViewReuseIdentifier: TrailerPreviewSectionHeaderView.identifier)
        
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
        
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.barStyle = .black
        
        view.backgroundColor = .black
        
        tableView.dataSource = self
        tableView.delegate = self
        
        setupConstraints()
        configureLabels()
    }
    
    public override func loadView() {
        super.loadView()
        
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    // MARK: - Functions
    
    private func setupConstraints() {
        
    }
    
    private func configureLabels() {
        title = viewModel.title.safeName
    }
    
    // MARK: - Actions
    
}

extension TitlePreviewViewController: UITableViewDataSource, UITableViewDelegate {
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: TrailerPreviewSectionHeaderView.identifier) as? TrailerPreviewSectionHeaderView else {
            return nil
        }
        
        return headerView
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: TopInfoTableViewCell.identifier, for: indexPath) as? TopInfoTableViewCell else {
                return UITableViewCell()
            }
            
            cell.backgroundColor = .black
            
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
                title: .init(
                    id: 0,
                    originalName: "Harry Potter"
                )
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
