//
//  MainController.swift
//  SmartHome
//
//  Created by MacOS on 25/09/17.
//  Copyright © 2017 Michał Ryś. All rights reserved.
//

import UIKit
import RealmSwift

class MenuController: UIViewController{

    private let screenSize = UIScreen.mainScreen().bounds
    private var top = UIView()
    private var footer = UIView()
    private var menuButton = UIButton()
    private var topImage = UIImageView()
    private var poweredBy = UIImageView()
    private var footerImage = UIImageView()
    private var footerDescription = UIImageView()
    private var containerView = UIView()
    private var mainMenu = MainMenuViewController()
    private var titleBar = UIView()
    private var titleWindow = UIImageView()
    private var titleBarImage = UIImageView()
    private var menuLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addChildViewController(mainMenu)
        mainMenu.view.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "backgroud_city.png")!)
        addViews()
        setupConstraints()
        mainMenu.didMoveToParentViewController(self)
        
       
        
        
        populateDefaultLights()
        
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }

    func setupConstraints() {
        top.translatesAutoresizingMaskIntoConstraints = false
        top.topAnchor.constraintEqualToAnchor(topLayoutGuide.bottomAnchor).active = true
        top.heightAnchor.constraintEqualToConstant(screenSize.size.height * 0.1).active = true
        top.leadingAnchor.constraintEqualToAnchor(view.leadingAnchor).active = true
        top.trailingAnchor.constraintEqualToAnchor(view.trailingAnchor).active = true
        
        topImage.translatesAutoresizingMaskIntoConstraints = false
        topImage.leadingAnchor.constraintEqualToAnchor(top.leadingAnchor).active = true
        topImage.trailingAnchor.constraintEqualToAnchor(top.trailingAnchor).active = true
        topImage.topAnchor.constraintEqualToAnchor(top.topAnchor).active = true
        topImage.bottomAnchor.constraintEqualToAnchor(top.bottomAnchor).active = true

        footer.translatesAutoresizingMaskIntoConstraints = false
        footer.bottomAnchor.constraintEqualToAnchor(view.bottomAnchor).active = true
        footer.heightAnchor.constraintEqualToConstant(screenSize.size.height * 0.1).active = true
        footer.leadingAnchor.constraintEqualToAnchor(view.leadingAnchor).active = true
        footer.trailingAnchor.constraintEqualToAnchor(view.trailingAnchor).active = true
        
        footerImage.translatesAutoresizingMaskIntoConstraints = false
        footerImage.leadingAnchor.constraintEqualToAnchor(footer.leadingAnchor).active = true
        footerImage.trailingAnchor.constraintEqualToAnchor(footer.trailingAnchor).active = true
        footerImage.topAnchor.constraintEqualToAnchor(footer.topAnchor).active = true
        footerImage.bottomAnchor.constraintEqualToAnchor(footer.bottomAnchor).active = true

        menuButton.translatesAutoresizingMaskIntoConstraints = false
        menuButton.leadingAnchor.constraintEqualToAnchor(top.leadingAnchor, constant: screenSize.width * 0.05).active = true
        menuButton.topAnchor.constraintEqualToAnchor(top.topAnchor, constant: 10).active = true
        menuButton.bottomAnchor.constraintEqualToAnchor(top.bottomAnchor, constant: -10).active = true
        menuButton.trailingAnchor.constraintEqualToAnchor(top.leadingAnchor, constant:screenSize.width * 0.18).active = true
        
        poweredBy.translatesAutoresizingMaskIntoConstraints = false
        poweredBy.leadingAnchor.constraintEqualToAnchor(menuButton.leadingAnchor).active = true
        poweredBy.trailingAnchor.constraintEqualToAnchor(top.trailingAnchor, constant: 0).active = true
        poweredBy.topAnchor.constraintEqualToAnchor(top.topAnchor).active = true
        poweredBy.bottomAnchor.constraintEqualToAnchor(top.bottomAnchor).active = true
        
        footerDescription.translatesAutoresizingMaskIntoConstraints = false
        footerDescription.topAnchor.constraintEqualToAnchor(footer.topAnchor, constant: 15).active = true
        footerDescription.bottomAnchor.constraintEqualToAnchor(footer.bottomAnchor, constant: -15).active = true
        footerDescription.leadingAnchor.constraintEqualToAnchor(footer.leadingAnchor, constant: 50).active = true
        footerDescription.trailingAnchor.constraintEqualToAnchor(footer.trailingAnchor, constant: -50).active = true
        
        titleBar.translatesAutoresizingMaskIntoConstraints = false
        titleBar.leadingAnchor.constraintEqualToAnchor(view.leadingAnchor).active = true
        titleBar.trailingAnchor.constraintEqualToAnchor(view.trailingAnchor).active = true
        titleBar.topAnchor.constraintEqualToAnchor(top.bottomAnchor).active = true
        titleBar.heightAnchor.constraintEqualToConstant(screenSize.size.height * 0.1).active = true
        
        titleBarImage.translatesAutoresizingMaskIntoConstraints = false
        titleBarImage.trailingAnchor.constraintEqualToAnchor(titleBar.trailingAnchor).active = true
        titleBarImage.leadingAnchor.constraintEqualToAnchor(titleBar.leadingAnchor).active = true
        titleBarImage.topAnchor.constraintEqualToAnchor(titleBar.topAnchor).active = true
        titleBarImage.bottomAnchor.constraintEqualToAnchor(titleBar.bottomAnchor).active = true
        
        titleWindow.translatesAutoresizingMaskIntoConstraints = false
        titleWindow.leadingAnchor.constraintEqualToAnchor(titleBar.leadingAnchor, constant: screenSize.width * 0.05).active = true
        titleWindow.trailingAnchor.constraintEqualToAnchor(titleBar.leadingAnchor, constant: screenSize.width * 0.18).active = true
        titleWindow.topAnchor.constraintEqualToAnchor(titleBar.topAnchor, constant: 10).active = true
        titleWindow.bottomAnchor.constraintEqualToAnchor(titleBar.bottomAnchor, constant: -10).active = true
        
        menuLabel.translatesAutoresizingMaskIntoConstraints = false
        menuLabel.topAnchor.constraintEqualToAnchor(titleBar.topAnchor, constant: 10).active = true
        menuLabel.bottomAnchor.constraintEqualToAnchor(titleBar.bottomAnchor, constant: -10).active = true
        menuLabel.centerXAnchor.constraintEqualToAnchor(titleBar.centerXAnchor, constant: screenSize.width * 0.08).active = true
        
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.topAnchor.constraintEqualToAnchor(titleBar.bottomAnchor).active = true
        containerView.bottomAnchor.constraintEqualToAnchor(footer.topAnchor).active = true
        containerView.leadingAnchor.constraintEqualToAnchor(view.leadingAnchor, constant: -1).active = true
        containerView.trailingAnchor.constraintEqualToAnchor(view.trailingAnchor).active = true
        
        mainMenu.view.topAnchor.constraintEqualToAnchor(containerView.topAnchor).active = true
        mainMenu.view.bottomAnchor.constraintEqualToAnchor(containerView.bottomAnchor).active = true
        mainMenu.view.leadingAnchor.constraintEqualToAnchor(containerView.leadingAnchor).active = true
        mainMenu.view.trailingAnchor.constraintEqualToAnchor(containerView.trailingAnchor).active = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func menuBtnAction() {
        let vc = LoginController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func addViews()
    {
        view.addSubview(top)
        topImage.image = UIImage(named: "pasek_gora.png")
        top.addSubview(topImage)
        
        poweredBy.image = UIImage(named: "logo.png")
        top.addSubview(poweredBy)
        
        let menuButtonImage = UIImage(named: "roll_menu.png")
        menuButton.setBackgroundImage(menuButtonImage, forState: UIControlState.Normal)
        menuButton.addTarget(self, action: "menuBtnAction", forControlEvents: UIControlEvents.TouchUpInside)
        top.addSubview(menuButton)
        
        titleBarImage.image = UIImage(named: "powered_background.png")
        titleBar.addSubview(titleBarImage)
        view.addSubview(titleBar)
        titleWindow.image = UIImage(named: "main_menu_icon.png")
        titleBar.addSubview(titleWindow)
        menuLabel.text = "Menu"
        menuLabel.font = menuLabel.font.fontWithSize(40)
        menuLabel.adjustsFontSizeToFitWidth = true
        menuLabel.minimumScaleFactor = 0.2
        menuLabel.numberOfLines = 0
        menuLabel.textColor = UIColor(red: 255.0, green:  255.0, blue: 255.0, alpha: 255.0)
        titleBar.addSubview(menuLabel)

        
        footerImage.image = UIImage(named: "powered_background.png")
        footer.addSubview(footerImage)
        view.addSubview(footer)
        
        footerDescription.image = UIImage(named: "powered_smart_home.png")
        footer.addSubview(footerDescription)
        
        containerView.addSubview(mainMenu.view)
        view.addSubview(containerView)
        
    }
    
    func populateDefaultLights() {
        
        let realm = try! Realm()
        let lights: Results<Light> = { realm.objects(Light) }()
        
        if lights.count == 0 {
            
            try! realm.write() {
                
                let defaultLights = ["Swiatlo kuchnia", "Swiatlo salon", "Swiatlo korytarz", "Swiatlo lazienka",
                    "Swiatlo sypialnia", "Swiatlo piwnica"]
                
                for light in defaultLights {
                    let newLight = Light()
                    newLight.imageName = "lamp_off.png"
                    newLight.name = light
                    realm.add(newLight)
                }
            }
        }
    }
    
}
