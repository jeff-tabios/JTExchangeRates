//
//  ModelBankRates.swift
//  CurrencyRates-SwiftUI
//
//  Created by Jeff Tabios on 3/21/21.
//  Copyright © 2021 Jeff Tabios. All rights reserved.
//

import Foundation

class ModelBankRates: Identifiable {
    
    let bank: String
    let rates: [ModelBankRate]

    init(bank: String, rates: [ModelBankRate]) {
        self.bank = bank
        self.rates = rates
    }
}

class ModelBankRate: Identifiable, Hashable {
   let rate: String

    init(rate: String) {
        self.rate = rate
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(rate)
    }
    
    static func == (lhs: ModelBankRate, rhs: ModelBankRate) -> Bool {
        lhs.rate == rhs.rate
    }
}
