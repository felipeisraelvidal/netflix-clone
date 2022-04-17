import UIKit
import TitlePlayer
import Core

final class TitlePlayerCoordinator: Coordinator {
    
    typealias UIViewControllerType = UINavigationController
    
    // MARK: - Properties
    
    weak var parentCoordinator: CoordinatorBase?
    var childCoordinators: [CoordinatorBase] = []
    var rootViewController: UINavigationController
    
    private let title: Title?
    
    // MARK: - Initializers
    
    init(rootViewController: UINavigationController) {
        self.rootViewController = rootViewController
        self.title = nil
    }
    
    init(rootViewController: UINavigationController, title: Title) {
        self.rootViewController = rootViewController
        self.title = title
    }
    
    // MARK: - Public methods
    
    func start() {
        
        guard let title = title else { return }
        
        rootViewController.setNavigationBarHidden(true, animated: false)
        
        let viewModel = TitlePlayerViewModel(
            title: title
        )
        
        let viewController = TitlePlayerViewController(
            viewModel: viewModel
        )
        
        rootViewController.setViewControllers([viewController], animated: false)
        
    }
    
}
