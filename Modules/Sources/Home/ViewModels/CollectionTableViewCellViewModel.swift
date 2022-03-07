import Foundation
import Core

public final class CollectionTableViewCellViewModel {
    
    public private(set) var titles: [Title]
    
    public init(titles: [Title]) {
        self.titles = titles
    }
    
}
