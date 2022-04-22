import Foundation
import Core

public protocol TopSearchesNavigation: AnyObject {
    func goToTitleDetails(_ title: Title)
    func goToPlayTitle(_ title: Title)
}
