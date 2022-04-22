import UIKit
import TopSearches
import TitlePreview
import TitlePlayer
import Core

final class TopSearchesCoordinator: Coordinator {
    
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
        
        let imageRequest = ImageRequest()
        
        let viewModel = TopSearchesViewModel(
            topSearchesService: TopSearchesService(),
            imageRequest: imageRequest,
            navigation: self
        )
        
        let searchResultsViewModel = SearchResultsViewModel(
            searchResultsService: SearchResultsService(),
            imageRequest: imageRequest
        )
        
        let viewController = TopSearchesViewController(
            viewModel: viewModel,
            searchResultsViewModel: searchResultsViewModel
        )
        
        rootViewController.tabBarItem = UITabBarItem(
            title: "Top Searches",
            image: .init(systemName: "magnifyingglass"),
            tag: 2
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

extension TopSearchesCoordinator: TopSearchesNavigation {
    
    func goToTitleDetails(_ title: Title) {
        presentTitleDetails(title)
    }
    
    func goToPlayTitle(_ title: Title) {
        presentTitlePlayer(title)
    }
    
}
