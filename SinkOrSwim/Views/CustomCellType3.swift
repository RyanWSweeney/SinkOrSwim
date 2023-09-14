//
//  CustomCellType3.swift
//  SinkOrSwim
//
//  Created by Ryan Sweeney on 9/13/23.
//

import UIKit

class CustomCellType3: UITableViewCell {

    // 1. Create a UILabel property
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // 2. Add the label to the cell's contentView
        contentView.addSubview(titleLabel)
        
        // 3. Set up constraints for the label
        setupConstraints()
        
        // Set default text
        titleLabel.text = "Default Title"
        
        // Add a tap gesture recognizer to change the background color when tapped
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(changeBackgroundColor))
        addGestureRecognizer(tapGesture)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15), // 15 padding from the leading side
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15), // 15 padding from the trailing side
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor) // center the label vertically in the cell
        ])
    }

    @objc private func changeBackgroundColor() {
        contentView.backgroundColor = randomColor()
    }

    //generate random
    private func randomColor() -> UIColor {
        let red = CGFloat(arc4random_uniform(256)) / 255.0
        let green = CGFloat(arc4random_uniform(256)) / 255.0
        let blue = CGFloat(arc4random_uniform(256)) / 255.0
        return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }
}

