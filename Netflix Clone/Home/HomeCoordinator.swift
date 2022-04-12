import UIKit
import Home

final class HomeCoordinator: Coordinator {
    
    typealias UIViewControllerType = UINavigationController
    
    var childCoordinators: [CoordinatorBase] = []
    var rootViewController: UINavigationController
    
    // MARK: - Initializers
    
    init(rootViewController: UINavigationController) {
        self.rootViewController = rootViewController
    }
    
    // MARK: - Public methods
    
    func start() {
        
        let viewModel = HomeViewModel(
            homeService: HomeService()
        )
        
        let viewController = HomeViewController(
            viewModel: viewModel
        )
        
        rootViewController.tabBarItem = UITabBarItem(
            title: "Home",
            image: .init(systemName: "house"),
            tag: 0
        )
        
        rootViewController.setViewControllers([viewController], animated: true)
        
    }
    
}
