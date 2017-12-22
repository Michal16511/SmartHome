//
//  SequenceTableViewController.swift
//  SmartHome
//
//  Created by MacOS on 29/11/17.
//  Copyright © 2017 Michał Ryś. All rights reserved.
//

import Foundation
import RealmSwift

class SequenceTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, SequenceCellDelegate {
    
    private let screenSize = UIScreen.mainScreen().bounds
    private var tableView = UITableView()
    private var tableViewContainer = UIView()
    
    private var cells: [SequenceTableViewCell] = []
    
    func tableView(tableView: UITableView, numberOfSections section: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2 + cells.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if (indexPath.row == 0){
            return TableViewCell(labelText: "Main menu", imageName: "main_menu_configuration.png")
        } else if (indexPath.row == 1) {
            return TableViewCell(labelText: "Add new sequence", imageName: "add_grey.png")
        } else {
        //} else if (indexPath.row > 1 && indexPath.row < 1 + cells.count){
            return cells[indexPath.row - 2]
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return screenSize.height * 0.09
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if ( indexPath.row == 0 ){
            setupNewViewController(MainMenuViewController())
        } else if ( indexPath.row == 1)  {
            setupNewViewController(SequenceDetailsTableViewController(sequence: Sequence()))
        } else if ( indexPath.row > 1 ){
            setupNewViewController(SequenceDetailsTableViewController(sequence: cells[indexPath.row - 2].sequence))
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        view.backgroundColor = UIColor.clearColor()
        tableView.backgroundColor = UIColor.clearColor()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadSequences()
        
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
    
    func loadSequences() {
        cells = []
        let realm = try! Realm()
        let sequences: Results<Sequence> = { realm.objects(Sequence) }()
        
        if sequences.count != 0 {
            
            for sequence in sequences {
                let newCell = SequenceTableViewCell(sequence: sequence, delegate: self)
                cells.append(newCell)
            }
        }
    }
    
    func sequenceCellButtonPressed(sequence: Sequence?) {
        
        let realm = try! Realm()
        
        try! realm.write {
            realm.delete(sequence!)
        }
        
        loadSequences()
        tableView.reloadData()
    }
}
