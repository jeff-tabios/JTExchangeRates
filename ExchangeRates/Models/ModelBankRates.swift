//
//  ModelBankRates.swift
//  ExchangeRates
//
//  Created by Jeff Tabios on 3/21/21.
//  Copyright © 2021 Jeff Tabios. All rights reserved.
//

import Foundation

struct ModelBankRates {
    
    let bank: String
    let rates: [ModelBankRate]

    init(bank: String, rates: [ModelBankRate]) {
        self.bank = bank
        self.rates = rates
    }
}

struct ModelBankRate {
   let rate: String

    init(rate: String) {
        self.rate = rate
    }
}
