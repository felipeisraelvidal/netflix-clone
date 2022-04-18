import UIKit

public class UpcomingSoonViewController: UIViewController {
    
    private let viewModel: UpcomingSoonViewModel
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.backgroundColor = .black
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(UpcomingTitleTableViewCell.self, forCellReuseIdentifier: UpcomingTitleTableViewCell.identifier)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    // MARK: - Initializers
    
    public init(viewModel: UpcomingSoonViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle

    public override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationBar()
        
        view.backgroundColor = .black
        
        fetchTitles()
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let selectedIndexPath = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: selectedIndexPath, animated: false)
        }
    }
    
    public override func loadView() {
        super.loadView()
        
        setupConstraints()
    }
    
    // MARK: - Private methods
    
    private func setupConstraints() {
        
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
    }
    
    private func configureNavigationBar() {
        title = "Upcoming Soon"
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.barStyle = .black
    }
    
    private func fetchTitles() {
        viewModel.fetchTitles { [weak self] error in
            if let error = error {
                print(error.localizedDescription)
            } else {
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            }
        }
    }
    
    // MARK: - Public methods
    
}

extension UpcomingSoonViewController: UITableViewDataSource, UITableViewDelegate {
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.titles.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UpcomingTitleTableViewCell.identifier, for: indexPath) as? UpcomingTitleTableViewCell else {
            return UITableViewCell()
        }
        
        let title = viewModel.titles[indexPath.row]
        cell.configure(with: title)
        
        return cell
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let title = viewModel.titles[indexPath.row]
        viewModel.goToTitleDetails(title: title)
    }
    
}

#if DEBUG
import SwiftUI
import Core
struct UpcomingViewControllerPreviews: PreviewProvider {
    static var previews: some View {
        if #available(iOS 14.0, *) {
            ContainerPreview()
                .ignoresSafeArea()
        } else {
            ContainerPreview()
                .environment(\.colorScheme, .dark)
        }
    }
    
    class Navigation: UpcomingSoonNavigation {
        func goToTitleDetails(_ title: Title) {}
    }
    
    struct ContainerPreview: UIViewControllerRepresentable {
        typealias UIViewControllerType = UINavigationController
        
        func makeUIViewController(context: Context) -> UIViewControllerType {
            let viewModel = UpcomingSoonViewModel(
                upcomingSoonService: DummyUpcomingSoonService(),
                navigation: Navigation()
            )
            
            let viewController = UpcomingSoonViewController(
                viewModel: viewModel
            )
            
            let navController = UINavigationController(rootViewController: viewController)
            return navController
        }
        
        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {}
    }
}
#endif
