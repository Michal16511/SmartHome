//
//  MainController.swift
//  SmartHome
//
//  Created by MacOS on 25/09/17.
//  Copyright © 2017 Michał Ryś. All rights reserved.
//

import UIKit

class MainController: UIViewController {

    private let screenSize = UIScreen.mainScreen().bounds
    private var top: UIView!
    private var cellOfLight: UIView!
    private var cellOfTemperature: UIView!
    private var cellOfAlarm: UIView!
    private var cellOfShutter: UIView!
    private var cellOfClimate: UIView!
    private var cellVoiceControl: UIView!
    private var cellConfiguration: UIView!
    private var cell: UIView!
    private var footer: UIView!
    private var menuButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "backgroud_city.png")!)
        addViews()
        setupConstraints()
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }

    func setupConstraints() {
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func menuBtnAction() {
        let vc = LoginController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func addViews()
    {
        let spacing = screenSize.height/8
        let heightOfTop = screenSize.height/10
        let widthOfTop = screenSize.width
        top = UIView(frame: CGRect(x: 0, y: UIApplication.sharedApplication().statusBarFrame.size.height, width: widthOfTop, height: heightOfTop))
        let topImage = UIImageView(frame: CGRectMake(0,0,widthOfTop,heightOfTop))
        topImage.image = UIImage(named: "pasek_gora.png")
        top.addSubview(topImage)
        
        let heightOfPoweredBy = heightOfTop/2
        let widthOfPoweredBy = widthOfTop/3*2
        let poweredBy = UIView(frame: CGRect(x: widthOfTop/3 - widthOfPoweredBy / 2, y: heightOfTop / 2 - heightOfTop / 2, width: widthOfPoweredBy, height: heightOfPoweredBy))
        let poweredByImage = UIImageView(frame: CGRectMake(0, 0, widthOfPoweredBy, heightOfPoweredBy))
        poweredByImage.image = UIImage(named: "logo.png")
        poweredBy.addSubview(poweredByImage)
        
        let widthOfMenuButton = CGFloat(80)
        let heightOfMenuButton = CGFloat(30)
        menuButton = UIButton(frame: CGRect(x: 10, y: heightOfPoweredBy, width: widthOfMenuButton, height: heightOfMenuButton))
        
        //let menuButtonImage = UIImageView(frame: CGRectMake(0, 0,  widthOfMenuButton, heightOfMenuButton))
        let menuButtonImage = UIImage(named: "roll_menu.png")
        menuButton.setBackgroundImage(menuButtonImage, forState: UIControlState.Normal)
        menuButton.addTarget(self, action: "menuBtnAction", forControlEvents: UIControlEvents.TouchUpInside)
        
        top.addSubview(menuButton)
        top.addSubview(poweredBy)
        
        view.addSubview(top)
        
        let heightOfFooter = screenSize.height/32*3
        let widthOfFooter = screenSize.width
        footer = UIView(frame: CGRect(x: 0, y: screenSize.height - spacing/4*3, width: widthOfFooter, height: heightOfFooter))
        let footerImage = UIImageView(frame: CGRectMake(0,0,widthOfFooter,heightOfFooter))
        footerImage.image = UIImage(named: "powered_background.png")
        footer.addSubview(footerImage)
        
        view.addSubview(footer)
    }
}
