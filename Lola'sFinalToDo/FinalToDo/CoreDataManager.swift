import CoreData

class CoreDataManager {
    
    let persistentContainer: NSPersistentContainer
    static let shared: CoreDataManager = CoreDataManager()
    
    init() {
        persistentContainer = NSPersistentContainer(name: "TaskDataBase")
        persistentContainer.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Unable to load data \(error.localizedDescription)")
            }
        }
    }
}

