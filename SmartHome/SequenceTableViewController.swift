//
//  SequenceTableViewController.swift
//  SmartHome
//
//  Created by MacOS on 25/11/17.
//  Copyright © 2017 Michał Ryś. All rights reserved.
//

import UIKit

class SequenceTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{

    private let screenSize = UIScreen.mainScreen().bounds
    private var tableView = UITableView()
    private var tableViewContainer = UIView()
    
    private var cells: [SequenceTableViewCell] = [SequenceTableViewCell()]
    
    func tableView(tableView: UITableView, numberOfSections section: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3 + cells.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if (indexPath.row == 0){
            return TableViewCell(labelText: "Main menu", imageName: "main_menu_configuration.png")
        } else if (indexPath.row != 0 && indexPath.row < 1 + cells.count){
            return cells[indexPath.row - 1]
        } else if (indexPath.row == 1 + cells.count){
            return TableViewCell( labelText: "Add action", imageName: "add_grey.png")
        } else {
            return TableViewCell(labelText: "Submit", imageName: "submit_grey.png")
        }
        
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return screenSize.height * 0.09
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if (indexPath.row == 0){
            setupNewViewController(MainMenuViewController())
        } else if (indexPath.row != 0 && indexPath.row < 1 + cells.count){
            deleteTapped(indexPath.row - 1)
        } else if (indexPath.row == 2 + cells.count){
            submit()
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
        
//        for cell in cells{
//            
//            var action = cell.getAction() as String
//            action = action.uppercaseString
//            
//            for light in lights {
//                
//                if ( action.containsString( light.name.uppercaseString ) )
//            }
//            
//            if ( action.containsString( "wylacz".uppercaseString )) {
//                
//            } else {
//                
//            }
//            
//        }
        
    }
    
    func addAction(){
        cells.append(SequenceTableViewCell())
        tableView.reloadData()
    }
}
