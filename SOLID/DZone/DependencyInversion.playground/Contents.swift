import Foundation

/*
 A. High-level modules should not depend upon low-level modules. Both should depend upon abstractions.
 B. Abstractions should not depend upon details. Details should depend upon abstractions.

 DIP is very similar to Open-Closed Principle: the approach to use, to have a clean architecture, is decoupling the dependencies. You can achieve it thanks to abstract layers.
 */

class Handler {

    let fm = FilesystemManager()

    func handle(string: String) {
        fm.save(string: string)
    }
}

class FilesystemManager {

    func save(string: String) {
        // Open a file
        // Save the string in this file
        // Close the file
    }
}

/*
 - FilesystemManager is the low-level module and it’s easy to reuse in other projects.
 - The problem is the high-level module Handler, which is not reusable because is tightly coupled with FilesystemManager.
 - We should be able to reuse the high-level module with different kind of storages like a database, cloud, and so on.
 */

/*
 - We can solve this dependency using a protocol Storage.
 - In this way, Handler can use this abstract protocol without caring of the kind of storage used.
 - With this approach, we can change easily from a filesystem to a database.
 */

protocol Storage {

   func save(string: String)
}

class DIHandler {

    let storage: Storage

    init(storage: Storage) {
        self.storage = storage
    }

    func handle(string: String) {
        storage.save(string: string)
    }
}

class DIFilesystemManager: Storage {

    func save(string: String) {
        // Open a file in read-mode
        // Save the string in this file
        // Close the file
        print("\(string)")
    }
}

class DIDatabaseManager: Storage {

    func save(string: String) {
        // Connect to the database
        // Execute the query to save the string in a table
        // Close the connection
        print("\(string)")
    }
}

let filesystemHandler = DIHandler(storage: DIFilesystemManager())
filesystemHandler.handle(string: "Filesystem Test")

let dbHandler = DIHandler(storage: DIDatabaseManager())
dbHandler.handle(string: "Database Test")


