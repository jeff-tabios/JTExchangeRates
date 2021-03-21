//
//  ModelExchanges.swift
//  CurrencyRates-SwiftUI
//
//  Created by Jeff Tabios on 3/21/21.
//  Copyright © 2021 Jeff Tabios. All rights reserved.
//

import Foundation

struct ModelExchanges {
    
    let bank: String
    let exchanges: [ModelExchange]

    init(bank: String, exchanges: [ModelExchange]) {
        self.bank = bank
        self.exchanges = exchanges
    }
}

struct ModelExchange {
    let fromId: Int
    let toId: Int
    let label: String

    init(fromId: Int, toId: Int, label: String) {
        self.fromId = fromId
        self.toId = toId
        self.label = label
    }
}
