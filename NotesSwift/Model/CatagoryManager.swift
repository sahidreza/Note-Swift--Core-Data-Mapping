//
//  CatagoryManager.swift
//  NotesSwift
//
//  Created by Sahid Reza on 17/01/23.
//

import Foundation

struct CatagoryManager{
    
    
 private let _catagoryReposetry = CatagoryReposetryData()
    
    func createCatagoryData(with catagoryData:CatagoryModel){
        
        _catagoryReposetry.createData(dataModel: catagoryData)
    }
    
    func fetchCatagoryData() -> [CatagoryModel]?{
        
        let catagoryList = _catagoryReposetry.getAll()
        
        return catagoryList
    }
    
    func createCatagoryDatawithItem(record:CatagoryModel){
        _catagoryReposetry.createCatagoryDataWithItems(dataModel: record)
    }
    
    func fetchItemData(title:String) -> [ItemModel]?{
     
        let itemList =  _catagoryReposetry.ftechOnlyParentConnectItem(byIdnetidier: title)
        
        return itemList
    }
    
    
    
}
