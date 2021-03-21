//
//  CurrencyRatesAPI.swift
//  CurrencyRates-SwiftUI
//
//  Created by Jeff Tabios on 3/21/21.
//  Copyright © 2021 Jeff Tabios. All rights reserved.
//

import Foundation

enum CurrencyRatesAPI {
    case getBanks
    case getCurrencies
    case getBankRates(bankId: Int)
}

extension CurrencyRatesAPI {
    
    var baseURL: String {
        return "https://challenge-currency-rate.herokuapp.com/api"
    }
    
    var endpoint: String {
        var path = ""
        switch self {
            case .getBanks:
            path = "/banks"
            case .getCurrencies:
            path = "/currencies"
            case .getBankRates(let bankId):
            path = "/currency_rate/\(bankId)"
        }
        
        return baseURL + path
    }
}

