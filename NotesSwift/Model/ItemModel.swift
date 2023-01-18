//
//  ItemModel.swift
//  NotesSwift
//
//  Created by Sahid Reza on 17/01/23.
//

import Foundation

class ItemModel{
    
    var ItemName:String
    var ItemID:UUID
    var ItemStatus:Bool = false
    
    init(ItemName: String, ItemID: UUID, ItemStatus: Bool) {
        self.ItemName = ItemName
        self.ItemID = ItemID
        self.ItemStatus = ItemStatus
    }
    
    
}
