//
//  MainMenuViewController.swift
//  SmartHome
//
//  Created by MacOS on 02/11/17.
//  Copyright © 2017 Michał Ryś. All rights reserved.
//

import UIKit

class MainMenuViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {
    
    private let screenSize = UIScreen.mainScreen().bounds
    private var tableView = UITableView()
    private var tableViewContainer = UIView()
    
    private var cells: [TableViewCell] = [TableViewCell(labelText: "Lights", imageName: "main_menu_lamps.png"),
        TableViewCell(labelText: "Temperatures", imageName: "main_menu_temperatures.png"),
        TableViewCell(labelText: "Alarms", imageName: "main_menu_alarms.png"),
        TableViewCell(labelText: "Shutters", imageName: "main_menu_shutters.png"),
        TableViewCell(labelText: "Climate", imageName: "heating_icon.png"),
        TableViewCell(labelText: "Voice control", imageName: "main_menu_voice.png"),
        TableViewCell(labelText: "Configuration", imageName: "main_menu_configuration.png"),
        TableViewCell(labelText: "Sequence", imageName: "main_menu_switcher_icon.png")]
    
    func tableView(tableView: UITableView, numberOfSections section: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cells.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        return cells[indexPath.row]
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return screenSize.height * 0.09
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if(cells[indexPath.row].label.text == "Lights"){
            setupNewViewController(LightViewController())
        }
        else if(cells[indexPath.row].label.text == "Sequence"){
            setupNewViewController(SequenceTableViewController())
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        view.backgroundColor = UIColor.clearColor()
        tableView.backgroundColor = UIColor.clearColor()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        tableView.registerClass(TableViewCell.self as AnyClass, forCellReuseIdentifier: "Cell")
        tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        
        addViews()
        setupConstraints()
    }

    func setupConstraints(){
        
        tableViewContainer.translatesAutoresizingMaskIntoConstraints = false
        tableViewContainer.topAnchor.constraintEqualToAnchor(view.topAnchor).active = true
        tableViewContainer.bottomAnchor.constraintEqualToAnchor(view.bottomAnchor).active = true
        tableViewContainer.leadingAnchor.constraintEqualToAnchor(view.leadingAnchor).active = true
        tableViewContainer.trailingAnchor.constraintEqualToAnchor(view.trailingAnchor).active = true

        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraintEqualToAnchor(tableViewContainer.topAnchor).active = true
        tableView.bottomAnchor.constraintEqualToAnchor(tableViewContainer.bottomAnchor).active = true
        tableView.leadingAnchor.constraintEqualToAnchor(tableViewContainer.leadingAnchor).active = true
        tableView.trailingAnchor.constraintEqualToAnchor(tableViewContainer.trailingAnchor).active = true
    }
    
    func addViews(){
        
        view.addSubview(tableViewContainer)
        tableViewContainer.addSubview(tableView)
    }
    
    func setupNewViewController(vc: UIViewController ){
        
        addChildViewController(vc)
        UIView.transitionWithView(self.view, duration: 0.5, options: .TransitionFlipFromLeft, animations: { _ in
            self.view.addSubview(vc.view)
            }, completion: nil)
        vc.view.translatesAutoresizingMaskIntoConstraints = false
        tableViewContainer.addSubview(vc.view)
        vc.view.topAnchor.constraintEqualToAnchor(tableViewContainer.topAnchor).active = true
        vc.view.bottomAnchor.constraintEqualToAnchor(tableViewContainer.bottomAnchor).active = true
        vc.view.leadingAnchor.constraintEqualToAnchor(tableViewContainer.leadingAnchor).active = true
        vc.view.trailingAnchor.constraintEqualToAnchor(tableViewContainer.trailingAnchor).active = true
        tableView.removeFromSuperview()
        self.dismissViewControllerAnimated(true, completion: {})
    }
}
