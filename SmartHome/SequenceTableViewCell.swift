//
//  SequenceTableViewCell.swift
//  SmartHome
//
//  Created by MacOS on 29/11/17.
//  Copyright © 2017 Michał Ryś. All rights reserved.
//

import UIKit
import RealmSwift

protocol SequenceCellDelegate: class {
    func sequenceCellButtonPressed(sequence: Sequence?)
}

class SequenceTableViewCell: UITableViewCell {
    
    weak var delegate: SequenceCellDelegate?
    private let screenSize: CGRect
    private var backgroudImage: UIImageView
    private var deleteBtn: UIButton
    var actionLabel: UILabel
    var sequence: Sequence
    var buttonImage: UIImageView
    
    init(sequence: Sequence, delegate: SequenceCellDelegate){
        screenSize = UIScreen.mainScreen().bounds
        backgroudImage = UIImageView()
        actionLabel = UILabel()
        buttonImage = UIImageView()
        deleteBtn = UIButton(type: .Custom)
        self.delegate = delegate
        self.sequence = sequence
        super.init(style: .Default, reuseIdentifier: "SettingCell")
        setUpCell()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpCell() {
        
        self.backgroundColor = UIColor(patternImage: UIImage(named: "backgroud_city.png")!)
        self.contentView.addSubview(backgroudImage)
        
        buttonImage.image = UIImage(named: "delete.png")
        deleteBtn.addSubview(buttonImage)
        deleteBtn.addTarget(self, action: "deleteAction", forControlEvents: UIControlEvents.TouchUpInside)
        self.contentView.addSubview(deleteBtn)
        actionLabel.text = sequence.name
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
        actionLabel.trailingAnchor.constraintEqualToAnchor(self.leadingAnchor, constant: screenSize.width * 0.6).active = true
        
        deleteBtn.translatesAutoresizingMaskIntoConstraints = false
        deleteBtn.topAnchor.constraintEqualToAnchor(self.topAnchor, constant: 10).active = true
        deleteBtn.bottomAnchor.constraintEqualToAnchor(self.bottomAnchor, constant: -5).active = true
        deleteBtn.leadingAnchor.constraintEqualToAnchor(self.leadingAnchor, constant: screenSize.width * 0.8).active = true
        deleteBtn.trailingAnchor.constraintEqualToAnchor(self.trailingAnchor, constant: (-1) * screenSize.width * 0.05).active = true
        
        buttonImage.translatesAutoresizingMaskIntoConstraints = false
        buttonImage.topAnchor.constraintEqualToAnchor(deleteBtn.topAnchor).active = true
        buttonImage.bottomAnchor.constraintEqualToAnchor(deleteBtn.bottomAnchor).active = true
        buttonImage.leadingAnchor.constraintEqualToAnchor(deleteBtn.leadingAnchor).active = true
        buttonImage.trailingAnchor.constraintEqualToAnchor(deleteBtn.trailingAnchor).active = true
    }
    
    
    func deleteAction() {
        delegate?.sequenceCellButtonPressed(self.sequence)
    }
}
