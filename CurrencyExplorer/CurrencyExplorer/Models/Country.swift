//
//  Country.swift
//  CurrencyExplorer
//
//  Created by sokolli on 4/9/24.
//

import Foundation

struct Country: Codable {
    let capital: String
    let code: String
    let currency: CurrencyData
    let flag: String
    let language: LanguageData
    let name: String
    let region: String
}
