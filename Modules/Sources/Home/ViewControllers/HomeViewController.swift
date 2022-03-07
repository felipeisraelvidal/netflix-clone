import UIKit

public class HomeViewController: UIViewController {
    
    private var viewModel: HomeViewModel
    
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.backgroundColor = .black
        tableView.separatorStyle = .none
        
        tableView.register(TitleSectionHeader.self, forHeaderFooterViewReuseIdentifier: TitleSectionHeader.identifier)
        tableView.register(CollectionTableViewCell.self, forCellReuseIdentifier: CollectionTableViewCell.identifier)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    // MARK: - Initializers
    public init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        
        configureNavigationBar()
        
        tableView.dataSource = self
        tableView.delegate = self
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
    
    private func configureNavigationBar() {
        var image = UIImage(named: "netflix_logo", in: .module, with: nil)
        image = image?.withRenderingMode(.alwaysOriginal)
        
        let logoItem = UIBarButtonItem(image: image, style: .done, target: self, action: nil)
        logoItem.isEnabled = false
        
        navigationItem.leftBarButtonItem = logoItem
        
        let changeProfileButton = UIBarButtonItem(
            image: .init(systemName: "person"),
            style: .done,
            target: self,
            action: #selector(changeProfileButtonTapped(_:))
        )
        
        let airplayButton = UIBarButtonItem(
            image: .init(systemName: "play.rectangle"),
            style: .done,
            target: self,
            action: nil
        )
        
        navigationItem.rightBarButtonItems = [
            changeProfileButton,
            airplayButton
        ]
        
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.barStyle = .black
    }
    
    // MARK: - Functions
    
    @objc private func changeProfileButtonTapped(_ sender: UIBarButtonItem) {
        
    }
    
}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.sections.count
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: TitleSectionHeader.identifier) as? TitleSectionHeader else { return nil }
        
        headerView.titleLabel.text = viewModel.sections[section].title
        
        return headerView
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CollectionTableViewCell.identifier, for: indexPath) as? CollectionTableViewCell else {
            return UITableViewCell()
        }
        
        switch viewModel.sections[indexPath.section] {
        case .trendingMovies:
            viewModel.fetchTrendingMovies { result in
                switch result {
                case .success(let titles):
                    let viewModel = CollectionTableViewCellViewModel(
                        titles: titles
                    )
                    cell.configure(with: viewModel)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        case .trendingTVs:
            viewModel.fetchTrendingTVs { result in
                switch result {
                case .success(let titles):
                    let viewModel = CollectionTableViewCellViewModel(
                        titles: titles
                    )
                    cell.configure(with: viewModel)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        case .popular:
            viewModel.fetchPopular { result in
                switch result {
                case .success(let titles):
                    let viewModel = CollectionTableViewCellViewModel(
                        titles: titles
                    )
                    cell.configure(with: viewModel)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        case .upcomingMovies:
            viewModel.fetchUpcomingMovies { result in
                switch result {
                case .success(let titles):
                    let viewModel = CollectionTableViewCellViewModel(
                        titles: titles
                    )
                    cell.configure(with: viewModel)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        case .topRated:
            viewModel.fetchTopRatedMovies { result in
                switch result {
                case .success(let titles):
                    let viewModel = CollectionTableViewCellViewModel(
                        titles: titles
                    )
                    cell.configure(with: viewModel)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
        
        return cell
    }
    
}

#if DEBUG
import SwiftUI
struct HomeViewControllerPreviews: PreviewProvider {
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
            let viewModel = HomeViewModel()
            let viewController = HomeViewController(
                viewModel: viewModel
            )
            let navController = UINavigationController(rootViewController: viewController)
            return navController
        }
        
        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {}
    }
}
#endif
