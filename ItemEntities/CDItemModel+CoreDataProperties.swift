//
//  CDItemModel+CoreDataProperties.swift
//  NotesSwift
//
//  Created by Sahid Reza on 17/01/23.
//
//

import Foundation
import CoreData


extension CDItemModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDItemModel> {
        return NSFetchRequest<CDItemModel>(entityName: "CDItemModel")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var itemStatus: Bool
    @NSManaged public var itemTitle: String?
    @NSManaged public var parentCatagory: CDCatagory?

}

extension CDItemModel : Identifiable {

}
