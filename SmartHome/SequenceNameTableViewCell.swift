//
//  SequenceNameTableViewCell.swift
//  SmartHome
//
//  Created by MacOS on 02/12/17.
//  Copyright © 2017 Michał Ryś. All rights reserved.
//

import UIKit

class SequenceNameTableViewCell: UITableViewCell {
    
    let screenSize: CGRect
    var sequenceName: UITextField
    var backgroudImage: UIImageView
    var actionLabel: UILabel
    var sequence: Sequence
    
    init(){
        self.sequence = Sequence()
        sequenceName = UITextField()
        screenSize = UIScreen.mainScreen().bounds
        backgroudImage = UIImageView()
        actionLabel = UILabel()
        super.init(style: .Default, reuseIdentifier: "SettingCell")
        setUpCell()
    }
    
    init(sequence: Sequence){
        self.sequence = sequence
        sequenceName = UITextField()
        sequenceName.text = sequence.name
        screenSize = UIScreen.mainScreen().bounds
        backgroudImage = UIImageView()
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
        
        sequenceName.textColor = UIColor(red: 255.0, green:  255.0, blue: 255.0, alpha: 255.0)
        sequenceName.addTarget(self, action: "textFieldDidChange", forControlEvents: UIControlEvents.EditingChanged)
        self.contentView.addSubview(sequenceName)
        actionLabel.text = "Sequence name: "
        actionLabel.font = actionLabel.font.fontWithSize(16)
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
        actionLabel.trailingAnchor.constraintEqualToAnchor(self.leadingAnchor, constant: screenSize.width * 0.5).active = true
        
        sequenceName.translatesAutoresizingMaskIntoConstraints = false
        sequenceName.topAnchor.constraintEqualToAnchor(self.topAnchor).active = true
        sequenceName.bottomAnchor.constraintEqualToAnchor(self.bottomAnchor).active = true
        sequenceName.leadingAnchor.constraintEqualToAnchor(actionLabel.trailingAnchor).active = true
        sequenceName.trailingAnchor.constraintEqualToAnchor(self.trailingAnchor).active = true
        
    }
    
    func textFieldDidChange() {
        print(sequenceName.text)
    }
    
    internal func getSequenceName() -> String{
        return sequenceName.text!
    }
}
