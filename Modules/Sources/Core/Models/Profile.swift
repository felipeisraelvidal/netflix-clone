import Foundation
import UIKit

public struct Profile {
    public let id = UUID()
    public var name: String
    public var color: UIColor
    
    public init(name: String, color: UIColor) {
        self.name = name
        self.color = color
    }
}

