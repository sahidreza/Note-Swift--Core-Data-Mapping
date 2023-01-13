//
//  ItemModel+CoreDataProperties.swift
//  NotesSwift
//
//  Created by Sahid Reza on 13/01/23.
//
//

import Foundation
import CoreData


extension ItemModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ItemModel> {
        return NSFetchRequest<ItemModel>(entityName: "ItemModel")
    }

    @NSManaged public var itemStatus: Bool
    @NSManaged public var itemTitle: String?
    @NSManaged public var parentCatagory: Catagory?

}

extension ItemModel : Identifiable {

}
