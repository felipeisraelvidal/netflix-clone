import Foundation
import Core

public final class HeroViewModel {
    
    private let heroService: HeroServiceProtocol
    let imageRequest: ImageRequestProtocol
    
    private(set) var titles: [Title] = []
    private(set) var currentTitle: Title?
    private(set) var currentIndex: Int = -1
    
    private var timer: Timer?
    
    var updateView: ((Title) -> Void)?
    
    public init(
        heroService: HeroServiceProtocol,
        imageRequest: ImageRequestProtocol
    ) {
        self.heroService = heroService
        self.imageRequest = imageRequest
    }
    
    func fetchTitles(_ completion: @escaping (Error?) -> Void) {
        heroService.fetchHeroTitles { result in
            switch result {
            case .success(let titles):
                self.titles = titles
                completion(nil)
            case .failure(let error):
                completion(error)
            }
        }
    }
    
    func startTimer() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(updateCarousel(_:)), userInfo: nil, repeats: true)
        
        if currentIndex == -1 {
            currentIndex = currentIndex + 1
        }
        selectTitle(from: currentIndex)
    }
    
    func pauseTimer() {
        timer?.invalidate()
    }
    
    // MARK: - Private methods
    
    @objc private func updateCarousel(_ timer: Timer) {
        currentIndex += 1
        if currentIndex == titles.count {
            currentIndex = 0
        }
        
        selectTitle(from: currentIndex)
    }
    
    private func selectTitle(from index: Int) {
        if let title = titles[safe: index] {
            currentTitle = title
            updateView?(title)
        }
    }
    
}
