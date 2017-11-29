//
//  SequenceTableViewController.swift
//  SmartHome
//
//  Created by MacOS on 29/11/17.
//  Copyright © 2017 Michał Ryś. All rights reserved.
//

import Foundation
import RealmSwift

class SequenceTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    private let screenSize = UIScreen.mainScreen().bounds
    private var tableView = UITableView()
    private var tableViewContainer = UIView()
    
    private var cells: [SequenceTableViewCell] = []
    
    func tableView(tableView: UITableView, numberOfSections section: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4 + cells.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if (indexPath.row == 0){
            return TableViewCell(labelText: "Main menu", imageName: "main_menu_configuration.png")
        } else if (indexPath.row == 1) {
            return TableViewCell(labelText: "Add new sequence", imageName: "add_grey.png")
        } else if (indexPath.row > 1 && indexPath.row < 1 + cells.count){
            return cells[indexPath.row - 2]
        }
        
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return screenSize.height * 0.09
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if (indexPath.row == 0){
            setupNewViewController(MainMenuViewController())
        } else if (indexPath.row == 1) {
            setupNewViewController(SequenceDetailsTableViewController())
        } else if (indexPath.row > 1 && indexPath.row < 1 + cells.count){
            deleteTapped(indexPath.row - 1)
        } else if (indexPath.row == 2 + cells.count){
            submit()
            tableView.deselectRowAtIndexPath(indexPath, animated: true)
        } else{
            addAction()
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
    
    func deleteTapped(index: Int) {
        cells.removeAtIndex(index)
        tableView.reloadData()
    }
    
    func submit(){
        
        let realm = try! Realm()
        
        for cell in cells{
            
            var task = cell.getAction() as String
            task = task.uppercaseString
            
            let taskArr = task.characters.split{$0 == " "}.map(String.init)
            let lightName = "Swiatlo " + taskArr[1].lowercaseString
            
            if ( taskArr[0].containsString( "wylacz".uppercaseString )) {
                
                let light = realm.objects(Light).filter("name = %@", lightName).first
                try! realm.write {
                    light!.isTurnOn = false
                    light!.imageName = "lamp_off.png"
                }
            } else {
                
                let light = realm.objects(Light).filter("name = %@", lightName).first
                try! realm.write {
                    light!.isTurnOn = true
                    light!.imageName = "lamp_on.png"
                }
            }
        }
    }
}
