//
//  RestaurantModel.swift
//  FoodPin
//
//  Created by avi on 13/02/15.
//  Copyright (c) 2015 avi. All rights reserved.
//

import Foundation

class Restaurant {
    var name, type, location, image, phoneNum: String
    var isVisited: Bool
    
    init(name: String, type: String, location: String, image: String, isVisited: Bool, phoneNum: String) {
        self.name = name
        self.type = type
        self.location = location
        self.image = image
        self.isVisited = isVisited
        self.phoneNum = phoneNum
    }
}