//
//  CountriesViewController.swift
//  itineshary
//
//  Created by Karynn Elio on 1/23/20.
//  Copyright © 2020 karynntran. All rights reserved.
//

import UIKit

class CountriesViewController: UITableViewController {
    
    
    @IBOutlet var CountryTableView: UITableView!
    
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
        let arr = Array(Set(dbAllInputs.map { $0.fullDestination }))
        
        currentCountryList = arr.sorted(by: {
            $0 < $1
        })
        
        DispatchQueue.main.async {
            self.CountryTableView.reloadData()
        }
        
        currentCountry = currentState.country
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
        
        print(currentCountryList[indexPath.row])
        if cell.textLabel?.text == "No recommendations added yet." {
            cell.isUserInteractionEnabled = false
        } else {
            cell.isUserInteractionEnabled = true
        }
        
        if indexPath.row % 2 == 0 {
            cell.backgroundColor = UIColor(red: 127/255, green: 174/255, blue: 224/255, alpha: 1.0)
        } else {
            cell.backgroundColor = UIColor(red: 177/255, green: 200/255, blue: 224/255, alpha: 1.0)
        }
        
        cell.textLabel?.textColor = UIColor.white
        
        return cell
     }
     
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.destination is CityViewController
        {
            let cityv = segue.destination as? CityViewController
            
            let truncated = currentCountryList[tableView.indexPathForSelectedRow!.row].components(separatedBy: "- ")[1]
            
            print(truncated)
            
            cityv?.currentCity = truncated
        }
    }
    

}
