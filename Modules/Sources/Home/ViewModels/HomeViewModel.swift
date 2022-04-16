import Foundation
import Networking
import Core

public final class HomeViewModel {
    
    private let homeService: HomeServiceProtocol
    
    weak var navigation: HomeNavigation!
    
    private(set) var sections: [HomeSection] = []
    
    public init(
        homeService: HomeServiceProtocol,
        navigation: HomeNavigation
    ) {
        self.homeService = homeService
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
