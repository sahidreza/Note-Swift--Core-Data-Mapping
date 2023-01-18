//
//  CatagoryReposetryData.swift
//  NotesSwift
//
//  Created by Sahid Reza on 16/01/23.
//

import Foundation
import CoreData

protocol CatagoryReposetry:BaseResposetry{
    
}

class CatagoryReposetryData:CatagoryReposetry{
    
    typealias T = CatagoryModel
    
    func createData(dataModel: CatagoryModel) {
        
        let createCDCatagoryData = CDCatagory(context: PresesTanceStorage.shared.context)
        createCDCatagoryData.id = dataModel.catagoryID
        createCDCatagoryData.catagoryName = dataModel.catagoryTitle
        PresesTanceStorage.shared.saveContext()
        
    }
    
    func createCatagoryDataWithItems(dataModel:CatagoryModel){
        
        if let safeData = checkingID(with: dataModel.catagoryID){
            
            let cdItemData = CDItemModel(context: PresesTanceStorage.shared.context)
            cdItemData.id = dataModel.catagorysItem?.ItemID
            cdItemData.itemTitle = dataModel.catagorysItem?.ItemName
            cdItemData.itemStatus = dataModel.catagorysItem?.ItemStatus ?? false
            
            safeData.relationshipItem?.insert(cdItemData)
            
            PresesTanceStorage.shared.saveContext()
            
        
            
            
        }
        
    }
    
    func ftechOnlyParentConnectItem(byIdnetidier title: String) ->[ItemModel]? {
        
        let request:NSFetchRequest<CDItemModel> = CDItemModel.fetchRequest()
        let predicate = NSPredicate(format: "parentCatagory.catagoryName MATCHES %@", title)
        request.predicate = predicate
        
        do{
            
            let itemModelData = try PresesTanceStorage.shared.context.fetch(request)
            
            var itemDataList = [ItemModel]()
            itemModelData.forEach { cditemData in
                
                let itemData = ItemModel(ItemName: cditemData.itemTitle!, ItemID: cditemData.id!, ItemStatus: cditemData.itemStatus)
                
                itemDataList.append(itemData)
                
            }
            
            return itemDataList
            
        }catch{
            return nil
        }
    }
    
    
    
    
    func getAll() -> [CatagoryModel]? {
        
        let request:NSFetchRequest<CDCatagory> = CDCatagory.fetchRequest()
        
        do{
            
            let cdCatagoryData = try PresesTanceStorage.shared.context.fetch(request)
            
            var catagoyDataList = [CatagoryModel]()
            
            cdCatagoryData.forEach { cdcatagory in
                
                let catagoryData = CatagoryModel(catagoryID: cdcatagory.id!, catagoryTitle: cdcatagory.catagoryName!)
                
                catagoyDataList.append(catagoryData)
                
            }
            
            return catagoyDataList
            
        }catch{
            print("error")
            return nil
        }
        
        
        
    }
    
    func getID(buIdentifier id: UUID) -> CatagoryModel? {
        
        let cdCatagoryData = checkingID(with: id)
        
        if let safeData = cdCatagoryData{
            
            let catagoryData = CatagoryModel(catagoryID: safeData.id!, catagoryTitle: safeData.catagoryName!)
            
            return catagoryData
            
        }else{
            
            return nil
        }
        
        
    }
    
    func update(recored: CatagoryModel) -> Bool {
        
        let cdCatagoryData = checkingID(with: recored.catagoryID)
        
        if let safeData = cdCatagoryData{
            
            safeData.catagoryName = recored.catagoryTitle
            
            PresesTanceStorage.shared.saveContext()
            
            return true
        }else{
            return false
        }
        
    }
    
    func delete(buIdentifier id: UUID) -> Bool {
        
        let cdCatagoryData = checkingID(with: id)
        
        if let safeData = cdCatagoryData{
            
            PresesTanceStorage.shared.context.delete(safeData)
            
            PresesTanceStorage.shared.saveContext()
            
            return true
        }else{
            return false
        }
        
        
        
    }
    
    private func checkingID(with identyifierID:UUID) -> CDCatagory?{
            
            let request:NSFetchRequest<CDCatagory> = CDCatagory.fetchRequest()
            let predicate = NSPredicate(format: "id==%@", identyifierID as CVarArg)
            request.predicate = predicate
            
            do {
                
                let responseData = try PresesTanceStorage.shared.context.fetch(request).first
                
                return responseData
                
            }catch{
                
                print(error)
                
                return nil
            }
            
            
        }
        
    
    
}
