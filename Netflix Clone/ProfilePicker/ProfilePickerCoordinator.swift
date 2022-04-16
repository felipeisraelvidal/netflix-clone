import UIKit
import ProfilePicker

final class ProfilePickerCoordinator: Coordinator {
    
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
        
        let viewModel = ProfilePickerViewModel()
        
        let viewController = ProfilePickerViewController(
            viewModel: viewModel
        )
        
        rootViewController.setViewControllers([viewController], animated: true)
        
    }
    
}
