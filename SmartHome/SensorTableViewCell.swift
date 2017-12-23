//
//  SensorTableViewCell.swift
//  SmartHome
//
//  Created by MacOS on 23/12/17.
//  Copyright © 2017 Michał Ryś. All rights reserved.
//

import UIKit

protocol SensorCellDelegate: class {
    func activationStateBtnPressed(sensor: Sensor?)
}

class SensorTableViewCell: UITableViewCell {
    
    weak var delegate: SensorCellDelegate?
    let screenSize: CGRect
    var backgroudImage: UIImageView
    var sensorNameWithState: UILabel
    var sensor: Sensor
    private var sensorBtn: UIButton
    private var sensorImage: UIImageView
    
    init(){
        self.sensor = Sensor()
        screenSize = UIScreen.mainScreen().bounds
        backgroudImage = UIImageView()
        sensorNameWithState = UILabel()
        sensor = Sensor()
        sensorImage = UIImageView()
        sensorBtn = UIButton()
        super.init(style: .Default, reuseIdentifier: "SettingCell")
        setUpCell()
    }
    
    init(sensor: Sensor, delegate: SensorCellDelegate){
        self.sensor = sensor
        screenSize = UIScreen.mainScreen().bounds
        backgroudImage = UIImageView()
        sensorNameWithState = UILabel()
        sensorNameWithState.text = self.sensor.name + " - " + self.sensor.state
        self.delegate = delegate
        sensorBtn = UIButton()
        sensorImage = UIImageView()
        super.init(style: .Default, reuseIdentifier: "SettingCell")
        setUpCell()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpCell() {
        
        self.backgroundColor = UIColor(patternImage: UIImage(named: "backgroud_city.png")!)
        self.contentView.addSubview(backgroudImage)
        
        sensorImage.image = UIImage(named: "arrowUp.png")
        sensorBtn.addSubview(sensorImage)
        sensorBtn.addTarget(self, action: "sensorBtnPressed", forControlEvents: UIControlEvents.TouchUpInside)
        self.contentView.addSubview(sensorBtn)
        
        sensorNameWithState.font = sensorNameWithState.font.fontWithSize(16)
        sensorNameWithState.adjustsFontSizeToFitWidth = true
        sensorNameWithState.minimumScaleFactor = 0.2
        sensorNameWithState.numberOfLines = 0
        sensorNameWithState.textColor = UIColor(red: 255.0, green:  255.0, blue: 255.0, alpha: 255.0)
        self.contentView.addSubview(sensorNameWithState)
        setupContstraints()
    }
    
    func setupContstraints(){
        
        backgroudImage.translatesAutoresizingMaskIntoConstraints = false
        backgroudImage.topAnchor.constraintEqualToAnchor(self.topAnchor).active = true
        backgroudImage.bottomAnchor.constraintEqualToAnchor(self.bottomAnchor).active = true
        backgroudImage.leadingAnchor.constraintEqualToAnchor(self.leadingAnchor).active = true
        backgroudImage.trailingAnchor.constraintEqualToAnchor(self.trailingAnchor).active = true
        
        sensorNameWithState.translatesAutoresizingMaskIntoConstraints = false
        sensorNameWithState.topAnchor.constraintEqualToAnchor(self.topAnchor).active = true
        sensorNameWithState.bottomAnchor.constraintEqualToAnchor(self.bottomAnchor).active = true
        sensorNameWithState.widthAnchor.constraintEqualToConstant(screenSize.width * 0.7).active = true
        sensorNameWithState.leadingAnchor.constraintEqualToAnchor(self.leadingAnchor, constant: 20).active = true
        
        sensorBtn.translatesAutoresizingMaskIntoConstraints = false
        sensorBtn.centerYAnchor.constraintEqualToAnchor(self.centerYAnchor).active = true
        sensorBtn.heightAnchor.constraintEqualToConstant(25).active = true
        sensorBtn.leadingAnchor.constraintEqualToAnchor(sensorNameWithState.trailingAnchor, constant: 15).active = true
        sensorBtn.widthAnchor.constraintEqualToConstant(30).active = true
        
        sensorImage.translatesAutoresizingMaskIntoConstraints = false
        sensorImage.topAnchor.constraintEqualToAnchor(sensorBtn.topAnchor).active = true
        sensorImage.bottomAnchor.constraintEqualToAnchor(sensorBtn.bottomAnchor).active = true
        sensorImage.leadingAnchor.constraintEqualToAnchor(sensorBtn.leadingAnchor).active = true
        sensorImage.trailingAnchor.constraintEqualToAnchor(sensorBtn.trailingAnchor).active = true
        
    }
    
    func sensorBtnPressed() {
        delegate?.activationStateBtnPressed(self.sensor)
    }
}
