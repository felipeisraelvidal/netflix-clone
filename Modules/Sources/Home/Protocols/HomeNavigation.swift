import Foundation
import Core

public protocol HomeNavigation: AnyObject {
    func goToProfilePicker()
    func goToTitleDetails(_ title: Title)
    func goToPlayTitle(_ title: Title)
}
