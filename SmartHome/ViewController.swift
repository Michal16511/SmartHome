//
//  ViewController.swift
//  SmartHome
//
//  Created by MacOS on 31/08/17.
//  Copyright © 2017 Michał Ryś. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private let screenSize = UIScreen.mainScreen().bounds
    
    var welcomeHome: UIView!
    var loginArea: UIView!
    var footer: UIView!
    var poweredBy: UIView!
    var userIcon: UIView!
    var inputLogin: UIView!
    var inputPassword: UIView!
    var inputAddress: UIView!
    var submit: UIButton!
    var login: UITextField!
    var password: UITextField!
    var address: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "backgroud_city.png")!)
        addViews()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func addViews()
    {
        let heightOfWelcomeHome = screenSize.height/8
        let widthOfWelcomeHome = screenSize.width/4*3
        let spacing = screenSize.height/8
        welcomeHome = UIView(frame: CGRect(x: screenSize.width/8, y: spacing, width: widthOfWelcomeHome, height: heightOfWelcomeHome))
        let welcomeHomeImage = UIImageView(frame: CGRectMake(0,0,widthOfWelcomeHome,heightOfWelcomeHome))
        welcomeHomeImage.image = UIImage(named: "welcome_home.png")
        welcomeHome.addSubview(welcomeHomeImage)
        view.addSubview(welcomeHome)

        addLoginArea(heightOfWelcomeHome)
        
        let heightOfFooter = screenSize.height/32*3
        let widthOfFooter = screenSize.width
        footer = UIView(frame: CGRect(x: 0, y: screenSize.height - spacing/4*3, width: widthOfFooter, height: heightOfFooter))
        let footerImage = UIImageView(frame: CGRectMake(0,0,widthOfFooter,heightOfFooter))
        footerImage.image = UIImage(named: "powered_background.png")
        footer.addSubview(footerImage)
        
        let heightOfPoweredBy = heightOfFooter/2
        let widthOfPoweredBy = widthOfFooter/3*2
        let poweredBy = UIView(frame: CGRect(x: widthOfFooter/2 - widthOfPoweredBy / 2, y: heightOfFooter / 2 - heightOfPoweredBy / 2, width: widthOfPoweredBy, height: heightOfPoweredBy))
        let poweredByImage = UIImageView(frame: CGRectMake(0, 0, widthOfPoweredBy, heightOfPoweredBy))
        poweredByImage.image = UIImage(named: "powered_smart_home.png")
        poweredBy.addSubview(poweredByImage)
        footer.addSubview(poweredBy)
        
        view.addSubview(footer)
    }

    func addLoginArea(heightOfWelcomeHome: CGFloat)
    {
        let mainSpacing = screenSize.height/8
        let heightOfLoginArea = screenSize.height/8*3
        let widthOfLoginArea = screenSize.width/4*3
        loginArea = UIView(frame: CGRect(x: screenSize.width/8, y: mainSpacing + heightOfWelcomeHome + mainSpacing/2, width: widthOfLoginArea, height: heightOfLoginArea))
        let loginAreaImage = UIImageView(frame: CGRectMake(0,0,widthOfLoginArea,heightOfLoginArea + mainSpacing))
        loginAreaImage.image = UIImage(named: "loginarea.png")
        loginArea.addSubview(loginAreaImage)
        
        let spacing = heightOfLoginArea/18
        
        let heightOfUserIcon = heightOfLoginArea/9*3
        let widthOfUserIcon = widthOfLoginArea/3*2
        userIcon = UIView(frame: CGRect(x: widthOfLoginArea/2 - widthOfUserIcon / 2, y: spacing, width: widthOfUserIcon, height: heightOfUserIcon))
        let userIconImage = UIImageView(frame: CGRectMake(0, 0, widthOfUserIcon, heightOfUserIcon))
        userIconImage.image = UIImage(named: "user_icon.png")
        userIcon.addSubview(userIconImage)
        loginArea.addSubview(userIcon)
        
        let heightOfInput = heightOfLoginArea/9*6/3
        let widthOfInput = widthOfLoginArea
        
        inputLogin = UIView(frame: CGRect(x: 0, y: spacing + heightOfUserIcon + spacing, width: widthOfInput, height: heightOfInput))
        let inputImageLogin = UIImageView(frame: CGRectMake(0, 0, widthOfInput, heightOfInput))
        inputImageLogin.image = UIImage(named: "level_login_area.png")
        inputLogin.addSubview(inputImageLogin)
        loginArea.addSubview(inputLogin)
        
        let heightOfLabel = heightOfInput/4*3
        let widthOfLabel = widthOfInput/4
        
        let widthOfTextField = widthOfInput / 2 + 20
        let heightOfTextField = heightOfInput / 2
        
        let labelLogin = UILabel(frame: CGRect(x: widthOfInput / 6 - widthOfLabel / 2, y: heightOfInput / 2 - heightOfLabel / 2, width: widthOfLabel - 20, height: heightOfLabel))
        labelLogin.text = "Login"
        labelLogin.font = labelLogin.font.fontWithSize(40)
        labelLogin.adjustsFontSizeToFitWidth = true
        labelLogin.minimumScaleFactor = 0.2
        labelLogin.numberOfLines = 0
        labelLogin.textColor = UIColor(red: 255.0, green:  255.0, blue: 255.0, alpha: 255.0)
        inputLogin.addSubview(labelLogin)
        
        login = UITextField(frame: CGRect(x: widthOfInput / 6 + widthOfLabel*3/2 + 30 - widthOfTextField / 2, y: heightOfInput / 2 - heightOfTextField / 2, width: widthOfTextField, height: heightOfTextField))
        login.textColor = UIColor.whiteColor()
        inputLogin.addSubview(login)
        
        inputPassword = UIView(frame: CGRect(x: 0, y: spacing + heightOfUserIcon + spacing + heightOfInput, width: widthOfInput, height: heightOfInput))
        let inputImagePassword = UIImageView(frame: CGRectMake(0, 0, widthOfInput, heightOfInput))
        inputImagePassword.image = UIImage(named: "level_login_area.png")
        inputPassword.addSubview(inputImagePassword)
        loginArea.addSubview(inputPassword)
        
        let labelPassword = UILabel(frame: CGRect(x: widthOfInput / 6 - widthOfLabel / 2, y: heightOfInput / 2 - heightOfLabel / 2, width: widthOfLabel + 10, height: heightOfLabel))
        labelPassword.text = "Password"
        labelPassword.font = labelPassword.font.fontWithSize(40)
        labelPassword.adjustsFontSizeToFitWidth = true
        labelPassword.minimumScaleFactor = 0.2
        labelPassword.numberOfLines = 0
        labelPassword.textColor = UIColor(red: 255.0, green:  255.0, blue: 255.0, alpha: 255.0)
        inputPassword.addSubview(labelPassword)
        
        password = UITextField(frame: CGRect(x: widthOfInput / 6 + widthOfLabel*3/2 + 30 - widthOfTextField / 2, y: heightOfInput / 2 - heightOfTextField / 2, width: widthOfTextField, height: heightOfTextField))
        password.secureTextEntry = true
        password.textColor = UIColor.whiteColor()
        inputPassword.addSubview(password)
        
        inputAddress = UIView(frame: CGRect(x: 0, y: spacing + heightOfUserIcon + spacing + 2 * heightOfInput, width: widthOfInput, height: heightOfInput))
        let inputImageAddress = UIImageView(frame: CGRectMake(0, 0, widthOfInput, heightOfInput))
        inputImageAddress.image = UIImage(named: "level_login_area.png")
        inputAddress.addSubview(inputImageAddress)
        loginArea.addSubview(inputAddress)
        
        address = UITextField(frame: CGRect(x: widthOfInput / 6 + widthOfLabel*3/2 + 30 - widthOfTextField / 2, y: heightOfInput / 2 - heightOfTextField / 2, width: widthOfTextField, height: heightOfTextField))
        address.textColor = UIColor.whiteColor()
        inputAddress.addSubview(address)
        
        let labelAddress = UILabel(frame: CGRect(x: widthOfInput / 6 - widthOfLabel / 2, y: heightOfInput / 2 - heightOfLabel / 2, width: widthOfLabel, height: heightOfLabel))
        labelAddress.text = "Address"
        labelAddress.font = labelAddress.font.fontWithSize(40)
        labelAddress.adjustsFontSizeToFitWidth = true
        labelAddress.minimumScaleFactor = 0.2
        labelAddress.numberOfLines = 0
        labelAddress.textColor = UIColor(red: 255.0, green:  255.0, blue: 255.0, alpha: 255.0)
        inputAddress.addSubview(labelAddress)
        
        let widthOfSubmit = CGFloat(80)
        let heightOfSubmit = CGFloat(30)
        submit = UIButton(frame: CGRect(x: widthOfLoginArea / 2 - widthOfSubmit / 2, y: spacing + heightOfUserIcon + spacing + 3 * heightOfInput + spacing - 2, width: widthOfSubmit, height: heightOfSubmit))

        submit.setTitle("Submit", forState: .Normal)
        
        loginArea.addSubview(submit)
        
        view.addSubview(loginArea)
    }
}
