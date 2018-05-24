//
//  SurveyListViewController.swift
//  BestHeroes&Villians
//
//  Created by Christian Riboldi on 5/23/18.
//  Copyright © 2018 Christian Riboldi. All rights reserved.
//

import UIKit

class SurveyListViewController: UIViewController {

    //
    // MARK: - Constants
    //
    struct Constants {
        static let heroCellID = "HeroCell"
    }
    
    //
    // MARK: - Initialization
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        reloadHeroes()
    }
    
    //
    // MARK: - IBOutlets
    //
    @IBOutlet weak var tableView: UITableView!
    
    //
    // MARK: - Helpers
    //
    func reloadHeroes() {
        SurveyController.fetchHeroes {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

}

extension SurveyListViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let heroKey = SurveyController.getHeroKey(for: section)
        return heroKey.capitalized
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let heroArray = SurveyController.heroesArray(for: section) else {
            return 0
        }
        return heroArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let heroArray = SurveyController.heroesArray(for: indexPath.section) else {
            return UITableViewCell()
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.heroCellID, for: indexPath)
        
        cell.textLabel?.text = heroArray[indexPath.row].name
        cell.detailTextLabel?.text = heroArray[indexPath.row].superpower
        
        return cell
    }
    
}
