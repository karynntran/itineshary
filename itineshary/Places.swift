//
//  Places.swift
//  itineshary
//
//  Created by Karynn Elio on 1/16/20.
//  Copyright © 2020 karynntran. All rights reserved.
//


import Foundation

struct CountriesList: Decodable {
    let countriesList: [Country]
}

struct Countries: Decodable {
    let countries: [String:String]
}

struct Country: Decodable {
    let code: String
    let country: String
}

struct CitiesList: Decodable {
    let cities: [City]
}

struct City: Decodable {
    let name: String
}
