//
//  BankExchangesViewModelTests.swift
//  CurrencyRates-SwiftUITests
//
//  Created by Jeff Tabios on 3/21/21.
//  Copyright © 2021 Jeff Tabios. All rights reserved.
//

import XCTest
@testable import ExchangeRates

class BankExchangesViewModelTests: XCTestCase {
    
    func test_setBankExchanges() {
        let sut = BankExchangesViewModel()
        let exp = expectation(description: "Set Exchanges")
        
        sut.getAllData {
            exp.fulfill()
        }
        
        waitForExpectations(timeout: 3)
        XCTAssertEqual(sut.bankExchanges.count, 6)
    }
    
    func test_refreshRates() {
        let sut = BankExchangesViewModel()
        let exp = expectation(description: "Set Exchanges")
        
        sut.fromId = 2
        sut.toId = 4
        sut.bankMap[1] = "Some bank"
        sut.bankMap[2] = "Some bank"
        sut.bankMap[3] = "Some bank"
        sut.bankMap[4] = "Some bank"
        sut.bankMap[5] = "Some bank"
        sut.bankMap[6] = "Some bank"
        
        sut.currencyCodeMap[1] = "CAD"
        sut.currencyCodeMap[2] = "EUR"
        sut.currencyCodeMap[3] = "USD"
        sut.currencyCodeMap[4] = "UAE Dirham"
        
        sut.refreshRates {
            exp.fulfill()
        }
        
        waitForExpectations(timeout: 3)
        XCTAssertEqual(sut.bankRates.count, 4)
    }
}
