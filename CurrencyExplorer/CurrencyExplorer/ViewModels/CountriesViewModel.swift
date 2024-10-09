//
//  CountriesViewModel.swift
//  CurrencyExplorer
//
//  Created by sokolli on 4/10/24.
//

import Foundation

class CountriesViewModel : NSObject {
    private var apiService : APIService!
    private(set) var error: Error? {
        didSet {
            bindCountriesViewModelToController()
        }
    }

    private(set) var countries : [Country]! {
        didSet {
            bindCountriesViewModelToController()
        }
    }

    var bindCountriesViewModelToController: (() -> ()) = {}

    override init() {
        super.init()
        apiService =  APIService()
        callFuncToGetCountryData()
    }

    private func callFuncToGetCountryData() {
        apiService.fetchData {countries,fetchError  in
            if let error = fetchError {
                print("Error fetching country data: \(error.localizedDescription)")
                self.error = error
            } else {
                self.countries = countries
            }
        }
    }
}
