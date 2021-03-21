//
//  BankExchangesViewModelTests.swift
//  ExchangeRatesTests
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
    
}
