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
    
    var currentCountry: String = ""
    var count: Int = 0
    let currentCountryList = Array(Set(allInputs.inputsList.map { $0.city }))
        
    override func viewDidLoad() {
        super.viewDidLoad()
        CountryListTitle.title = "Listed \(currentCountry) Cities"
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
        return cell
     }
     
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.destination is CityViewController
        {
            var cityv = segue.destination as? CityViewController
            cityv?.currentCity = currentCountryList[tableView.indexPathForSelectedRow!.row]
        }
    }
    

}
