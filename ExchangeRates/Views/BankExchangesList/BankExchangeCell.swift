//
//  BankExchangeCell.swift
//  ExchangeRates
//
//  Created by Jeff Tabios on 3/21/21.
//  Copyright © 2021 Jeff Tabios. All rights reserved.
//

import Foundation
import UIKit

final class BankExchangeCell: UITableViewCell {
    
    var fromId: Int?
    var toId: Int?
    var bankMap: [Int: String] = [:]
    var currencyCodeMap: [Int: String] = [:]
}
