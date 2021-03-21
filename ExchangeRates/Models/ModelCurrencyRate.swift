//
//  ModelCurrencyRates.swift
//  ExchangeRates
//
//  Created by Jeff Tabios on 3/21/21.
//  Copyright © 2021 Jeff Tabios. All rights reserved.
//

import Foundation

// MARK: - CurrencyRates
struct ModelCurrencyRates: Codable {
    
    let bankId: Int
    let rates: ModelCurrencyRate
    
    init(bankId: Int, rates: ModelCurrencyRate) {
        self.bankId = bankId
        self.rates = rates
    }
}

// MARK: - CurrencyRate
struct ModelCurrencyRate: Codable {
    
    let data: [RateData]
    let status: Bool

    init(data: [RateData], status: Bool) {
        self.data = data
        self.status = status
    }
}

// MARK: - Datum
struct RateData: Codable {
    let fromCurrency: Int
    let rate: Double
    let toCurrency: Int

    enum CodingKeys: String, CodingKey {
        case fromCurrency = "from_currency"
        case rate
        case toCurrency = "to_currency"
    }

    init(fromCurrency: Int, rate: Double, toCurrency: Int) {
        self.fromCurrency = fromCurrency
        self.rate = rate
        self.toCurrency = toCurrency
    }
}
