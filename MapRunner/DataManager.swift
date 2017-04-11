//
//  DataManager.swift
//  MapRunner
//
//  Created by Minhung Ling on 2017-04-07.
//  Copyright © 2017 Minhung Ling. All rights reserved.
//

import UIKit
import CoreLocation
import CoreData

class DataManager: NSObject {
    
    struct Session {
        var steps = 0
        var locations = [CLLocationCoordinate2D]()
    }

    var session = Session()
    static let sharedInstance = DataManager()
    private override init() {}
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "MapRunner")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
//                let nserror = error as NSError
//                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

    func getContext() -> NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    func generateLocation() -> NSManagedObject {
        let location = NSEntityDescription.insertNewObject(forEntityName: "Location", into: getContext())
        return location
    }

    func generateRun() -> NSManagedObject {
        let run = NSEntityDescription.insertNewObject(forEntityName: "Run", into: getContext())
        return run
    }
    
}
