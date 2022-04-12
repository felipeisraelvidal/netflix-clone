import UIKit

final class AppCoordinator: Coordinator {
    
    typealias UIViewControllerType = UITabBarController
    
    var childCoordinators: [CoordinatorBase] = []
    var rootViewController: UITabBarController
    
    // MARK: - Initializers
    
    init(rootViewController: UITabBarController) {
        self.rootViewController = rootViewController
    }
    
    // MARK: - Public methods
    
    func start() {
        
        rootViewController.tabBar.barStyle = .black
        
        let homeCoordinator = HomeCoordinator(rootViewController: UINavigationController())
        homeCoordinator.start()
        
        let commingSoonViewController = UIViewController()
        commingSoonViewController.view.backgroundColor = .systemPink
        
        commingSoonViewController.tabBarItem = UITabBarItem(
            title: "Comming Soon",
            image: .init(systemName: "play.circle"),
            tag: 1
        )
        
        let topSearchesViewController = UIViewController()
        topSearchesViewController.view.backgroundColor = .systemPink
        
        topSearchesViewController.tabBarItem = UITabBarItem(
            title: "Top Searches",
            image: .init(systemName: "magnifyingglass"),
            tag: 2
        )
        
        let downloadsViewController = UIViewController()
        downloadsViewController.view.backgroundColor = .systemPink
        
        downloadsViewController.tabBarItem = UITabBarItem(
            title: "Top Searches",
            image: .init(systemName: "arrow.down.to.line"),
            tag: 3
        )
        
        rootViewController.viewControllers = [
            homeCoordinator.rootViewController,
            commingSoonViewController,
            topSearchesViewController,
            downloadsViewController
        ]
    }
    
}
