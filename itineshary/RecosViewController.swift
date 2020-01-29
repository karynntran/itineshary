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

    @IBOutlet weak var backgroundView: UIView!
    
    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var recoText: UITextField!
    @IBOutlet weak var notesText: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    
    let buttons: [String] = ["activity", "breakfast", "lunch", "dinner", "drinks", "dessert", "kids", "adults"]
    
    
    @IBAction func createInputToDB() {
        let _ = InputManager.main.create()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let bg = BackgroundGradient()
        bg.createGradient(view: view, backgroundView: backgroundView)
        
        countryLabel.text = currentCountry
        cityLabel.text = currentCity
        
        errorLabel.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(true)
        
        currentCountry = currentState.country
        currentCity = currentState.city
            
        countryLabel.text = currentCountry
        cityLabel.text = currentCity
        
        for view in self.contentView.subviews as [UIView] {
            if let btn = view as? UIButton {
                if btn.accessibilityIdentifier == "filter" {
                    btn.layer.cornerRadius = 8
                }
            }
        }

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        clearInputs()
    }
    
    
    @IBAction func buttonTapped(sender: UIButton)
    {
        
        sender.isSelected = sender.isSelected ?  false : true
        let backgroundColor = sender.isSelected ? UIColor.systemYellow : UIColor.white
        sender.backgroundColor = backgroundColor
    }
    
    @IBAction func SubmitRecos(_ sender: Any) {
        let reco: String? = recoText.text
        let notes: String? = notesText.text
        var filters: [String] = []
        
        
        for view in self.contentView.subviews as [UIView] {
            if let btn = view as? UIButton {
                if btn.isSelected {
                    let tag = btn.tag
                    filters.append(self.buttons[tag])
                }
            }
        }
        
        if reco == "" || notes == "" || filters.count == 0 {
            errorLabel.isHidden = false
            return
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
                
//        allInputs.inputsList.append(userInputs)
        
        createInputToDB()
        
        errorLabel.isHidden = true

        clearInputs()

        createNewInput()

        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.destination is CityViewController
        {
            let cv = segue.destination as? CityViewController
            cv?.currentCity = currentCity
        }
    }
    
    func clearInputs(){
        recoText.text = ""
        notesText.text = ""
        
        for view in self.contentView.subviews as [UIView] {
            if let btn = view as? UIButton {
                if btn.isSelected {
                    btn.isSelected = false
                    btn.backgroundColor = UIColor.white
                }
            }
        }
    }
    
}

