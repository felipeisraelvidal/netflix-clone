import Foundation
import Core

protocol CollectionTableViewCellDelegate: AnyObject {
    func didSelectTitle(_ title: Title)
}
