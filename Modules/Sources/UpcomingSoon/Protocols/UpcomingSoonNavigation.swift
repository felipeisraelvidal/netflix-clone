import Foundation
import Core

public protocol UpcomingSoonNavigation: AnyObject {
    func goToTitleDetails(_ title: Title)
    func goToPlayTitle(_ title: Title)
}
