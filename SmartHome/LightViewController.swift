//
//  TemperaturesViewController.swift
//  SmartHome
//
//  Created by MacOS on 02/11/17.
//  Copyright © 2017 Michał Ryś. All rights reserved.
//

import UIKit
import RealmSwift

class LightViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {
    
    private let screenSize = UIScreen.mainScreen().bounds
    private let tableViewContainer = UIView()
    private var tableView = UITableView()
    private var titleBar = UIView()
    private var titleWindow = UIImageView()
    private var titleBarImage = UIImageView()
    private var menuLabel = UILabel()
    
    private var cells: [TableViewCell] = [TableViewCell(labelText: "Main menu", imageName: "main_menu_configuration.png")]
    
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
        
        if(cells[indexPath.row].label.text == "Main menu"){
            setupNewViewController(MainMenuViewController())
        }else{
            cells[indexPath.row] = updateLight(cells[indexPath.row])
            tableView.reloadData()
        }
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    override func viewWillAppear(animated: Bool) {
        tableView.backgroundView?.backgroundColor = UIColor.clearColor()
        view.backgroundColor = UIColor.clearColor()
        tableView.backgroundColor = UIColor.clearColor()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.registerClass(TableViewCell.self as AnyClass, forCellReuseIdentifier: "Cell")
        tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        
        loadLights()
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
    
    func loadLights(){
        
        let realm = try! Realm()
        let lights: Results<Light> = { realm.objects(Light) }()
        
        if lights.count != 0 {
            
            for light in lights {
                let newCell = TableViewCell(labelText: light.name, imageName: light.imageName)
                cells.append(newCell)
            }
        }
    }

    func updateLight(cell: TableViewCell) -> TableViewCell{
        
        let realm = try! Realm()
        let light = realm.objects(Light).filter("name = %@", cell.label.text!).first
        
        try! realm.write {
            
            if(light!.isTurnOn){
                light!.isTurnOn = false
                light!.imageName = "lamp_off.png"
            }else{
                light!.imageName = "lamp_on.png"
                light!.isTurnOn = true
            }
            cell.picture.image = UIImage(named: light!.imageName)
        }
        return cell
    }
}