//
//  Locations+CoreDataProperties.swift
//  FootprintApp
//
//  Created by 神戸悟 on 2019/12/19.
//  Copyright © 2019 SatoruKambe. All rights reserved.
//
//

import Foundation
import CoreData


extension Locations {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Locations> {
        return NSFetchRequest<Locations>(entityName: "Locations")
    }

    @NSManaged public var latitude: Double
    @NSManaged public var longitude: Double
    @NSManaged public var taskId: String?
    @NSManaged public var time: String?
    @NSManaged public var newRelationship: Footprints?

}
