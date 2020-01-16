//
//  Places.swift
//  itineshary
//
//  Created by Karynn Elio on 1/16/20.
//  Copyright © 2020 karynntran. All rights reserved.
//


import Foundation

struct CountriesList: Codable {
    let countries: [Country]
}

struct Country: Codable {
    let name: String
    let cities: [String]
}
