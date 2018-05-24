//
//  SurveyController.swift
//  BestHeroes&Villians
//
//  Created by Christian Riboldi on 5/23/18.
//  Copyright © 2018 Christian Riboldi. All rights reserved.
//

import Foundation

class SurveyController {
    
    //
    // MARK: - Constants
    //
    struct Constants {
        static let baseURL = URL(string: "https://heroes-vs-villians-918b8.firebaseio.com/")
        static let heroesKey = "heroes"
        static let villainsKey = "villains"
    }
    
    //
    // MARK: - Properties
    //
    static var heroesAndVillains: [String: [Hero]] = [Constants.heroesKey: [], Constants.villainsKey: []]
    
    //
    // MARK: - API Calls
    //
    static func putHero(withType type: String, name: String, powers: String, completion: @escaping ((_ success: Bool) -> Void) ) {
        
        // Step 1: Create an instance of what we'd like to add to Firebase
        let hero = Hero(name: name, superpower: powers)
        
        // Step 2: URL
        guard let url = Constants.baseURL?.appendingPathComponent(type).appendingPathComponent(hero.uuid.uuidString).appendingPathExtension("json") else {
            print("Error appending additional component")
            completion(false)
            return
        }
        
        // Step 3: Request
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.httpBody = hero.jsonData
        
        // Step 4: URLSession + Resume
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            
            var success = false
            
            if let error = error {
                print("Error creating Hero: \(error.localizedDescription)")
                completion(success)
                return
            }
            
            guard let data = data, let responseDataString = String(data: data, encoding: .utf8) else {
                print("Error parsing put Hero response data")
                completion(success)
                return
            }
            
            print("Successfully saved hero to endpoint. \nResponse: \(responseDataString)")
            self.heroesAndVillains[type]?.append(hero)
            success = true
            completion(success)
        }.resume()
        
    }
    
    
    static func fetchHeroes(completion: @escaping (()->Void) ) {
        // Step 1: URL
        guard let url = Constants.baseURL?.appendingPathExtension("json") else {
            print("Error with baseURL")
            completion()
            return
        }
        
        // Step 2: request
            // Today we're going to do the shortcut
            // because we're just performing a GET we can use the URLSession that just takes in a URL.
        
        // Step 3: URLSession
        URLSession.shared.dataTask(with: url) { (data, _, error) in

            if let error = error {
                print("Error Fetching Heroes: \(error.localizedDescription)")
                completion()
                return
            }

            guard let data = data else {
                print("No data returned from fetching heroes.")
                completion()
                return
            }

            guard let jsonDictionary = (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)) as? [String: [String: [String: Any]]] else {
                completion()
                return
            }

            guard let heroesDictionary = jsonDictionary[Constants.heroesKey] else {
                print("Error accessing heroes dictionary.")
                completion()
                return
            }
            self.heroesAndVillains[Constants.heroesKey] = heroesDictionary.compactMap { Hero(jsonDictionary: $0.value, identifier: $0.key) }
            
            guard let villainsDictionary = jsonDictionary[Constants.villainsKey] else {
                print("Error accessing villains dictionary.")
                completion()
                return
            }
            self.heroesAndVillains[Constants.villainsKey] = villainsDictionary.compactMap { Hero(jsonDictionary: $0.value, identifier: $0.key) }
            
            completion()
            
        }.resume()
    
    }
    
    //
    // MARK: - Helper Functions
    //
    static func heroesArray(for section: Int) -> [Hero]? {
        return heroesAndVillains[getHeroKey(for: section)]
    }
    
    static func getHeroKey(for section: Int) -> String {
        return (section == 0) ? Constants.heroesKey : Constants.villainsKey
    }
    
}
