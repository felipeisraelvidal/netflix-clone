import Foundation
import Core

public final class DownloadedTitlesViewModel {
    
    private let downloadedTitlesService: DownloadedTitlesServiceProtocol
    let imageRequest: ImageRequestProtocol
    
    private(set) var titles: [Title] = []
    
    public init(
        downloadedTitlesService: DownloadedTitlesServiceProtocol,
        imageRequest: ImageRequestProtocol
    ) {
        self.downloadedTitlesService = downloadedTitlesService
        self.imageRequest = imageRequest
    }
    
    // MARK: - Public methods
    
    func fetchDownloadedTitles(_ completion: (Error?) -> Void) {
        downloadedTitlesService.fetchDownloadedTitles { result in
            switch result {
            case .success(let titles):
                self.titles = titles
                completion(nil)
            case .failure(let error):
                completion(error)
            }
        }
    }
    
}
