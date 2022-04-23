import UIKit
import DownloadedTitles

final class DownloadedTitlesCoordinator: Coordinator {
    
    typealias UIViewControllerType = UINavigationController
    
    // MARK: - Properties
    
    weak var parentCoordinator: CoordinatorBase?
    var childCoordinators: [CoordinatorBase] = []
    var rootViewController: UINavigationController
    
    // MARK: - Initializers
    
    init(rootViewController: UINavigationController) {
        self.rootViewController = rootViewController
    }
    
    // MARK: - Public methods
    
    func start() {
        
        let viewModel = DownloadedTitlesViewModel(
            downloadedTitlesService: DownloadedTitlesService(),
            imageRequest: ImageRequest()
        )
        
        let viewController = DownloadedTitlesViewController(
            viewModel: viewModel
        )
        
        viewController.title = "Download"
        
        rootViewController.tabBarItem = UITabBarItem(
            title: "Downloads",
            image: .init(systemName: "arrow.down.to.line"),
            tag: 3
        )
        
        rootViewController.setViewControllers([viewController], animated: false)
        
    }
    
}
