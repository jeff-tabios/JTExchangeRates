//
//  ModelBanks.swift
//  ExchangeRates
//
//  Created by Jeff Tabios on 3/21/21.
//  Copyright © 2021 Jeff Tabios. All rights reserved.
//

import Foundation

// MARK: - Banks
struct ModelBanks: Codable {
    let data: [BankData]
    let status: Bool

    init(data: [BankData], status: Bool) {
        self.data = data
        self.status = status
    }
}

// MARK: - Datum
struct BankData: Codable {
    let id: Int
    let name: String

    init(id: Int, name: String) {
        self.id = id
        self.name = name
    }
}
