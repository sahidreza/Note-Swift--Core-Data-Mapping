//
//  CatagoryModel.swift
//  NotesSwift
//
//  Created by Sahid Reza on 16/01/23.
//

import Foundation

struct CatagoryModel{
    
    let catagoryID:UUID
    let catagoryTitle:String
    let catagorysItem:ItemModel?
    
    init(catagoryID: UUID, catagoryTitle: String, catagorysItem:ItemModel? = nil ) {
        self.catagoryID = catagoryID
        self.catagoryTitle = catagoryTitle
        self.catagorysItem = catagorysItem
    }
    
}
