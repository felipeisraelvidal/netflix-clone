import UIKit
import Home
import Core
import TitlePreview
import TitlePlayer

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
        
        let imageRequest = ImageRequest()
        
        let viewModel = HomeViewModel(
            homeService: HomeService(),
            imageRequest: imageRequest,
            navigation: self
        )
        
        let heroViewModel = HeroViewModel(
            heroService: HeroService(),
            imageRequest: imageRequest
        )
        
        let viewController = HomeViewController(
            viewModel: viewModel,
            heroViewModel: heroViewModel
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
            titleID: title.id,
            mediaType: title.mediaType ?? "",
            titlePreviewService: TitlePreviewService()
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

extension HomeCoordinator: HomeNavigation {
    
    func goToProfilePicker() {
        presentProfilePicker()
    }
    
    func goToTitleDetails(_ title: Title) {
        presentTitleDetails(title)
    }
    
    func goToPlayTitle(_ title: Title) {
        presentTitlePlayer(title)
    }
    
}
