//
//  CityViewController.swift
//  itineshary
//
//  Created by Karynn Elio on 1/23/20.
//  Copyright © 2020 karynntran. All rights reserved.
//

import UIKit

class CityViewController: UICollectionViewController {
    
        
    
    
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
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(cityRecoList)
        return cityRecoList.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        // get a reference to our storyboard cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CityCell", for: indexPath as IndexPath) as! CityCell

        // Use the outlet in our custom class to get a reference to the UILabel in the cell
        cell.myLabel.text = cityRecoList[indexPath.row].city

        return cell
    }

    
}
