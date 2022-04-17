import UIKit

public class HomeViewController: UIViewController {
    
    private var viewModel: HomeViewModel
    
    private var kTableHeroHeight: CGFloat = 450
    
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.backgroundColor = .black
        tableView.separatorStyle = .none
        
        tableView.register(TitleSectionHeader.self, forHeaderFooterViewReuseIdentifier: TitleSectionHeader.identifier)
        tableView.register(CollectionTableViewCell.self, forCellReuseIdentifier: CollectionTableViewCell.identifier)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private var heroView: HeroView?
    
    // MARK: - Initializers
    public init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
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
        
        configureHeroView()
        updateHeroView()
        setupHeroView()
        
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
    
    private func configureHeroView() {
        kTableHeroHeight = view.bounds.height * 0.6
        
        heroView = HeroView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: kTableHeroHeight))
        tableView.tableHeaderView = nil
        tableView.addSubview(heroView!)
        tableView.contentInset = UIEdgeInsets(top: kTableHeroHeight, left: 0, bottom: 0, right: 0)
        tableView.contentOffset = CGPoint(x: 0, y: -kTableHeroHeight)
    }
    
    private func updateHeroView() {
        var headerRect = CGRect(x: 0, y: -kTableHeroHeight, width: view.bounds.width, height: kTableHeroHeight)
        if tableView.contentOffset.y < -kTableHeroHeight {
            headerRect.origin.y = tableView.contentOffset.y
            headerRect.size.height = -tableView.contentOffset.y
        }
        
        heroView?.frame = headerRect
    }
    
    private func setupHeroView() {
        viewModel.fetchHeroTitle { [weak self] result in
            switch result {
            case .success(let title):
                guard let title = title else { return }

                self?.heroView?.configure(with: title)

                self?.heroView?.playButtonTapped = { [weak self] title in
                    self?.viewModel.playTitle(title)
                }

                self?.heroView?.downloadButtonTapped = { [weak self] title in
                    self?.viewModel.downloadTitle(title)
                }

                self?.heroView?.aboutButtonTapped = { [weak self] title in
                    self?.viewModel.goToTitleDetails(title: title)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    // MARK: - Functions
    
    @objc private func changeProfileButtonTapped(_ sender: UIBarButtonItem) {
        viewModel.goToProfilePicker()
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
        
        let section = viewModel.sections[indexPath.section]
        section.fetchHandler { result in
            switch result {
            case .success(let titles):
                let viewModel = CollectionTableViewCellViewModel(
                    titles: titles
                )
                cell.configure(with: viewModel)
                cell.delegate = self
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
        return cell
    }
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        updateHeroView()
    }
    
}

extension HomeViewController: CollectionTableViewCellDelegate {
    
    func didSelectTitle(_ title: Title) {
        viewModel.goToTitleDetails(title: title)
    }
    
}

#if DEBUG
import SwiftUI
import Core
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
    
    class Navigation: HomeNavigation {
        func goToProfilePicker() {}
        func goToTitleDetails(_ title: Title) {}
        func goToPlayTitle(_ title: Title) {}
    }
    
    struct ContainerPreview: UIViewControllerRepresentable {
        typealias UIViewControllerType = UINavigationController
        
        func makeUIViewController(context: Context) -> UIViewControllerType {
            let viewModel = HomeViewModel(
                homeService: DummyHomeService(),
                navigation: Navigation()
            )
            
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
