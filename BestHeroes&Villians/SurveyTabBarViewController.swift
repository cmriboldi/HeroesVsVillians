//
//  SurveyTabBarViewController.swift
//  BestHeroes&Villians
//
//  Created by Christian Riboldi on 5/23/18.
//  Copyright © 2018 Christian Riboldi. All rights reserved.
//

import UIKit

class SurveyTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.tabBar.tintColor = SurveyViewController.Constants.villianColor
        self.tabBar.unselectedItemTintColor = SurveyViewController.Constants.heroColor
    }
    
    func invertTintColors() {
        let tempSelectedTintColor = self.tabBar.tintColor
        self.tabBar.tintColor = self.tabBar.unselectedItemTintColor
        self.tabBar.unselectedItemTintColor = tempSelectedTintColor
    }

}
