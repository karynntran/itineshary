//
//  Inputs.swift
//  itineshary
//
//  Created by Karynn Elio on 1/21/20.
//  Copyright © 2020 karynntran. All rights reserved.
//

import Foundation
import SQLite3


struct AllInputs {
    var inputsList: [UserInputs]
}

struct UserInputs {
    var country: String
    var city: String
    var fullDestination: String
    var reco: String
    var notes: String
    var filters: [String]
    
    init(country: String = "",
        city: String = "",
        fullDestination: String = "",
        reco: String = "",
        notes: String = "",
        filters: [String] = []) {
        
        self.country = country
        self.city = city
        self.fullDestination = fullDestination
        self.reco = reco
        self.notes = notes
        self.filters = filters
    }
    
    mutating func updateUserInput(
        country: String? = nil,
        city: String? = nil,
        fullDestination: String? = nil,
        reco: String? = nil,
        notes: String? = nil,
        filters: [String]? = nil) {
        
        self.country = country != nil ? country! : self.country
        self.city = city != nil ? city! : self.city
        self.fullDestination = fullDestination != nil ? fullDestination! : self.fullDestination
        self.reco = reco != nil ? reco! : self.reco
        self.notes = notes != nil ? notes! : self.notes
        self.filters = filters != nil ? filters! : self.filters

        
    }
}

func createNewInput() {
    userInputs = UserInputs()
}

//global variables


var userInputs = UserInputs()


struct CurrentState {
    var country: String
    var city: String
}

var currentState = CurrentState(
    country: "",
    city: ""
)

class InputManager {
    var database: OpaquePointer!
    
    static let main = InputManager()
    
    private init(){
    }
    
    func connect() {
        if database != nil {
            return
        }
        
        do {
            let databaseURL = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true).appendingPathComponent("inputs.sqlite3")
        
            if sqlite3_open(databaseURL.path, &database) == SQLITE_OK {
                if sqlite3_exec(database, "CREATE TABLE IF NOT EXISTS inputs (country TEXT, city TEXT, fullDestination TEXT, reco TEXT, notes TEXT, filters TEXT)", nil, nil, nil) == SQLITE_OK {
                }
                else {
                    print("Could not connect")
                }
            } else {
                print("Could not connect")
            }
        }
        catch let error {
            print("Could not create database")
        }
    }
    
    func create() -> Int {
        connect()
        
        var statement: OpaquePointer!
        
        if sqlite3_prepare_v2(database, "INSERT INTO inputs (country, city, fullDestination, reco, notes, filters) VALUES (?,?, ?, ?, ?, ? )", -1, &statement, nil) == SQLITE_OK {
            
            let filterString = userInputs.filters.joined(separator: ", ")
            
            
            sqlite3_bind_text(statement, 1, NSString(string: userInputs.country).utf8String, -1, nil)
            sqlite3_bind_text(statement, 2, NSString(string: userInputs.city
            ).utf8String, -1, nil)
            sqlite3_bind_text(statement, 3, NSString(string: userInputs.fullDestination
            ).utf8String, -1, nil)
            sqlite3_bind_text(statement, 4, NSString(string: userInputs.reco
            ).utf8String, -1, nil)
            sqlite3_bind_text(statement, 5, NSString(string: userInputs.notes
            ).utf8String, -1, nil)
            sqlite3_bind_text(statement, 6, NSString(string: filterString
            ).utf8String, -1, nil)

        } else {
            print("Could not create query")
            return -1
        }
        
        if sqlite3_step(statement) != SQLITE_DONE {
            print("Could not insert input")
            return -1
        }
        
        sqlite3_finalize(statement)
        
        return Int(sqlite3_last_insert_rowid(database))
    }
    
    func getAllInputs() -> [UserInputs] {
        connect()
        
        var result: [UserInputs] = []
        //statement
        //prepare
        //finalize
        
        var statement: OpaquePointer!
        if sqlite3_prepare_v2(database, "SELECT country, city, fullDestination, reco, notes, filters FROM inputs",  -1, &statement, nil) != SQLITE_OK {
            print("Error creating select")
            return []
        }
        
        while sqlite3_step(statement) == SQLITE_ROW {
            result.append(UserInputs(country: String(cString: sqlite3_column_text(statement, 0)),city: String(cString: sqlite3_column_text(statement, 1)), fullDestination: String(cString: sqlite3_column_text(statement, 2)), reco: String(cString: sqlite3_column_text(statement, 3)), notes: String(cString: sqlite3_column_text(statement, 4)), filters: [String(cString: sqlite3_column_text(statement, 5))] )
            )
        }
        
        sqlite3_finalize(statement)
        return result
    }
    
}
