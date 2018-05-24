//
//  String+helpers.swift
//  BestHeroes&Villians
//
//  Created by Christian Riboldi on 5/23/18.
//  Copyright © 2018 Christian Riboldi. All rights reserved.
//

import Foundation

extension String {
    
    var isEmpty: Bool {
        return self.trimmingCharacters(in: .whitespaces) == "" || self.count == 0
    }
    
}
