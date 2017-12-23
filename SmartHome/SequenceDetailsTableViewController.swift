//
//  SequenceTableViewController.swift
//  SmartHome
//
//  Created by MacOS on 25/11/17.
//  Copyright © 2017 Michał Ryś. All rights reserved.
//

import UIKit
import RealmSwift

class SequenceDetailsTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{

    private var screenSize = UIScreen.mainScreen().bounds
    private var tableView = UITableView()
    private var tableViewContainer = UIView()
    private var sequence: Sequence
    private var sequenceNameCell: SequenceNameTableViewCell
    private var cells: [SequenceElementTableViewCell] = []
    
    convenience init(sequence: Sequence) {
        self.init(nibName: nil, bundle: nil)
        self.sequence = sequence
        self.sequenceNameCell.sequence = self.sequence
        self.sequenceNameCell.sequenceName.text = self.sequence.name
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        self.sequence = Sequence()
        self.sequenceNameCell = SequenceNameTableViewCell()
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func tableView(tableView: UITableView, numberOfSections section: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6 + cells.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if (indexPath.row == 0) {
            return TableViewCell(labelText: "Main menu", imageName: "main_menu_configuration.png")
        } else if(indexPath.row == 1) {
            return TableViewCell(labelText: "Sequences view", imageName: "list.png")
        } else if (indexPath.row == 2) {
            return sequenceNameCell
        }else if (indexPath.row < 3 + cells.count){
            return cells[indexPath.row - 3]
        } else if (indexPath.row == 4 + cells.count){
            return TableViewCell( labelText: "Add action", imageName: "add_grey.png")
        } else if (indexPath.row == 5 + cells.count){
            return TableViewCell(labelText: "Save changes", imageName: "envelope.png")
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
        } else if (indexPath.row == 1) {
            setupNewViewController(SequenceTableViewController())
        } else if(indexPath.row == 2) {
            tableView.deselectRowAtIndexPath(indexPath, animated: true)
        }else if (indexPath.row < 3 + cells.count){
            deleteTapped(indexPath.row - 3)
        } else if (indexPath.row == 4 + cells.count){
            addAction(indexPath)
        } else if (indexPath.row == 5 + cells.count){
            save()
            tableView.deselectRowAtIndexPath(indexPath, animated: true)
        } else {
            submit()
            tableView.deselectRowAtIndexPath(indexPath, animated: true)
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        view.backgroundColor = UIColor.clearColor()
        tableView.backgroundColor = UIColor.clearColor()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadActions()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.registerClass(TableViewCell.self as AnyClass, forCellReuseIdentifier: "Cell")
        tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        
        addViews()
        setupConstraints()
    }
    
    func loadActions(){
        
        for action in sequence.action {
            let newCell = SequenceElementTableViewCell(action: action)
            cells.append(newCell)
        }
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
        tableView.beginUpdates()
        tableView.deleteRowsAtIndexPaths([
            NSIndexPath(forRow: 3 + index, inSection: 0)
            ], withRowAnimation: .Automatic)
        tableView.endUpdates()
    }
    
    func save(){
        
        print(sequenceNameCell.sequenceName.text)
    
        let realm = try! Realm()
        
        try! realm.write() {
            sequence.action.removeAll()
            sequence.name = sequenceNameCell.getSequenceName()
            for cell in cells{
                let action = Action()
                action.name = cell.actionNameField.text!
                sequence.action.append(action)
            }

            realm.add(sequence)
        }
    }
    
    func submit(){
        
        let realm = try! Realm()
        
        for cell in cells{
            
            var task = cell.getAction() as String
            if(task != "") {
                
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
            } else {
                let alert = UIAlertController(title: "Alert", message: "Action cannot be empty", preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
                self.presentViewController(alert, animated: true, completion: nil)
            }
        }
    }
    
    func addAction(index: NSIndexPath){
        
        cells.append(SequenceElementTableViewCell())
        tableView.beginUpdates()
        tableView.insertRowsAtIndexPaths([NSIndexPath(forRow: 3 + cells.count - 1, inSection: 0)], withRowAnimation: .Automatic)
        tableView.deselectRowAtIndexPath(index, animated: true)
        tableView.endUpdates()
    }
}
