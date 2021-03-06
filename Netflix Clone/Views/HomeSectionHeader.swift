//
//  HomeSectionHeader.swift
//  Netflix Clone
//
//  Created by Felipe Vidal on 27/12/21.
//

import UIKit

class HomeSectionHeader: UITableViewHeaderFooterView {
    
    static let identifier = "HomeSectionHeader"
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(for: .title3, weight: .semibold)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(titleLabel)
        
        applyConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func applyConstraints() {
        let titleLabelConstraints = [
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ]
        
        NSLayoutConstraint.activate(titleLabelConstraints)
    }

}
