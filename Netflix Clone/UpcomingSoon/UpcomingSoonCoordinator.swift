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
            titleID: title.id,
            mediaType: title.mediaType ?? "",
            titlePreviewService: TitlePreviewService(),
            imageRequest: ImageRequest()
        )
        
        let viewController = TitlePreviewViewController(
            viewModel: viewModel
        )
        
        rootViewController.pushViewController(viewController, animated: true)
    }
    
    private func presentTitlePlayer(_ title: Title) {
        let coordinator = TitlePlayerCoordinator(
            rootViewController: UINavigationController(),
            title: title
        )
        
        coordinator.parentCoordinator = self
        childCoordinators.append(coordinator)
        
        coordinator.start()
        
        rootViewController.topViewController?.present(coordinator.rootViewController, animated: true)
    }
    
}

extension UpcomingSoonCoordinator: UpcomingSoonNavigation {
    
    func goToTitleDetails(_ title: Title) {
        presentTitleDetails(title)
    }
    
    func goToPlayTitle(_ title: Title) {
        presentTitlePlayer(title)
    }
    
}
