import Foundation
import Core

public final class CollectionTableViewCellViewModel {
    
    let imageRequest: ImageRequestProtocol
    public private(set) var titles: [Title]
    
    public init(
        imageRequest: ImageRequestProtocol,
        titles: [Title]
    ) {
        self.imageRequest = imageRequest
        self.titles = titles
    }
    
}
