//
//  Light.swift
//  SmartHome
//
//  Created by MacOS on 25/11/17.
//  Copyright © 2017 Michał Ryś. All rights reserved.
//

import Foundation
import RealmSwift

class Light: Object{
    dynamic var name: String = ""
    dynamic var isTurnOn = false
    dynamic var imageName: String = ""
}