import Foundation

public extension MutableCollection {
    
    mutating func mapProperty<T>(_ keyPath: WritableKeyPath<Element, T>, value: T) {
        indices.forEach({ self[$0][keyPath: keyPath] = value })
    }
    
}
