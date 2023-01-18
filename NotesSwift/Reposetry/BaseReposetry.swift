//
//  BaseReposetry.swift
//  NotesSwift
//
//  Created by Sahid Reza on 16/01/23.
//

import Foundation

protocol BaseResposetry{
    
    associatedtype T
    
    func createData(dataModel:T)
    func getAll() ->[T]?
    func getID (buIdentifier id:UUID) -> T?
    func update (recored:T) -> Bool
    func delete (buIdentifier id:UUID) -> Bool
    
    
}
