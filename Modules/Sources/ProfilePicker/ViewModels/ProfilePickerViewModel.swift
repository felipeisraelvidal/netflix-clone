import Foundation
import Core

public final class ProfilePickerViewModel {
    
    private(set) var profiles: [Profile] = [
        .init(
            name: "Roberta",
            color: .systemYellow
        ),
        .init(
            name: "Thaíssa",
            color: .systemGreen
        ),
        .init(
            name: "Pilar",
            color: .systemPink
        )
    ]
    
    public var isEditing = false
    
    public init() {
        
    }
    
}
