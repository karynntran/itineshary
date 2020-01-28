//
//  RecosViewController.swift
//  itineshary
//
//  Created by Karynn Elio on 1/16/20.
//  Copyright © 2020 karynntran. All rights reserved.
//

import UIKit

class RecosViewController: UIViewController {
    
    var currentCountry: String = ""
    var currentCity: String = ""


    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var recoText: UITextField!
    @IBOutlet weak var notesText: UITextField!
    
    let buttons: [String] = ["activity", "breakfast", "lunch", "dinner", "drinks", "dessert", "kids", "adults"]
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(true)
        
        currentCountry = currentState.country
        currentCity = currentState.city
            
        countryLabel.text = currentCountry
        cityLabel.text = currentCity
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        clearInputs()
    }
    
    
    @IBAction func buttonTapped(sender: UIButton)
    {
        
        sender.isSelected = sender.isSelected ?  false : true
        var backgroundColor = sender.isSelected ? UIColor.yellow : UIColor.black
        sender.backgroundColor = backgroundColor
    }
    
    @IBAction func SubmitRecos(_ sender: Any) {
        let reco: String? = recoText.text
        let notes: String? = notesText.text
        var filters: [String] = []
        
        for view in self.view.subviews as [UIView] {
            if let btn = view as? UIButton {
                if btn.isSelected {
                    let tag = btn.tag
                    filters.append(self.buttons[tag])
                }
            }
        }
        
        userInputs.updateUserInput(
            country: currentCountry,
            city: currentCity,
            fullDestination: "\(currentCountry) - \(currentCity)",
            reco: reco,
            notes: notes,
            filters: filters
        )
        
        currentState.city = currentCity
        currentState.country = currentCountry
                
        allInputs.inputsList.append(userInputs)
        
        clearInputs()

        createNewInput()

        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.destination is CityViewController
        {
            var cv = segue.destination as? CityViewController
            cv?.currentCity = currentCity
        }
    }
    
    func clearInputs(){
        recoText.text = ""
        notesText.text = ""
        
        for view in self.view.subviews as [UIView] {
            if let btn = view as? UIButton {
                if btn.isSelected {
                    btn.isSelected = false
                    btn.backgroundColor = UIColor.black
                }
            }
        }
    }
    
}

