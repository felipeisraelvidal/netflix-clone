import UIKit
import UpcomingSoon
import TitlePreview
import Core

final class UpcomingSoonCoordinator: Coordinator {
    
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
        let viewModel = UpcomingSoonViewModel(
            upcomingSoonService: UpcomingSoonService(),
            imageRequest: ImageRequest(),
            navigation: self
        )
        
        let viewController = UpcomingSoonViewController(
            viewModel: viewModel
        )
        
        rootViewController.tabBarItem = UITabBarItem(
            title: "Comming Soon",
            image: .init(systemName: "play.circle"),
            tag: 1
        )
        
        rootViewController.setViewControllers([viewController], animated: false)
    }
    
    // MARK: - Private methods
    
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

extension UpcomingSoonCoordinator: UpcomingSoonNavigation {
    
    func goToTitleDetails(_ title: Title) {
        presentTitleDetails(title)
    }
    
}
