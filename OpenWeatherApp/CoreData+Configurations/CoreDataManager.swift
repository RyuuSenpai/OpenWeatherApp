//
//  CoreDataManager.swift
//  OpenWeatherApp
//
//  Created by Eslam Abo El Fetouh on 19/03/2023.
//

import Foundation
import CoreData

protocol CoreDataManagerProtocol {
    var persistentContainer: NSPersistentContainer { get }
    func saveContext()
    func delete(_ object: NSManagedObject, andSave save: Bool)
    func fetch<T: NSManagedObject>(entityType: T.Type) -> [T]?
    func saveObject<T: NSManagedObject>(_ object: T)
}
enum CoreDataEntity: String {
    case searchHistoryItem = "SearchHistoryCoreDataItem"
}

final class CoreDataManager {
    static let shared = CoreDataManager()

    private init() {}

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "OpenWeatherApp")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
}
extension CoreDataManager: CoreDataManagerProtocol {

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

    func delete(_ object: NSManagedObject, andSave save: Bool) {
        persistentContainer.viewContext.delete(object)
        guard save else { return }
        saveContext()
    }

    func saveObject<T: NSManagedObject>(_ object: T) {
        persistentContainer.viewContext.insert(object)
        saveContext()
    }

    func fetch<T: NSManagedObject>(entityType: T.Type) -> [T]? {
        let fetchRequest = NSFetchRequest<T>(entityName: String(describing: entityType))
        do {
            let results = try persistentContainer.viewContext.fetch(fetchRequest)
            return results
        } catch {
            fatalError("Unresolved error \(error)")
        }
    }
}
