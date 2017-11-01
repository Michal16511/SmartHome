//
//  TableViewController.swift
//  SmartHome
//
//  Created by MacOS on 31/10/17.
//  Copyright © 2017 Michał Ryś. All rights reserved.
//

import UIKit

class TableViewController: UITableView{

    public var tableView = UITableView()
    
    public var cells: [TableViewCell] = [TableViewCell(labelText: "Lights", imageName: "main_menu_lamps.png"),
        TableViewCell(labelText: "Temperatures", imageName: "main_menu_temperatures.png"),
        TableViewCell(labelText: "Alarms", imageName: "main_menu_alarms.png"),
        TableViewCell(labelText: "Shutters", imageName: "main_menu_shutters.png"),
        TableViewCell(labelText: "Climate", imageName: "heating_icon.png"),
        TableViewCell(labelText: "Voice control", imageName: "main_menu_voice.png"),
        TableViewCell(labelText: "Configuration", imageName: "main_menu_configuration.png"),
        TableViewCell(labelText: "Bla bla bla", imageName: "main_menu_temperatures.png")]
    
    func tableView(tableView: UITableView, numberOfSections section: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        //let myCell = tableView.dequeueReusableCellWithIdentifier("myIdentifier", forIndexPath: indexPath) as! TableViewCell
//        let cell = tableView.dequeueReusableCellWithIdentifier( NSStringFromClass(TableViewCell), forIndexPath: indexPath) as! TableViewCell]
        print(indexPath.row)
        return cells[indexPath.row]
    }
}