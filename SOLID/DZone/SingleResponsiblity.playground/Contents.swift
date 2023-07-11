import Foundation

//Every time you create/change a class, you should ask yourself: How many responsibilities does this class have?

class Handler {
    
    func handle() {
        let data = requestDataToAPI()
        let array = parse(data: data)
        saveToDB(array: array)
    }
    
    private func requestDataToAPI() -> Data {
        // send API request and wait the response
        return Data()
    }
    
    private func parse(data: Data) -> [String] {
        // parse the data and create the array
        return [String]()
    }
    
    private func saveToDB(array: [String]) {
        // save the array in a database (CoreData/Realm/...)
    }
}

/*
 How many responsibilities does this class have?

 * Handler retrieves the data from the API (1),
 * parses the API response, creating an array of String, (2) and
 * saves the array in a database (3).
 
 */

class SRHandler {

    let apiHandler: APIHandler
    let parseHandler: ParseHandler
    let dbHandler: DBHandler

    init(apiHandler: APIHandler, parseHandler: ParseHandler, dbHandler: DBHandler) {
        self.apiHandler = apiHandler
        self.parseHandler = parseHandler
        self.dbHandler = dbHandler
    }

    func handle() {
        let data = apiHandler.requestDataToAPI()
        let array = parseHandler.parse(data: data)
        dbHandler.saveToDB(array: array)
    }
}

class APIHandler {

    func requestDataToAPI() -> Data {
        // send API request and wait the response
        return Data()
    }
}

class ParseHandler {

    func parse(data: Data) -> [String] {
        // parse the data and create the array
        return [String]()
    }
}

class DBHandler {

    func saveToDB(array: [String]) {
        // save the array in a database (CoreData/Realm/...)
    }
}

