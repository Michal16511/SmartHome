//
//  ShuttersTableViewCell.swift
//  SmartHome
//
//  Created by MacOS on 22/12/17.
//  Copyright © 2017 Michał Ryś. All rights reserved.
//

import UIKit

protocol ShutterCellDelegate: class {
    func shutterUpBtnPressed(shutter: Shutter?)
    func shutterBottomBtnPressed(shutter: Shutter?)
    func shutterStopBtnPressed(shutter: Shutter?)
}

class ShuttersTableViewCell: UITableViewCell {
    
    weak var delegate: ShutterCellDelegate?
    let screenSize: CGRect
    var backgroudImage: UIImageView
    var shuttersName: UILabel
    var shutter: Shutter
    private var upBtn: UIButton
    private var bottomBtn: UIButton
    private var stopBtn: UIButton
    private var bottomImage: UIImageView
    private var upImage: UIImageView
    private var stopImage: UIImageView
    private var shutterImage: UIImageView
    
    init(){
        self.shutter = Shutter()
        screenSize = UIScreen.mainScreen().bounds
        backgroudImage = UIImageView()
        shuttersName = UILabel()
        upBtn = UIButton()
        bottomBtn = UIButton()
        stopBtn = UIButton()
        stopImage = UIImageView()
        upImage = UIImageView()
        bottomImage = UIImageView()
        shutterImage = UIImageView()
        super.init(style: .Default, reuseIdentifier: "SettingCell")
        setUpCell()
    }
    
