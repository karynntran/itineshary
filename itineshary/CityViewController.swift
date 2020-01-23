//
//  CityViewController.swift
//  itineshary
//
//  Created by Karynn Elio on 1/23/20.
//  Copyright © 2020 karynntran. All rights reserved.
//

import UIKit

class CityViewController: UIViewController {
    
    @IBOutlet weak var CityViewTitle: UINavigationItem!
    var currentCity: String = ""
    
    var cityRecoList: [UserInputs] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        CityViewTitle.title = "Recommendations for \(currentCity)"
        
        loadCities()
    }
    
    func loadCities() {
        let list = allInputs.inputsList
        
        for item in list {
            if (item.city == currentCity) {
                cityRecoList.append(item)
            }
        }
        
        print(cityRecoList)
    }
}
