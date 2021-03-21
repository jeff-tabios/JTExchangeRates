//
//  ServiceTests.swift
//  CurrencyRates-SwiftUITests
//
//  Created by Jeff Tabios on 3/21/21.
//  Copyright © 2021 Jeff Tabios. All rights reserved.
//

import XCTest
@testable import ExchangeRates

class ServiceTests: XCTestCase {

    func test_getBanks() {
        
        let sut = BankService()
        var banks: ModelBanks?
        let exp = expectation(description: "Get Banks")
        
        sut.getBanks { result in
            switch result {
            case .success(let resultBanks):
                banks = resultBanks
            case .failure(_):
                break
            }
            exp.fulfill()
        }
        
        waitForExpectations(timeout: 3)
        
        XCTAssertEqual(banks?.data.count, 6)
    }
    
    func test_getCurrencies() {
        
        let sut = BankService()
        var currencies: ModelCurrencies?
        let exp = expectation(description: "Get Currencies")
        
        sut.getCurrencies { result in
            switch result {
            case .success(let resultCurrencies):
                currencies = resultCurrencies
            case .failure(_):
                break
            }
            exp.fulfill()
        }
        
        waitForExpectations(timeout: 3)
        XCTAssertEqual(currencies?.data.count, 9)
    }
    
    func test_getCurrencyRates() {
        
        let sut = BankService()
        var banks: ModelBanks?
        var currencies: ModelCurrencies?
        var currencyRates: [ModelCurrencyRates]?
        let exp = expectation(description: "Get Currency Rates")
        
        sut.getAllData { result in
            switch result {
            case .success(let data):
                banks = data.0
                currencies = data.1
                currencyRates = data.2
            case .failure(_):
                break
            }
            exp.fulfill()
        }
        
        waitForExpectations(timeout: 3)
        
        XCTAssertEqual(banks?.data.count, 6)
        XCTAssertEqual(currencies?.data.count, 9)
        XCTAssertEqual(currencyRates?.count, 6)
    }
    
}