    init(shutter: Shutter, delegate: ShutterCellDelegate){
        self.shutter = shutter
        screenSize = UIScreen.mainScreen().bounds
        backgroudImage = UIImageView()
        shuttersName = UILabel()
        shuttersName.text = self.shutter.name
        self.delegate = delegate
        upBtn = UIButton()
        bottomBtn = UIButton()
        stopBtn = UIButton()
        stopImage = UIImageView()
        upImage = UIImageView()
        bottomImage = UIImageView()
        shutterImage = UIImageView()
        super.init(style: .Default, reuseIdentifier: "SettingCell")
        setUpCell()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpCell() {
        
        self.backgroundColor = UIColor(patternImage: UIImage(named: "backgroud_city.png")!)
        self.contentView.addSubview(backgroudImage)
        
        upImage.image = UIImage(named: "arrowUp.png")
        upBtn.addSubview(upImage)
        upBtn.addTarget(self, action: "upAction", forControlEvents: UIControlEvents.TouchUpInside)
        self.contentView.addSubview(upBtn)
        
        bottomImage.image = UIImage(named: "bottomArrow.png")
        bottomBtn.addSubview(bottomImage)
        bottomBtn.addTarget(self, action: "bottomAction", forControlEvents: UIControlEvents.TouchUpInside)
        self.contentView.addSubview(bottomBtn)
        
        stopImage.image = UIImage(named: "stop.png")
        stopBtn.addSubview(stopImage)
        stopBtn.addTarget(self, action: "stopAction", forControlEvents: UIControlEvents.TouchUpInside)
        self.contentView.addSubview(stopBtn)
        
        shutterImage.image = UIImage(named: "main_menu_shutters.png")
        self.contentView.addSubview(shutterImage)
        shuttersName.font = shuttersName.font.fontWithSize(16)
        shuttersName.adjustsFontSizeToFitWidth = true
        shuttersName.minimumScaleFactor = 0.2
        shuttersName.numberOfLines = 0
        shuttersName.textColor = UIColor(red: 255.0, green:  255.0, blue: 255.0, alpha: 255.0)
        self.contentView.addSubview(shuttersName)
        setupContstraints()
    }
    
    func setupContstraints(){
        
        backgroudImage.translatesAutoresizingMaskIntoConstraints = false
        backgroudImage.topAnchor.constraintEqualToAnchor(self.topAnchor).active = true
        backgroudImage.bottomAnchor.constraintEqualToAnchor(self.bottomAnchor).active = true
        backgroudImage.leadingAnchor.constraintEqualToAnchor(self.leadingAnchor).active = true
        backgroudImage.trailingAnchor.constraintEqualToAnchor(self.trailingAnchor).active = true
        
        shuttersName.translatesAutoresizingMaskIntoConstraints = false
        shuttersName.topAnchor.constraintEqualToAnchor(self.topAnchor).active = true
        shuttersName.bottomAnchor.constraintEqualToAnchor(self.bottomAnchor).active = true
        shuttersName.widthAnchor.constraintEqualToConstant(70).active = true
        shuttersName.leadingAnchor.constraintEqualToAnchor(self.leadingAnchor, constant: 20).active = true
      
        upBtn.translatesAutoresizingMaskIntoConstraints = false
        upBtn.centerYAnchor.constraintEqualToAnchor(self.centerYAnchor).active = true
        upBtn.heightAnchor.constraintEqualToConstant(25).active = true
        upBtn.leadingAnchor.constraintEqualToAnchor(shuttersName.trailingAnchor, constant: 15).active = true
        upBtn.widthAnchor.constraintEqualToConstant(30).active = true

        upImage.translatesAutoresizingMaskIntoConstraints = false
        upImage.topAnchor.constraintEqualToAnchor(upBtn.topAnchor).active = true
        upImage.bottomAnchor.constraintEqualToAnchor(upBtn.bottomAnchor).active = true
        upImage.leadingAnchor.constraintEqualToAnchor(upBtn.leadingAnchor).active = true
        upImage.trailingAnchor.constraintEqualToAnchor(upBtn.trailingAnchor).active = true
        
        bottomBtn.translatesAutoresizingMaskIntoConstraints = false
        bottomBtn.topAnchor.constraintEqualToAnchor(self.topAnchor, constant: 14).active = true
        bottomBtn.heightAnchor.constraintEqualToConstant(25).active = true
        bottomBtn.leadingAnchor.constraintEqualToAnchor(upBtn.trailingAnchor, constant: 15).active = true
        bottomBtn.widthAnchor.constraintEqualToConstant(30).active = true
        
        bottomImage.translatesAutoresizingMaskIntoConstraints = false
        bottomImage.topAnchor.constraintEqualToAnchor(bottomBtn.topAnchor).active = true
        bottomImage.bottomAnchor.constraintEqualToAnchor(bottomBtn.bottomAnchor).active = true
        bottomImage.leadingAnchor.constraintEqualToAnchor(bottomBtn.leadingAnchor).active = true
        bottomImage.trailingAnchor.constraintEqualToAnchor(bottomBtn.trailingAnchor).active = true
        
        stopBtn.translatesAutoresizingMaskIntoConstraints = false
        stopBtn.topAnchor.constraintEqualToAnchor(self.topAnchor, constant: 14).active = true
        stopBtn.heightAnchor.constraintEqualToConstant(25).active = true
        stopBtn.leadingAnchor.constraintEqualToAnchor(bottomBtn.trailingAnchor, constant: 15).active = true
        stopBtn.widthAnchor.constraintEqualToConstant(30).active = true
        
        stopImage.translatesAutoresizingMaskIntoConstraints = false
        stopImage.topAnchor.constraintEqualToAnchor(stopBtn.topAnchor).active = true
        stopImage.bottomAnchor.constraintEqualToAnchor(stopBtn.bottomAnchor).active = true
        stopImage.leadingAnchor.constraintEqualToAnchor(stopBtn.leadingAnchor).active = true
        stopImage.trailingAnchor.constraintEqualToAnchor(stopBtn.trailingAnchor).active = true
        
        shutterImage.translatesAutoresizingMaskIntoConstraints = false
        shutterImage.heightAnchor.constraintEqualToConstant(30).active = true
        shutterImage.widthAnchor.constraintEqualToConstant(30).active = true
        shutterImage.centerYAnchor.constraintEqualToAnchor(self.centerYAnchor).active = true
        shutterImage.trailingAnchor.constraintEqualToAnchor(self.trailingAnchor, constant: -15).active = true
    }
    
    func upAction() {
        delegate?.shutterUpBtnPressed(self.shutter)
    }
    
    func bottomAction() {
        delegate?.shutterBottomBtnPressed(self.shutter)
    }
    
    func stopAction() {
        delegate?.shutterStopBtnPressed(self.shutter)
    }
    
}
