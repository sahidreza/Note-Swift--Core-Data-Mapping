//
//  Catagory+CoreDataProperties.swift
//  NotesSwift
//
//  Created by Sahid Reza on 13/01/23.
//
//

import Foundation
import CoreData


extension Catagory {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Catagory> {
        return NSFetchRequest<Catagory>(entityName: "Catagory")
    }

    @NSManaged public var catagoryName: String?
    @NSManaged public var relationshipItem: NSSet?

}

// MARK: Generated accessors for relationshipItem
extension Catagory {

    @objc(addRelationshipItemObject:)
    @NSManaged public func addToRelationshipItem(_ value: ItemModel)

    @objc(removeRelationshipItemObject:)
    @NSManaged public func removeFromRelationshipItem(_ value: ItemModel)

    @objc(addRelationshipItem:)
    @NSManaged public func addToRelationshipItem(_ values: NSSet)

    @objc(removeRelationshipItem:)
    @NSManaged public func removeFromRelationshipItem(_ values: NSSet)

}

extension Catagory : Identifiable {

}
