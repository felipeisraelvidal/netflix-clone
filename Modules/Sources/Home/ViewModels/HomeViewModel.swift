import Foundation
import Networking
import Core

public final class HomeViewModel {
    
    private let homeService: HomeServiceProtocol
    let imageRequest: ImageRequestProtocol
    
    weak var navigation: HomeNavigation!
    
    private(set) var sections: [HomeSection] = []
    
    public init(
        homeService: HomeServiceProtocol,
        imageRequest: ImageRequestProtocol,
        navigation: HomeNavigation
    ) {
        self.homeService = homeService
        self.imageRequest = imageRequest
        self.navigation = navigation
        
        homeService.buildSections { [weak self] sections in
            self?.sections = sections
        }
    }
    
    // MARK: - Public methods
    
    public func fetchHeroTitle(_ completion: @escaping (Result<Title?, Error>) -> Void) {
        homeService.fetchHero(completion)
    }
    
    func goToProfilePicker() {
        navigation.goToProfilePicker()
    }
    
    func playTitle(_ title: Title) {
        navigation.goToPlayTitle(title)
    }
    
    func downloadTitle(_ title: Title) {
        homeService.downloadTitle(title) {
            print("Title downloaded successfully")
        }
    }
    
    func goToTitleDetails(title: Title) {
        navigation.goToTitleDetails(title)
    }
    
}
