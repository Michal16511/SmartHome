//
//  SequenceTableViewCell.swift
//  SmartHome
//
//  Created by MacOS on 25/11/17.
//  Copyright © 2017 Michał Ryś. All rights reserved.
//

import UIKit

class SequenceElementTableViewCell: UITableViewCell {

    let screenSize: CGRect
    var action: UITextField
    var backgroudImage: UIImageView
    var deleteIcon: UIImageView
    var actionLabel: UILabel
    
    init(){
        action = UITextField()
        screenSize = UIScreen.mainScreen().bounds
        backgroudImage = UIImageView()
        deleteIcon = UIImageView()
        actionLabel = UILabel()
        super.init(style: .Default, reuseIdentifier: "SettingCell")
        setUpCell()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpCell() {
        
        self.backgroundColor = UIColor(patternImage: UIImage(named: "backgroud_city.png")!)
        self.contentView.addSubview(backgroudImage)
        
        action.textColor = UIColor(red: 255.0, green:  255.0, blue: 255.0, alpha: 255.0)
        self.contentView.addSubview(action)
        deleteIcon.image = UIImage(named: "delete.png")
        self.contentView.addSubview(deleteIcon)
        actionLabel.text = "Action: "
        actionLabel.font = actionLabel.font.fontWithSize(20)
        actionLabel.adjustsFontSizeToFitWidth = true
        actionLabel.minimumScaleFactor = 0.2
        actionLabel.numberOfLines = 0
        actionLabel.textColor = UIColor(red: 255.0, green:  255.0, blue: 255.0, alpha: 255.0)
        self.contentView.addSubview(actionLabel)
        setupContstraints()
    }
    
    func setupContstraints(){
        
        backgroudImage.translatesAutoresizingMaskIntoConstraints = false
        backgroudImage.topAnchor.constraintEqualToAnchor(self.topAnchor).active = true
        backgroudImage.bottomAnchor.constraintEqualToAnchor(self.bottomAnchor).active = true
        backgroudImage.leadingAnchor.constraintEqualToAnchor(self.leadingAnchor).active = true
        backgroudImage.trailingAnchor.constraintEqualToAnchor(self.trailingAnchor).active = true
        
        actionLabel.translatesAutoresizingMaskIntoConstraints = false
        actionLabel.topAnchor.constraintEqualToAnchor(self.topAnchor).active = true
        actionLabel.bottomAnchor.constraintEqualToAnchor(self.bottomAnchor).active = true
        actionLabel.leadingAnchor.constraintEqualToAnchor(self.leadingAnchor, constant: screenSize.width * 0.06).active = true
        actionLabel.trailingAnchor.constraintEqualToAnchor(self.leadingAnchor, constant: screenSize.width * 0.3).active = true
        
        action.translatesAutoresizingMaskIntoConstraints = false
        action.topAnchor.constraintEqualToAnchor(self.topAnchor).active = true
        action.bottomAnchor.constraintEqualToAnchor(self.bottomAnchor).active = true
        action.leadingAnchor.constraintEqualToAnchor(actionLabel.trailingAnchor).active = true
        action.trailingAnchor.constraintEqualToAnchor(self.leadingAnchor, constant: screenSize.width * 0.75).active = true
        
        deleteIcon.translatesAutoresizingMaskIntoConstraints = false
        deleteIcon.topAnchor.constraintEqualToAnchor(self.topAnchor, constant: 10).active = true
        deleteIcon.bottomAnchor.constraintEqualToAnchor(self.bottomAnchor, constant: -5).active = true
        deleteIcon.leadingAnchor.constraintEqualToAnchor(action.trailingAnchor).active = true
        deleteIcon.trailingAnchor.constraintEqualToAnchor(self.trailingAnchor, constant: (-1) * screenSize.width * 0.05).active = true
    }

    internal func getAction() -> String{
        return action.text!
    }
}
