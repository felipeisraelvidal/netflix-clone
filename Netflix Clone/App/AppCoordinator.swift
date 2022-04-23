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
        
        let topSearchesCoordinator = TopSearchesCoordinator(rootViewController: UINavigationController())
        topSearchesCoordinator.parentCoordinator = self
        childCoordinators.append(topSearchesCoordinator)
        
        topSearchesCoordinator.start()
        
        // Downloads
        
        let downloadedTitlesCoordinator = DownloadedTitlesCoordinator(rootViewController: UINavigationController())
        downloadedTitlesCoordinator.parentCoordinator = self
        childCoordinators.append(downloadedTitlesCoordinator)
        
        downloadedTitlesCoordinator.start()
        
        //
        
        rootViewController.viewControllers = [
            homeCoordinator.rootViewController,
            upcomingSoonCoordinator.rootViewController,
            topSearchesCoordinator.rootViewController,
            downloadedTitlesCoordinator.rootViewController
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
