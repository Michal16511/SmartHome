//
//  Sensor.swift
//  SmartHome
//
//  Created by MacOS on 23/12/17.
//  Copyright © 2017 Michał Ryś. All rights reserved.
//

import Foundation

class Sensor {
    
    var name: String = ""
    var state: String = ""
    
    init(name: String, state: String){
        self.name = name
        self.state = state
    }
    
    init() {
        
    }
}