//
//  DataController.swift
//  DateManagementApp
//
//  Created by 神戸悟 on 2019/12/13.
//  Copyright © 2019 SatoruKambe. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class DataController: NSObject {
    var persistentContainer: NSPersistentContainer!
    //初期化
    init(completionClosure: @escaping () -> ()) {
        persistentContainer = NSPersistentContainer(name: "FootprintApp")
        persistentContainer.loadPersistentStores() { (description, error) in
            if let error = error {
                fatalError("Failed to load Core Data stack: \(error)")
            }
            completionClosure()
        }
    }
    //Managed objectの生成
    func createLocation() -> Locations {
        let context = persistentContainer.viewContext
        let location = NSEntityDescription.insertNewObject(forEntityName: "Locations", into: context) as! Locations
        return location
    }
    //NSManagedObjectインスタンスの保存
    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    //NSManagedObjectインスタンスの読み込み
    func fetchLocations() -> [Locations] {
        let context = persistentContainer.viewContext
        let employeesFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Locations")
        //フィルタリングのサンプルコード
        //let firstName = "Trevor"
        //employeesFetch.predicate = NSPredicate(format: "firstName == %@", firstName)
        do {
            let fetchedEmployees = try context.fetch(employeesFetch) as! [Locations]
            return fetchedEmployees
        } catch {
            fatalError("Failed to fetch employees: \(error)")
        }
    }
    
    var locations: [NSManagedObject] = []

    func save(time: String,latitude:Double,longitude:Double,taskId:String) {
       guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
         return
       }

       let managedContext = appDelegate.persistentContainer.viewContext

       let entity = NSEntityDescription.entity(forEntityName: "Locations",
                                               in: managedContext)!

       let location = NSManagedObject(entity: entity,
                                    insertInto: managedContext)

       location.setValue(time, forKey: "time")
       location.setValue(latitude, forKey: "latitude")
       location.setValue(longitude, forKey: "longitude")
       location.setValue(taskId, forKey: "taskId")

       do {
         try managedContext.save()
         locations.append(location)
       } catch let error as NSError {
         print("Could not save. \(error), \(error.userInfo)")
       }
    }
    
    func delete(taskId:String) {
       guard let appDelegate:AppDelegate = UIApplication.shared.delegate as? AppDelegate else {
         return
       }

       let managedContext:NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest:NSFetchRequest<Locations> = Locations.fetchRequest()
        let predicate = NSPredicate(format:"%K = %@","taskId",taskId)
        fetchRequest.predicate = predicate
        let fetchData = try! managedContext.fetch(fetchRequest)
        if(!fetchData.isEmpty){
              for i in 0..<fetchData.count{
                    let deleteObject = fetchData[i] as Locations
                    managedContext.delete(deleteObject)
              }
              do{
                    try managedContext.save()
              }catch{
                    print(error)
              }
        }
    }
}
