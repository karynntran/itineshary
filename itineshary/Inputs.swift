//
//  Inputs.swift
//  itineshary
//
//  Created by Karynn Elio on 1/21/20.
//  Copyright © 2020 karynntran. All rights reserved.
//

import Foundation

struct AllInputs {
    var inputsList: [UserInputs]
}


struct UserInputs {
    var country: String
    var city: String
    var reco: String
    var notes: String
    var filters: [String]
    
    init(country: String = "",
        city: String = "",
        reco: String = "",
        notes: String = "",
        filters: [String] = []) {
        
        self.country = country
        self.city = city
        self.reco = reco
        self.notes = notes
        self.filters = filters
    }
    
    mutating func updateUserInput(
        country: String? = nil,
        city: String? = nil,
        reco: String? = nil,
        notes: String? = nil,
        filters: [String]? = nil) {
        
        self.country = country != nil ? country! : self.country
        self.city = city != nil ? city! : self.city
        self.reco = reco != nil ? reco! : self.reco
        self.notes = notes != nil ? notes! : self.notes
        self.filters = filters != nil ? filters! : self.filters

        
    }
}

//global variables

var allInputs = AllInputs(
    inputsList: []
)

var userInputs = UserInputs()

