//
//  PlacesViewController.swift
//  itineshary
//
//  Created by Karynn Elio on 1/16/20.
//  Copyright © 2020 karynntran. All rights reserved.
//

import Foundation

import UIKit

class PlacesViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
        
    @IBOutlet weak var CountryPicker: UIPickerView!
    var countriesList: [Country] = []
    var selectedCountry: Country!

    @IBOutlet weak var CityPicker: UIPickerView!
    var citiesList: [City] = []
    var selectedCity: String = ""

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        currentState.country = ""
        currentState.city = ""
        
        self.tabBarController?.tabBar.isHidden = true

        createNewInput()

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.CountryPicker.delegate = self
        self.CountryPicker.dataSource = self
        
        self.CityPicker.delegate = self
        self.CityPicker.dataSource = self
        
        getCountries()

    }
    
    func getCountries() -> Void {
                
        let headers = [
            "x-rapidapi-host": PLACES_REQUEST["API"]!,
            "x-rapidapi-key": PLACES_REQUEST["KEY"]!,
            "Content-Type":"application/json",
            "Accept":"application/json"
        ]

        let request = NSMutableURLRequest(url: NSURL(string: "https://\(PLACES_REQUEST["API"]!)/location/country/list?format=json")! as URL, cachePolicy: .useProtocolCachePolicy,timeoutInterval: 10.0)
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
                    let results = try JSONDecoder().decode(Countries.self, from: data)
                    
                    if results != nil {
                        var countriesArr: [Country] = []
                        for item in results.countries {
                            var country: Country = Country(code: item.key, country: item.value)
                            countriesArr.append(Country(code: item.key, country: item.value))
                        }
                        
                        self.countriesList = countriesArr
                    }
                } catch let jsonErr {
                    print("error", jsonErr)
                }
                
                DispatchQueue.main.async {
                    self.CountryPicker.reloadComponent(0)
                }
                
            }
        })

        dataTask.resume()
    }

    func getCities(country: Country) -> Void {
        let headers = [
            "x-rapidapi-host": PLACES_REQUEST["API"]!,
            "x-rapidapi-key": PLACES_REQUEST["KEY"]!,
            "Content-Type":"application/json",
            "Accept":"application/json"
        ]

        let request = NSMutableURLRequest(url: NSURL(string: "https://\(PLACES_REQUEST["API"]!)/location/country/\(country.code)/city/list?format=json")! as URL, cachePolicy: .useProtocolCachePolicy,timeoutInterval: 10.0)
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
                    let results = try JSONDecoder().decode(CitiesList.self, from: data)

                    if results != nil {
                        var citiesArr: [City] = []
                        for item in results.cities {
                            let city: City = City(name: item.name)
                            citiesArr.append(city)
                        }
                        
                        if citiesArr.count == 0 {
                            let empty = City(name: "No cities listed.")
                            citiesArr.append(empty)
                            
                            DispatchQueue.main.async {
                                self.CityPicker.endEditing(false)
                            }
                        } else {
                            DispatchQueue.main.async {
                                self.CityPicker.endEditing(true)
                            }
                            
                        }
                        
                        self.citiesList = citiesArr
                    
                    }
                } catch let jsonErr {
                    print("error", jsonErr)
                }
                
                DispatchQueue.main.async {
                    self.CityPicker.reloadComponent(0)
                }
                
            }
        })

        dataTask.resume()
    }
    
    
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == CountryPicker {
            return self.countriesList.count
        } else {
            return self.citiesList.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == CountryPicker {
            let sorted = self.countriesList.sorted(by: { $0.country < $1.country })
            self.countriesList = sorted
            return self.countriesList[row].country
        } else {
            var sorted = self.citiesList.sorted(by: { $0.name < $1.name })
            self.citiesList = sorted
            if self.citiesList[0].name == "No cities listed." {
                currentState.country = self.selectedCountry.country
                currentState.city = self.selectedCity
                self.tabBarController?.tabBar.isHidden = false
            }
            return self.citiesList[row].name
        }


    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        if pickerView == CountryPicker {
            self.selectedCountry = self.countriesList[row]
            getCities(country: self.selectedCountry)
            currentState.country = self.selectedCountry.country
        } else {
            self.selectedCity = self.citiesList[row].name
            currentState.country = self.selectedCountry.country
            currentState.city = self.selectedCity
            self.tabBarController?.tabBar.isHidden = false
        }
    }

}
