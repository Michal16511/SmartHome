//
//  SequenceTableViewCell.swift
//  SmartHome
//
//  Created by MacOS on 29/11/17.
//  Copyright © 2017 Michał Ryś. All rights reserved.
//

import UIKit
import RealmSwift

class SequenceTableViewCell: UITableViewCell {
    
    let screenSize: CGRect
    var backgroudImage: UIImageView
    var deleteBtn: UIButton
    var actionLabel: UILabel
    
    init(name: String){
        screenSize = UIScreen.mainScreen().bounds
        backgroudImage = UIImageView()
        actionLabel = UILabel()
        deleteBtn = UIButton()
        super.init(style: .Default, reuseIdentifier: "SettingCell")
        setUpCell(name)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpCell(name: String) {
        
        self.backgroundColor = UIColor(patternImage: UIImage(named: "backgroud_city.png")!)
        self.contentView.addSubview(backgroudImage)
        
        action.textColor = UIColor(red: 255.0, green:  255.0, blue: 255.0, alpha: 255.0)
        self.contentView.addSubview(action)
        deleteBtn.imageView?.image = UIImage(named: "delete.png")
        deleteBtn.addTarget(self, action: "deleteAction", forControlEvents: UIControlEvents.TouchUpInside)
        self.contentView.addSubview(deleteBtn)
        actionLabel.text = name
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
        actionLabel.trailingAnchor.constraintEqualToAnchor(self.leadingAnchor, constant: screenSize.width * 0.4).active = true
        
        deleteBtn.translatesAutoresizingMaskIntoConstraints = false
        deleteBtn.topAnchor.constraintEqualToAnchor(self.topAnchor, constant: 10).active = true
        deleteBtn.bottomAnchor.constraintEqualToAnchor(self.bottomAnchor, constant: -5).active = true
        deleteBtn.leadingAnchor.constraintEqualToAnchor(self.trailingAnchor, constant: (-1) * screenSize.width * 0.2).active = true
        deleteBtn.trailingAnchor.constraintEqualToAnchor(self.trailingAnchor, constant: (-1) * screenSize.width * 0.05).active = true
    }
    
    internal func getAction() -> String{
        return action.text!
    }
    
    func deleteAction() {
        
        let realm = try! Realm()
        let sequence = realm.objects(Sequence).filter("name = %@", actionLabel.text).first
        
        try! realm.write {
            realm.delete(sequence)
        }
    }
}
