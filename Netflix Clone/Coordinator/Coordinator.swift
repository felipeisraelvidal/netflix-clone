import UIKit

protocol CoordinatorBase: AnyObject {
    
    var parentCoordinator: CoordinatorBase? { get set }
    
    var childCoordinators: [CoordinatorBase] { get set }
    
}

protocol Coordinator: CoordinatorBase {
    
    associatedtype UIViewControllerType: UIViewController
    
    // MARK: Properties
    
    var rootViewController: UIViewControllerType { get set }
    
    // MARK: Initializers
    
    init(rootViewController: UIViewControllerType)
    
    // MARK: Methods
    
    func start()
    
}

extension CoordinatorBase {
    
    /// Removing a coordinator inside a children. This call is important to prevent memory leak.
    /// - Parameter coordinator: Coordinator that finished.
    func childDidFinish(_ coordinator: CoordinatorBase) {
        for (index, child) in childCoordinators.enumerated() {
            if child === coordinator {
                childCoordinators.remove(at: index)
                break
            }
        }
    }
    
}
