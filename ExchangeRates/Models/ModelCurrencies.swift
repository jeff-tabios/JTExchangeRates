//
//  ModelCurrencies.swift
//  CurrencyRates-SwiftUI
//
//  Created by Jeff Tabios on 3/21/21.
//  Copyright © 2021 Jeff Tabios. All rights reserved.
//

import Foundation

// MARK: - Currencies
class ModelCurrencies: Codable {
    let data: [CurrencyData]
    let status: Bool

    init(data: [CurrencyData], status: Bool) {
        self.data = data
        self.status = status
    }
}

// MARK: - Datum
class CurrencyData: Codable {
    let code: String
    let id: Int
    let name: String

    init(code: String, id: Int, name: String) {
        self.code = code
        self.id = id
        self.name = name
    }
}
