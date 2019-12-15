//
//  Location+CoreDataProperties.swift
//  FootprintApp
//
//  Created by 神戸悟 on 2019/12/14.
//  Copyright © 2019 SatoruKambe. All rights reserved.
//
//

import Foundation
import CoreData


extension Location {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Location> {
        return NSFetchRequest<Location>(entityName: "Location")
    }

    @NSManaged public var latitude: Double
    @NSManaged public var longitude: Double
    @NSManaged public var taskId: String?
    @NSManaged public var time: Date?

}
