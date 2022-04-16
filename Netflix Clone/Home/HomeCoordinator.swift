import UIKit
import Home
import Core
import TitlePreview

final class HomeCoordinator: Coordinator {
    
    typealias UIViewControllerType = UINavigationController
    
    weak var parentCoordinator: CoordinatorBase?
    var childCoordinators: [CoordinatorBase] = []
    var rootViewController: UINavigationController
    
    // MARK: - Initializers
    
    init(rootViewController: UINavigationController) {
        self.rootViewController = rootViewController
    }
    
    // MARK: - Public methods
    
    func start() {
        
        rootViewController.navigationBar.barStyle = .black
        
        let viewModel = HomeViewModel(
            homeService: HomeService(),
            navigation: self
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
    
    // MARK: - Private methods
    
    private func presentProfilePicker() {
        let appCoordinator = parentCoordinator as! AppCoordinator
        appCoordinator.goToProfilePicker()
    }
    
    private func presentTitleDetails(_ title: Title) {
        let viewModel = TitlePreviewViewModel(
            title: title
        )
        
        let viewController = TitlePreviewViewController(
            viewModel: viewModel
        )
        
        rootViewController.pushViewController(viewController, animated: true)
    }
    
}

extension HomeCoordinator: HomeNavigation {
    
    func goToProfilePicker() {
        presentProfilePicker()
    }
    
    func goToTitleDetails(_ title: Title) {
        presentTitleDetails(title)
    }
    
    func goToPlayTitle(_ title: Title) {
        print("Play \(title.safeName)")
    }
    
}
