//
//  SequenceTableViewCell.swift
//  SmartHome
//
//  Created by MacOS on 25/11/17.
//  Copyright © 2017 Michał Ryś. All rights reserved.
//

import UIKit

class SequenceTableViewCell: UITableViewCell {

    let screenSize: CGRect
    var action: UITextField
    var backgroudImage: UIImageView
    var deleteCellLabel: UILabel
    
    init(){
        action = UITextField()
        screenSize = UIScreen.mainScreen().bounds
        backgroudImage = UIImageView()
        deleteCellLabel = UILabel()
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
        
        deleteCellLabel.font = deleteCellLabel.font.fontWithSize(20)
        deleteCellLabel.adjustsFontSizeToFitWidth = true
        deleteCellLabel.minimumScaleFactor = 0.2
        deleteCellLabel.numberOfLines = 0
        deleteCellLabel.textColor = UIColor(red: 255.0, green:  255.0, blue: 255.0, alpha: 255.0)
        deleteCellLabel.text = "Remove action"
        self.contentView.addSubview(deleteCellLabel)
        
        setupContstraints()
    }
    
    func setupContstraints(){
        
        backgroudImage.translatesAutoresizingMaskIntoConstraints = false
        backgroudImage.topAnchor.constraintEqualToAnchor(self.topAnchor).active = true
        backgroudImage.bottomAnchor.constraintEqualToAnchor(self.bottomAnchor).active = true
        backgroudImage.leadingAnchor.constraintEqualToAnchor(self.leadingAnchor).active = true
        backgroudImage.trailingAnchor.constraintEqualToAnchor(self.trailingAnchor).active = true
        
        action.translatesAutoresizingMaskIntoConstraints = false
        action.topAnchor.constraintEqualToAnchor(self.topAnchor).active = true
        action.bottomAnchor.constraintEqualToAnchor(self.bottomAnchor).active = true
        action.leadingAnchor.constraintEqualToAnchor(self.leadingAnchor, constant: screenSize.width * 0.06).active = true
        action.trailingAnchor.constraintEqualToAnchor(self.leadingAnchor, constant: screenSize.width * 0.49).active = true
        
        deleteCellLabel.translatesAutoresizingMaskIntoConstraints = false
        deleteCellLabel.topAnchor.constraintEqualToAnchor(self.topAnchor).active = true
        deleteCellLabel.bottomAnchor.constraintEqualToAnchor(self.bottomAnchor).active = true
        deleteCellLabel.leadingAnchor.constraintEqualToAnchor(action.trailingAnchor).active = true
        deleteCellLabel.trailingAnchor.constraintEqualToAnchor(self.trailingAnchor).active = true
    }

    internal func getAction() -> String{
        return action.text!
    }
}
