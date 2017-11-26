//
//  TableViewCell.swift
//  SmartHome
//
//  Created by MacOS on 31/10/17.
//  Copyright © 2017 Michał Ryś. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    let screenSize: CGRect
    var picture: UIImageView
    internal var label: UILabel
    var backgroudImage: UIImageView
    var isTurnOn = false
    
    init(labelText: String, imageName: String){
        label = UILabel()
        picture = UIImageView()
        screenSize = UIScreen.mainScreen().bounds
        backgroudImage = UIImageView()
        super.init(style: .Default, reuseIdentifier: "SettingCell")
        setUpCell(labelText, imageName: imageName)
    }
    
    init(){
        label = UILabel()
        picture = UIImageView()
        screenSize = UIScreen.mainScreen().bounds
        backgroudImage = UIImageView()
        super.init(style: .Default, reuseIdentifier: "SettingCell")
    }
    
     required init?(coder aDecoder: NSCoder) {
         fatalError("init(coder:) has not been implemented")
     }
    
    func setUpCell(labelText: String, imageName: String) {
        
        
        self.backgroundColor = UIColor(patternImage: UIImage(named: "backgroud_city.png")!)
        self.contentView.addSubview(backgroudImage)
        
        label.text = labelText
        label.font = label.font.fontWithSize(20)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.2
        label.numberOfLines = 0
        label.textColor = UIColor(red: 255.0, green:  255.0, blue: 255.0, alpha: 255.0)
        self.contentView.addSubview(label)
        
        picture.image = UIImage(named: imageName)
        self.contentView.addSubview(picture)
        
        setupContstraints()
    }
    
    func setupContstraints(){
        
        backgroudImage.translatesAutoresizingMaskIntoConstraints = false
        backgroudImage.topAnchor.constraintEqualToAnchor(self.topAnchor).active = true
        backgroudImage.bottomAnchor.constraintEqualToAnchor(self.bottomAnchor).active = true
        backgroudImage.leadingAnchor.constraintEqualToAnchor(self.leadingAnchor).active = true
        backgroudImage.trailingAnchor.constraintEqualToAnchor(self.trailingAnchor).active = true
        
        picture.translatesAutoresizingMaskIntoConstraints = false
        picture.topAnchor.constraintEqualToAnchor(self.topAnchor, constant:  10).active = true
        picture.bottomAnchor.constraintEqualToAnchor(self.bottomAnchor, constant: -5).active = true
        picture.leadingAnchor.constraintEqualToAnchor(self.leadingAnchor, constant: screenSize.width * 0.08).active = true
        picture.trailingAnchor.constraintEqualToAnchor(self.leadingAnchor, constant: screenSize.width * 0.2).active = true
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.topAnchor.constraintEqualToAnchor(self.topAnchor, constant: 5).active = true
        label.bottomAnchor.constraintEqualToAnchor(self.bottomAnchor, constant: -5).active = true
        label.leadingAnchor.constraintEqualToAnchor(picture.trailingAnchor, constant: screenSize.width * 0.3).active = true
        label.trailingAnchor.constraintEqualToAnchor(self.trailingAnchor, constant: -screenSize.width * 0.1).active = true
        
    }
    
    internal func toogleLight(){
        
        if(!isTurnOn){
            isTurnOn = true
            picture.image = UIImage(named: "lamp_on.png")
        }else{
            picture.image = UIImage(named: "lamp_off.png")
            isTurnOn = false
        }
    }
}
