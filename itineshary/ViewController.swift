//
//  ViewController.swift
//  itineshary
//
//  Created by Karynn Elio on 1/16/20.
//  Copyright © 2020 karynntran. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

        override func viewDidLoad() {
            super.viewDidLoad()
            
            getCountries()
        }
        
        
        func getCountries() {
            let headers = [
                "x-rapidapi-host": COUNTRIES_REQUEST["API"]!,
                "x-rapidapi-key": COUNTRIES_REQUEST["KEY"]!,
                "Content-Type":"application/json",
                "Accept":"application/json"
            ]

            let request = NSMutableURLRequest(url: NSURL(string: "https://countries-cities.p.rapidapi.com/location/country/list?format=json")! as URL,
                                                    cachePolicy: .useProtocolCachePolicy,
                                                timeoutInterval: 10.0)
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

                      let parsedData = try JSONSerialization.jsonObject(with: data) as! [String:Any]

                      print(parsedData["countries"])
                        
                    } catch let error as NSError {
                      print(error)
                    }
                    
                    
                    
                }
            })

            dataTask.resume()
        }


}

