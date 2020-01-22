//
//  RecosViewController.swift
//  itineshary
//
//  Created by Karynn Elio on 1/16/20.
//  Copyright © 2020 karynntran. All rights reserved.
//

import UIKit

class RecosViewController: UIViewController {

    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var recoText: UITextField!
    @IBOutlet weak var notesText: UITextField!
    
    let buttons: [String] = ["activity", "breakfast", "lunch", "dinner", "drinks", "dessert", "kids", "adults"]
    
    @IBAction func buttonTapped(sender: UIButton)
    {
        let tag = sender.tag
        let selected = buttons[tag]
        
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
        
        userInputs.updateUserInput(country: nil, city: nil, reco: reco, notes: notes, filters: filters)
        
        print(userInputs)
        
//        allInputs.inputsList.append()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        countryLabel.text = userInputs.country
        cityLabel.text = userInputs.city
        
    }
    
}

