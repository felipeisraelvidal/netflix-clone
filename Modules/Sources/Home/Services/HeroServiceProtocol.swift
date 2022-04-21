import Foundation
import Core

public protocol HeroServiceProtocol {
    func fetchHeroTitles(_ completion: @escaping (Result<[Title], Error>) -> Void)
}

#if DEBUG
struct DummyHeroService: HeroServiceProtocol {
    func fetchHeroTitles(_ completion: (Result<[Title], Error>) -> Void) {
        let titles: [Title] = [
            .init(
                id: 0,
                posterPath: "/moLnqJmZ00i2opS0bzCVcaGC0iI.jpg",
                originalName: "Title 1"
            ),
            .init(
                id: 1,
                posterPath: "/pLAeWgqXbTeJ2gQtNvRmdIncYsk.jpg",
                originalName: "Title 2"
            ),
            .init(
                id: 2,
                posterPath: "/7vbP28axycrpchnGSIydUseNkh6.jpg",
                originalName: "Title 3"
            )
        ]
        
        completion(.success(titles))
    }
}
#endif
