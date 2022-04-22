import UIKit
import WebKit
import Core
import SDWebImage

public class TitlePreviewViewController: UIViewController {
    
    private var viewModel: TitlePreviewViewModel
    
    private lazy var kTableHeroHeight: CGFloat = {
        return (9 * view.bounds.width) / 16
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.backgroundColor = .black
        tableView.allowsSelection = false
        tableView.separatorStyle = .none
        tableView.dataSource = self
        tableView.delegate = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private lazy var tableHeaderView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBlue
        return view
    }()
    
    private lazy var backdropImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
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
        
        title = "Loading..."
        
        configureNavigationBar()
        
        configureBackdropView()
        updateBackdropView()
        
        registerCells()
        
        view.backgroundColor = .black
        
        getTitleDetails()
    }
    
    public override func loadView() {
        super.loadView()
        
        setupConstraints()
    }
    
    // MARK: - Private methods
    
    private func setupConstraints() {
        
        tableHeaderView.addSubview(backdropImageView)
        NSLayoutConstraint.activate([
            backdropImageView.topAnchor.constraint(equalTo: tableHeaderView.topAnchor),
            backdropImageView.leadingAnchor.constraint(equalTo: tableHeaderView.leadingAnchor),
            backdropImageView.trailingAnchor.constraint(equalTo: tableHeaderView.trailingAnchor),
            backdropImageView.bottomAnchor.constraint(equalTo: tableHeaderView.bottomAnchor)
        ])
        
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
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
    
    private func configureBackdropView() {
        tableHeaderView.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: kTableHeroHeight)
        tableView.addSubview(tableHeaderView)
        tableView.contentInset = UIEdgeInsets(top: kTableHeroHeight, left: 0, bottom: 0, right: 0)
        tableView.contentOffset = CGPoint(x: 0, y: -kTableHeroHeight)
    }
    
    private func updateBackdropView() {
        var headerRect = CGRect(x: 0, y: -kTableHeroHeight, width: view.bounds.width, height: kTableHeroHeight)
        if tableView.contentOffset.y < -kTableHeroHeight {
            headerRect.origin.y = tableView.contentOffset.y
            headerRect.size.height = -tableView.contentOffset.y
        }
        
        tableHeaderView.frame = headerRect
    }
    
    private func registerCells() {
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.register(TopInfoTableViewCell.self, forCellReuseIdentifier: TopInfoTableViewCell.identifier)
        
    }
    
    private func configureLabels(with model: Title) {
        self.title = model.safeName
        
        if let path = model.backdropPath, let url = URL(string: "\(viewModel.imageRequest.baseURL)/\(path)") {
            backdropImageView.sd_setImage(with: url)
        }
        
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
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        updateBackdropView()
    }
    
}

#if DEBUG
import SwiftUI

struct DummyImageRequest: ImageRequestProtocol {
    var baseURL: String {
        return "https://image.tmdb.org/t/p/original"
    }
}

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
                titlePreviewService: DummyTitlePreviewService(),
                imageRequest: DummyImageRequest()
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
