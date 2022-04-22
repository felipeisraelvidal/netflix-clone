import UIKit
import CoreUI
import Combine

public class TopSearchesViewController: UIViewController {
    
    private let viewModel: TopSearchesViewModel
    private let searchResultsViewModel: SearchResultsViewModel
    
    private var anyCancellables = Set<AnyCancellable>()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.backgroundColor = .black
        tableView.dataSource = self
        tableView.delegate = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private lazy var searchResultsViewController: SearchResultsViewController = {
        let viewController = SearchResultsViewController(viewModel: searchResultsViewModel)
        viewController.delegate = self
        return viewController
    }()
    
    private lazy var searchController: UISearchController = {
        let controller = UISearchController(searchResultsController: searchResultsViewController)
        controller.searchBar.placeholder = "Search for a movie or a TV show"
        controller.searchBar.searchBarStyle = .minimal
        return controller
    }()
    
    // MARK: - Initializers
    
    public init(
        viewModel: TopSearchesViewModel,
        searchResultsViewModel: SearchResultsViewModel
    ) {
        self.viewModel = viewModel
        self.searchResultsViewModel = searchResultsViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle

    public override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        
        configureNavigationBar()
        setupSearchBarListener()
        
        fetchDiscoverTitles()
    }
    
    public override func loadView() {
        super.loadView()
        
        applyConstraints()
        registerCells()
    }
    
    // MARK: - Private methods
    
    private func applyConstraints() {
        
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        
    }
    
    private func configureNavigationBar() {
        title = "Top Searches"
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.tintColor = .white
        
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    private func setupSearchBarListener() {
        let publisher = NotificationCenter.default.publisher(for: UISearchTextField.textDidChangeNotification, object: searchController.searchBar.searchTextField)
        
        publisher
            .map({ ($0.object as? UISearchTextField)?.text })
            .debounce(for: .milliseconds(500), scheduler: RunLoop.main)
            .sink { [weak self] searchText in
                self?.searchMovies(with: searchText)
            }
            .store(in: &anyCancellables)
    }
    
    private func registerCells() {
        
        tableView.register(TitleTableViewCell.self, forCellReuseIdentifier: TitleTableViewCell.identifier)
        
    }
    
    private func fetchDiscoverTitles() {
        viewModel.fetchDiscoverTitles { error in
            if let error = error {
                print(error.localizedDescription)
            } else {
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    private func searchMovies(with searchText: String?) {
        guard let searchText = searchText, let resultsController = searchController.searchResultsController as? SearchResultsViewController else { return }
        
        resultsController.searchMovies(with: searchText)
    }

}

extension TopSearchesViewController: UITableViewDataSource, UITableViewDelegate {
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.titles.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TitleTableViewCell.identifier, for: indexPath) as? TitleTableViewCell else {
            return TitleTableViewCell()
        }
        
        let title = viewModel.titles[indexPath.row]
        cell.configure(with: title, imageRequest: viewModel.imageRequest)
        
        cell.didTapPlayButton = { [weak self] title in
            self?.viewModel.navigation.goToPlayTitle(title)
        }
        
        return cell
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let title = viewModel.titles[indexPath.row]
        viewModel.navigation.goToTitleDetails(title)
    }
    
}

extension TopSearchesViewController: SearchResultsViewControllerDelegate {
    
    func didSelectTitle(_ title: Title) {
        viewModel.navigation.goToTitleDetails(title)
    }
    
}

#if DEBUG
import SwiftUI
import Core

struct DummyImageRequest: ImageRequestProtocol {
    var baseURL: String {
        return ""
    }
}

struct TopSearchesViewControllerPreviews: PreviewProvider {
    static var previews: some View {
        if #available(iOS 14.0, *) {
            ContainerPreview()
                .ignoresSafeArea()
        } else {
            ContainerPreview()
                .environment(\.colorScheme, .dark)
        }
    }
    
    class Navigation: TopSearchesNavigation {
        func goToTitleDetails(_ title: Title) {}
        func goToPlayTitle(_ title: Title) {}
    }
    
    struct ContainerPreview: UIViewControllerRepresentable {
        typealias UIViewControllerType = UINavigationController
        
        func makeUIViewController(context: Context) -> UIViewControllerType {
            let viewModel = TopSearchesViewModel(
                topSearchesService: DummyTopSearchesService(),
                imageRequest: DummyImageRequest(),
                navigation: Navigation()
            )
            
            let searchResultsViewModel = SearchResultsViewModel(
                searchResultsService: DummySearchResultsService(),
                imageRequest: DummyImageRequest()
            )
            
            let viewController = TopSearchesViewController(
                viewModel: viewModel,
                searchResultsViewModel: searchResultsViewModel
            )
            let navController = UINavigationController(rootViewController: viewController)
            return navController
        }
        
        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {}
    }
}
#endif
