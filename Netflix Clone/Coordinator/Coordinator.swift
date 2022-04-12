import UIKit

protocol CoordinatorBase {}

protocol Coordinator: CoordinatorBase {
    
    associatedtype UIViewControllerType: UIViewController
    
    // MARK: Properties
    
    var childCoordinators: [CoordinatorBase] { get set }
    var rootViewController: UIViewControllerType { get set }
    
    // MARK: Initializers
    
    init(rootViewController: UIViewControllerType)
    
    // MARK: Methods
    
    func start()
    
}
