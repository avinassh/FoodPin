//
//  RestaurantModel.swift
//  FoodPin
//
//  Created by avi on 13/02/15.
//  Copyright (c) 2015 avi. All rights reserved.
//

import Foundation
import CoreData

class Restaurant: NSManagedObject {
    @NSManaged var name: String!
    @NSManaged var type: String!
    @NSManaged var location: String!
    @NSManaged var phoneNum: String!
    @NSManaged var image: NSData!
    @NSManaged var isVisited: NSNumber!
}