//
//  PlacesViewController.swift
//  itineshary
//
//  Created by Karynn Elio on 1/16/20.
//  Copyright © 2020 karynntran. All rights reserved.
//

import Foundation

import UIKit

class PlacesViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        getCountries()
    }
    
    func getCountries() {
        
        var countriesList: CountriesList!
        
        let headers = [
            "x-rapidapi-host": COUNTRIES_REQUEST["API"]!,
            "x-rapidapi-key": COUNTRIES_REQUEST["KEY"]!,
            "Content-Type":"application/json",
            "Accept":"application/json"
        ]

        let request = NSMutableURLRequest(url: NSURL(string: "https://\(COUNTRIES_REQUEST["API"]!)/location/country/list?format=json")! as URL, cachePolicy: .useProtocolCachePolicy,timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers

        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in

            guard let data = data else {
                return
            }
                        
            if (error != nil) {
                print(error!)
            } else {
                do {
                    countriesList = try JSONDecoder().decode(CountriesList.self, from: data)
                    print(countriesList.countries["ET"]!)

                } catch let jsonErr {
                    print("error", jsonErr)
                }
                
            }
        })

        dataTask.resume()
    }
}
