//
//  SearchViewController.swift
//  Netflix Clone
//
//  Created by Felipe Vidal on 21/12/21.
//

import UIKit
import Combine

class SearchViewController: UIViewController {
    
    private var titles: [Title] = []
    
    private var anyCancellables = Set<AnyCancellable>()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .black
        
        tableView.register(UpcomingTitleTableViewCell.self, forCellReuseIdentifier: UpcomingTitleTableViewCell.identifier)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private let searchController: UISearchController = {
        let controller = UISearchController(searchResultsController: SearchResultsViewController())
        controller.searchBar.placeholder = "Search for a movie or a TV show"
        controller.searchBar.searchBarStyle = .minimal
        return controller
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Search"

        view.backgroundColor = .black
        
        configureNavigationBar()
        setupSearchBarListeners()
        
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        
        applyConstraints()
        
//        searchController.searchResultsUpdater = self
        
        fetchDiscoverMovies()
    }
    
    // MARK: - Functions
    
    private func configureNavigationBar() {
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        
        navigationItem.searchController = searchController
    }
    
    private func setupSearchBarListeners() {
        let publisher = NotificationCenter.default.publisher(for: UISearchTextField.textDidChangeNotification, object: searchController.searchBar.searchTextField)
        publisher
            .map({ ($0.object as? UISearchTextField)?.text })
            .debounce(for: .milliseconds(500), scheduler: RunLoop.main)
            .sink { [weak self] searchText in
                self?.searchMovies(with: searchText)
            }
            .store(in: &anyCancellables)
    }
    
    private func applyConstraints() {
        let tableViewConstraints = [
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ]
        
        NSLayoutConstraint.activate(tableViewConstraints)
    }
    
    private func fetchDiscoverMovies() {
        APICaller.shared.getDiscoverMovies { [weak self] result in
            switch result {
            case .success(let titles):
                self?.titles = titles
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func searchMovies(with searchText: String?) {
        
        guard let query = searchText else { return }
        
        guard let resultsController = searchController.searchResultsController as? SearchResultsViewController else { return }
        
        if query.isEmpty {
            resultsController.titles = []
            DispatchQueue.main.async {
                resultsController.collectionView.reloadData()
            }
        } else {
            APICaller.shared.search(with: query) { result in
                switch result {
                case .success(let titles):
                    resultsController.titles = titles
                    DispatchQueue.main.async {
                        resultsController.collectionView.reloadData()
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }

}

extension SearchViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UpcomingTitleTableViewCell.identifier, for: indexPath) as? UpcomingTitleTableViewCell else {
            return UITableViewCell()
        }
        
        let title = titles[indexPath.row]
        let viewModel = TitleViewModel(
            titleBackdropPath: title.backdropPath,
            titleName: title.originalName ?? title.originalTitle ?? "Unknown name",
            titleOverview: title.overview ?? "No overview"
        )
        
        cell.configure(with: viewModel)
        
        return cell
    }
}

#if DEBUG
import SwiftUI

struct SearchViewControllerPreviews: PreviewProvider {
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
        typealias UIViewControllerType = UITabBarController
        
        func makeUIViewController(context: Context) -> UIViewControllerType {
            let navController = UINavigationController(rootViewController: SearchViewController())
            navController.tabBarItem = UITabBarItem(title: "Top Searches", image: UIImage(systemName: "magnifyingglass"), tag: 0)
            
            let tabBarController = UITabBarController()
            tabBarController.viewControllers = [navController]
            tabBarController.tabBar.barStyle = .black
            
            return tabBarController
        }
        
        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {}
    }
}
#endif

