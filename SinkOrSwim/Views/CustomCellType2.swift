//
//  CustomCellType2.swift
//  SinkOrSwim
//
//  Created by Ryan Sweeney on 9/13/23.
//

import UIKit

class CustomCellType2: UITableViewCell {
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        contentView.addSubview(titleLabel)
        titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8).isActive = true

        titleLabel.textColor = UIColor.black
        titleLabel.font = UIFont.systemFont(ofSize: 16)

        // Add a tap gesture recognizer to change text size when tapped
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(changeTextSize))
        titleLabel.addGestureRecognizer(tapGesture)
        titleLabel.isUserInteractionEnabled = true
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc private func changeTextSize() {
        let randomSize = CGFloat(arc4random_uniform(16) + 16) // Random font size between 16 and 31
        titleLabel.font = UIFont.systemFont(ofSize: randomSize)
    }
}
