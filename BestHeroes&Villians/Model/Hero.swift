//
//  Hero.swift
//  BestHeroes&Villians
//
//  Created by Christian Riboldi on 5/23/18.
//  Copyright © 2018 Christian Riboldi. All rights reserved.
//

import Foundation

class Hero {
    
    //
    // MARK: - Constants
    //
    struct Constants {
        static let nameKey = "name"
        static let superpowerKey = "superpower"
        static let uuidKey = "uuid"
    }
    
    //
    // MARK: - Properties
    //
    let name: String
    let superpower: String
    let uuid: UUID
    
    //
    // MARK: - Initialization
    //
    init(name: String, superpower: String, uuid: UUID = UUID()) {
        self.name = name
        self.superpower = superpower
        self.uuid = uuid
    }
    
    //
    // MARK: - Failable Initialization
    //
    init?(jsonDictionary: [String: Any], identifier: String) {
        guard let name = jsonDictionary[Constants.nameKey] as? String,
              let superpower = jsonDictionary[Constants.superpowerKey] as? String,
              let uuid = UUID(uuidString: identifier) else {
            return nil
        }
        
        self.name = name
        self.superpower = superpower
        self.uuid = uuid
    }
    
    //
    // MARK: - JSON Representation
    //
    var dictionaryRepresentation: [String: Any] {
        let dictionary: [String: Any] = [
            Constants.nameKey: self.name,
            Constants.superpowerKey: self.superpower,
            Constants.uuidKey: self.uuid.uuidString
        ]
        return dictionary
    }
    
    var jsonData: Data? {
        return try? JSONSerialization.data(withJSONObject: dictionaryRepresentation, options: .prettyPrinted)
    }
}
