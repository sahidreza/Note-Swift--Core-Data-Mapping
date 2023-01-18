//
//  CDCatagory+CoreDataProperties.swift
//  NotesSwift
//
//  Created by Sahid Reza on 17/01/23.
//
//

import Foundation
import CoreData


extension CDCatagory {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDCatagory> {
        return NSFetchRequest<CDCatagory>(entityName: "CDCatagory")
    }

    @NSManaged public var catagoryName: String?
    @NSManaged public var id: UUID?
    @NSManaged public var relationshipItem: Set<CDItemModel>?

}

// MARK: Generated accessors for relationshipItem
extension CDCatagory {

    @objc(addRelationshipItemObject:)
    @NSManaged public func addToRelationshipItem(_ value: CDItemModel)

    @objc(removeRelationshipItemObject:)
    @NSManaged public func removeFromRelationshipItem(_ value: CDItemModel)

    @objc(addRelationshipItem:)
    @NSManaged public func addToRelationshipItem(_ values: Set<CDItemModel>)

    @objc(removeRelationshipItem:)
    @NSManaged public func removeFromRelationshipItem(_ values: Set<CDItemModel>)

}

extension CDCatagory : Identifiable {

}
