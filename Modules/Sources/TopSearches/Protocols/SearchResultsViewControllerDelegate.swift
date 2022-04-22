import Foundation
import Core

protocol SearchResultsViewControllerDelegate: AnyObject {
    func didSelectTitle(_ title: Title)
}
