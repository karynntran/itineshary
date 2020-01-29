//
//  CityViewController.swift
//  itineshary
//
//  Created by Karynn Elio on 1/23/20.
//  Copyright © 2020 karynntran. All rights reserved.
//

import UIKit

class CityViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
        
    
    
    
    @IBOutlet weak var CityViewTitle: UINavigationItem!
    
    var currentCity: String = ""
    
    var cityRecoList: [UserInputs] = []
    
    @IBOutlet weak var backgroundView: UIView!
    
    var dbAllInputs: [UserInputs] = []

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        dbAllInputs = InputManager.main.getAllInputs()
        
        loadCities()

        CityViewTitle.title = "Recos for \(currentCity)"
    }
    
    override func viewDidLoad(){
        super.viewDidLoad()

        let bg = BackgroundGradient()
        bg.createGradient(view: view, backgroundView: backgroundView)
        
    }
    
    func loadCities() {
        let list = dbAllInputs
        
        for item in list {
            if (item.city == currentCity) {
                cityRecoList.append(item)
            }
        }
        
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cityRecoList.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        // get a reference to our storyboard cell

        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CityCell", for: indexPath as IndexPath) as! CityCell

        // Use the outlet in our custom class to get a reference to the UILabel in the cell
        
        cell.recoText.text = cityRecoList[indexPath.row].reco
        
        cell.notesText.text = cityRecoList[indexPath.row].notes
        
        
        cell.filtersText.text = cityRecoList[indexPath.row].filters.joined(separator: ", ")
        
        cell.layer.cornerRadius = 15

        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        
        let width = view.frame.size.width - 20
        let height = view.frame.size.height / 4
            
        return CGSize(width: width, height: height)
    }
    
    
}
