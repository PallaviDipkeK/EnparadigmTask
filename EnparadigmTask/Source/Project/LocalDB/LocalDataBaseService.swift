//
//  LocalDataBaseService.swift
//  EnparadigmTask
//
//  Created by mobiotics1067 on 21/09/20.
//  Copyright © 2020 mobiotics1067. All rights reserved.
//

import CoreData

class LocalDataBaseService {
    static let sharedInstance = LocalDataBaseService()
    private init(){

    }
    
    static var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
// MARK: - Core Data stack
fileprivate static var persistentContainer: NSPersistentContainer = {
    let container = NSPersistentContainer(name: "EnparadigmTask")
    container.loadPersistentStores(completionHandler: { (storeDescription, error) in
        if let error = error as NSError? {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            
            /*
             Typical reasons for an error here include:
             * The parent directory does not exist, cannot be created, or disallows writing.
             * The persistent store is not accessible, due to permissions or data protection when the device is locked.
             * The device is out of space.
             * The store could not be migrated to the current model version.
             Check the error message to determine what the actual problem was.
             */
            fatalError("Unresolved error \(error), \(error.userInfo)")
        }
    })
    return container
}()

// MARK: - Core Data Saving support

func saveContext () {
    let context = LocalDataBaseService.persistentContainer.viewContext
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
}

