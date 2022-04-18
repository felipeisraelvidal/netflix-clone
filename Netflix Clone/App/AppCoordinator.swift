import UIKit

final class AppCoordinator: Coordinator {
    
    typealias UIViewControllerType = UITabBarController
    
    weak var parentCoordinator: CoordinatorBase?
    var childCoordinators: [CoordinatorBase] = []
    var rootViewController: UITabBarController
    
    // MARK: - Initializers
    
    init(rootViewController: UITabBarController) {
        self.rootViewController = rootViewController
    }
    
    // MARK: - Public methods
    
    func start() {
        
        rootViewController.tabBar.barStyle = .black
        
        childCoordinators.removeAll()
        
        // Home
        
        let homeCoordinator = HomeCoordinator(rootViewController: UINavigationController())
        homeCoordinator.parentCoordinator = self
        childCoordinators.append(homeCoordinator)
        
        homeCoordinator.start()
        
        // Comming Soon
        
        let upcomingSoonCoordinator = UpcomingSoonCoordinator(rootViewController: UINavigationController())
        upcomingSoonCoordinator.parentCoordinator = self
        childCoordinators.append(upcomingSoonCoordinator)
        
        upcomingSoonCoordinator.start()
        
        // Top Searches
        
        let topSearchesViewController = UIViewController()
        topSearchesViewController.view.backgroundColor = .systemPink
        
        topSearchesViewController.tabBarItem = UITabBarItem(
            title: "Top Searches",
            image: .init(systemName: "magnifyingglass"),
            tag: 2
        )
        
        // Downloads
        
        let downloadsViewController = UIViewController()
        downloadsViewController.view.backgroundColor = .systemPink
        
        downloadsViewController.tabBarItem = UITabBarItem(
            title: "Downloads",
            image: .init(systemName: "arrow.down.to.line"),
            tag: 3
        )
        
        //
        
        rootViewController.viewControllers = [
            homeCoordinator.rootViewController,
            upcomingSoonCoordinator.rootViewController,
            topSearchesViewController,
            downloadsViewController
        ]
    }
    
    func goToProfilePicker() {
        let coordinator = ProfilePickerCoordinator(rootViewController: UINavigationController())
        coordinator.rootViewController.setNavigationBarHidden(true, animated: false)
        coordinator.rootViewController.isModalInPresentation = true
        childCoordinators.append(coordinator)
        
        coordinator.start()
        
        rootViewController.selectedViewController?.present(coordinator.rootViewController, animated: true, completion: nil)
    }
    
}
