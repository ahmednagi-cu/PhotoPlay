//
//  DataPersisten.swift
//  PhotoPlay
//
//  Created by ahmed nagi on 07/10/2022.
//

import Foundation
import UIKit
import CoreData
class DataPersisten {
    
    enum DatabaseError: Error {
        case failedToSaveData
        case errorToFetchData
        case failedDeleteData
    }
    static let shared = DataPersisten()
    
    
    func downloadwith(model : Title,complition : @escaping (Result<Void, Error>) -> Void) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
             return
        }
        let context = appDelegate.persistentContainer.viewContext
        
        let item = Itemname(context: context)
        
        item.id = Int64(model.id)
        item.original_title = model.original_title
        item.original_name = model.original_name
        item.overview = model.overview
        item.media_type = model.media_type
        item.poster_path = model.poster_path
        item.release_date = model.release_date
        item.vote_average = model.vote_average
        item.vote_count = Int64(model.vote_count)
        
        
        do {
            try context.save()
            complition(.success(()))
        }catch{
            complition(.failure(DatabaseError.failedToSaveData))
        }
    }
    
    func fetchDataFromDataBase(comletion : @escaping (Result<[Itemname],Error>) -> Void){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
             return
        }
        
        let context = appDelegate.persistentContainer.viewContext
        let request : NSFetchRequest<Itemname>

        request = Itemname.fetchRequest()
        
        do {
          let titles = try context.fetch(request)
            comletion(.success(titles))
        }catch {
            comletion(.failure(DatabaseError.errorToFetchData))
        }
    }
    
    func deleteTitleWith(model : Itemname, completion: @escaping (Result<Void, Error>) -> Void) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
             return
        }
        
        let context = appDelegate.persistentContainer.viewContext
        context.delete(model)
        do {
            try context.save()
            completion(.success(()))
        }catch {
            completion(.failure(DatabaseError.failedDeleteData))
        }
    }
}
