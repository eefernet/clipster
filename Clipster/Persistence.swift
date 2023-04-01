//
//  Persistence.swift
//  Clipster
//
//  Created by Ethan Jamieson on 8/27/22.
//

import CoreData

struct PersistenceController {
    
    //Mark: Properties and vars
    static let shared = PersistenceController()
    static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        result.addPreviewItems()
        return result
    }()
    let container: NSPersistentCloudKitContainer

    //Mark: Init function
    init(inMemory: Bool = false) {
        
        container = NSPersistentCloudKitContainer(name: "Clipster")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        loadPersistentStores()
        setupViewContext()
    }
    
    // MARK: Private methods called in the init()
       
    private func addPreviewItems() {
        let viewContext = container.viewContext
        for _ in 0..<10 {
            let newItem = Item(context: viewContext)
            newItem.timestamp = Date()
        }
        do {
            try viewContext.save()
        } catch {
            print("Error adding preview items: \(error)")
        }
    }
       
    private func loadPersistentStores() {
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error {
                print("Error loading persistent stores: \(error)")
            }
        }
    }
       
    private func setupViewContext() {
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
}
