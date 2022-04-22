import Foundation
import Core

public final class TitlePreviewViewModel {
    
    private let titleID: Int
    private let mediaType: String
    private let titlePreviewService: TitlePreviewServiceProtocol
    
    private(set) var title: Title?
    
    // MARK: - Initializers
    
    public init(
        titleID: Int,
        mediaType: String,
        titlePreviewService: TitlePreviewServiceProtocol
    ) {
        self.titleID = titleID
        self.mediaType = mediaType
        self.titlePreviewService = titlePreviewService
    }
    
    // MARK: - Public methods
    
    func getTitleDetails(_ completion: @escaping (Error?) -> Void) {
        titlePreviewService.getTitleDetails(titleID, mediaType: mediaType) { result in
            switch result {
            case .success(let title):
                self.title = title
                completion(nil)
            case .failure(let error):
                completion(error)
            }
        }
    }
    
}
