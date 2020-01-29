//
//  CountriesViewController.swift
//  itineshary
//
//  Created by Karynn Elio on 1/23/20.
//  Copyright © 2020 karynntran. All rights reserved.
//

import UIKit

class CountriesViewController: UITableViewController {
    
    @IBOutlet weak var CountryListTitle: UINavigationItem!
    
    @IBOutlet weak var RecommendationsTitle: UILabel!
    
    @IBOutlet weak var CountryBackBtn: UINavigationItem!
    
    var currentCountry: String = ""
    var count: Int = 0
    var currentCountryList: [String] = []
    
    var dbAllInputs: [UserInputs] = []
        
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        dbAllInputs = InputManager.main.getAllInputs()
        
        currentCountry = currentState.country
        currentCountryList = Array(Set(dbAllInputs.map { $0.fullDestination }))
        if currentCountryList.count == 0 {
            currentCountryList.append("No recommendations added")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        
        RecommendationsTitle.text = "All Itineraries"
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
         return 1
     }
     
     override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentCountryList.count
     }

     override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: "CountryCell", for: indexPath)
                
        cell.textLabel?.text = currentCountryList[indexPath.row]
        if cell.textLabel?.text == "No recommendations added" {
            cell.isUserInteractionEnabled = false
        } else {
            cell.isUserInteractionEnabled = true
        }
        return cell
     }
     
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.destination is CityViewController
        {
            let cityv = segue.destination as? CityViewController
            
            let truncated = currentCountryList[tableView.indexPathForSelectedRow!.row].components(separatedBy: "- ")[1]
            
            cityv?.currentCity = truncated
        }
    }
    

}
