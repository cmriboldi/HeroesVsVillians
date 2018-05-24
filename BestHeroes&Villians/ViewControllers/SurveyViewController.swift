//
//  SurveyViewController.swift
//  BestHeroes&Villians
//
//  Created by Christian Riboldi on 5/23/18.
//  Copyright © 2018 Christian Riboldi. All rights reserved.
//

import UIKit

class SurveyViewController: UIViewController {

    //
    // MARK: - Constants
    //
    struct Constants {
        static let heroColor: UIColor = UIColor(rgb: 0xCC48C6)
        static let villianColor = UIColor(rgb: 0x0A3284)
        static let heroTitle = "Hero"
        static let villianTitle = "Villain"
        static let heroDictionary = [0:HeroInfo(title: Constants.heroTitle, color: Constants.heroColor),
                                     1:HeroInfo(title: Constants.villianTitle, color: Constants.villianColor)]
    }
    
    //
    // MARK: - Initialization
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        setNameTextFieldPlaceholder(for: heroTypeSelector.selectedSegmentIndex)
    }
    
    //
    // MARK: - IBOutlets
    //
    @IBOutlet weak var heroTypeSelector: UISegmentedControl!
    @IBOutlet weak var heroNameTextField: UITextField!
    @IBOutlet weak var heroPowersTextField: UITextField!
    @IBOutlet weak var heroSubmitButton: UIButton!
    
    //
    // MARK: - IBActions
    //
    @IBAction func submitHeroPressed(_ sender: Any) {
        guard let name = heroNameTextField.text, !name.isEmpty,
              let powers = heroPowersTextField.text, !powers.isEmpty else {
            return
        }
        
        let heroType = SurveyController.getHeroKey(for: heroTypeSelector.selectedSegmentIndex)
        
        SurveyController.putHero(withType: heroType, name: name, powers: powers) { (success) in
            print("putting hero was successful: \(success)")
            guard success else { return }
            
            DispatchQueue.main.async {
                self.heroNameTextField.text = ""
                self.heroPowersTextField.text = ""
            }
        }
        
    }
    
    @IBAction func selectedHeroType(_ sender: Any) {
        let selectedIndex = heroTypeSelector.selectedSegmentIndex
        
        UIView.animate(withDuration: 1.0) {
            self.heroTypeSelector.tintColor = Constants.heroDictionary[selectedIndex]?.color
            self.heroSubmitButton.backgroundColor = Constants.heroDictionary[selectedIndex]?.color
            if let tabBar = self.tabBarController as? SurveyTabBarViewController {
                tabBar.invertTintColors()
            }
        }
        setNameTextFieldPlaceholder(for: selectedIndex)
    }
    
    //
    // MARK: - Helpers
    //
    func setNameTextFieldPlaceholder(for index: Int) {
        heroNameTextField.placeholder = "Enter your favorite \((Constants.heroDictionary[index]?.title) ?? "Hero")"
        heroPowersTextField.placeholder = "Enter you \((Constants.heroDictionary[index]?.title) ?? "Hero")'s superpower"
    }
}

class HeroInfo {
    var title: String
    var color: UIColor
    
    init(title: String, color: UIColor) {
        self.title = title
        self.color = color
    }
}
