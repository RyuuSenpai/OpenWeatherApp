//
//  CoreDataManager.swift
//  OpenWeatherApp
//
//  Created by Eslam Abo El Fetouh on 19/03/2023.
//

import Foundation
import CoreData

protocol CoreDataManagerProtocol {
    func saveContext()
    func delete(_ object: NSManagedObject)
    func fetch<T: NSManagedObject>(entityType: T.Type, predicate: NSPredicate?, sortDescriptors: [NSSortDescriptor]?) -> [T]?
}

final class CoreDataManager: CoreDataManagerProtocol {

    private let persistentContainer: NSPersistentContainer

    init(persistentContainer: NSPersistentContainer) {
        self.persistentContainer = persistentContainer
    }

    func saveContext() {
        guard persistentContainer.viewContext.hasChanges else {
            return
        }

        do {
            try persistentContainer.viewContext.save()
        } catch {
            fatalError("Unresolved error \(error)")
        }
    }

    func delete(_ object: NSManagedObject) {
        persistentContainer.viewContext.delete(object)
        saveContext()
    }

    func fetch<T: NSManagedObject>(entityType: T.Type, predicate: NSPredicate?, sortDescriptors: [NSSortDescriptor]?) -> [T]? {
        let fetchRequest = NSFetchRequest<T>(entityName: String(describing: entityType))
        fetchRequest.predicate = predicate
        fetchRequest.sortDescriptors = sortDescriptors

        do {
            let results = try persistentContainer.viewContext.fetch(fetchRequest)
            return results
        } catch {
            fatalError("Unresolved error \(error)")
        }
    }
}
