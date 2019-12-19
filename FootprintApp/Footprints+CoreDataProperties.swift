//
//  Footprints+CoreDataProperties.swift
//  FootprintApp
//
//  Created by 神戸悟 on 2019/12/19.
//  Copyright © 2019 SatoruKambe. All rights reserved.
//
//

import Foundation
import CoreData


extension Footprints {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Footprints> {
        return NSFetchRequest<Footprints>(entityName: "Footprints")
    }

    @NSManaged public var taskId: String?
    @NSManaged public var endTime: String?
    @NSManaged public var startTime: String?
    @NSManaged public var title: String?
    @NSManaged public var newRelationship: NSSet?

}

// MARK: Generated accessors for newRelationship
extension Footprints {

    @objc(addNewRelationshipObject:)
    @NSManaged public func addToNewRelationship(_ value: Locations)

    @objc(removeNewRelationshipObject:)
    @NSManaged public func removeFromNewRelationship(_ value: Locations)

    @objc(addNewRelationship:)
    @NSManaged public func addToNewRelationship(_ values: NSSet)

    @objc(removeNewRelationship:)
    @NSManaged public func removeFromNewRelationship(_ values: NSSet)

}
