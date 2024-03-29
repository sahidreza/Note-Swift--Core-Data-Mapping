//
//  PresesTanceStorage.swift
//  NotesSwift
//
//  Created by Sahid Reza on 12/01/23.
//

import Foundation
import CoreData

final class PresesTanceStorage{
    
    
    static let shared = PresesTanceStorage()
    private init(){}
    
    
    // MARK: - Core Data stack
    
    lazy var persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "NotesSwift")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    
    lazy  var  context = persistentContainer.viewContext
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
}


