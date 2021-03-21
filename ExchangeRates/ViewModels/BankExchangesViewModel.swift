//
//  CurrencyRatesViewModel.swift
//  CurrencyRates-SwiftUI
//
//  Created by Jeff Tabios on 3/21/21.
//  Copyright © 2021 Jeff Tabios. All rights reserved.
//

import Foundation

class BankExchangesViewModel {
    let bankService = BankService()
    
    var fromId: Int?
    var toId: Int?
    
    var banks: ModelBanks?
    var currencies: ModelCurrencies?
    var rates: [ModelCurrencyRates]?
    
    var bankMap: [Int: String] = [:]
    var currencyMap: [Int: String] = [:]
    var currencyCodeMap: [Int: String] = [:]
    
    var bankExchanges: [ModelExchanges] = []
    var bankRates: [ModelBankRates] = []
    
    func getAllData(completion: @escaping () -> Void) {
        bankService.getAllData { [unowned self] (result) in
            
            switch result {
            case .success(let data):
                self.banks = data.0
                self.currencies = data.1
                self.rates = data.2
                self.prepareData()
                completion()
            case .failure(_):
                break
            }
        }
    }
    
    func prepareData() {
        //Prepare maps for fast lookup
        banks?.data.forEach {
            bankMap[$0.id] = $0.name
        }
        
        currencies?.data.forEach {
            currencyMap[$0.id] = $0.name
            currencyCodeMap[$0.id] = $0.code
        }
        
        //Prepare bank exchanges data (for first screen)
        rates?.forEach { (bankRates) in
            if let bankName = bankMap[bankRates.bankId] {
                var exchanges: [ModelExchange] = []
                var exchangesMemo: [String: Bool] = [:]
                
                bankRates.rates.data.forEach { (rate) in
                    if let from = currencyMap[rate.fromCurrency],
                        let to = currencyMap[rate.toCurrency] {
                        
                        let exchangeString = "\(from) - \(to)"
                        let exchange = ModelExchange(fromId: rate.fromCurrency, toId: rate.toCurrency, label: exchangeString)
                        
                        if exchangesMemo[exchangeString] == nil {
                            exchanges.append(exchange)
                            exchangesMemo[exchangeString] = true
                        }
                    }
                }
                
                let bankExchange = ModelExchanges(bank: bankName, exchanges: exchanges)
                bankExchanges.append(bankExchange)
            }
        }
    }
    
    func refreshRates(completion: @escaping () -> Void) {
        bankRates = []
        bankService.getCurrencyRates(bankIds: Array(bankMap.keys)) { [unowned self] (result) in

            switch result {
            case .success(let data):
                self.rates = data
                self.prepareRates()
                completion()
            case .failure(_):
                break
            }
        }
    }
    
    func prepareRates() {

        //Prepare bank rates data (for second screen)
        rates?.forEach { (bankData) in
            if let bankName = bankMap[bankData.bankId],
                let fromId = fromId, let toId = toId {
                
                var rates: [ModelBankRate] = []
                
                let filteredRate = bankData.rates.data.filter({ (rate) -> Bool in
                    rate.fromCurrency == fromId && rate.toCurrency == toId
                }).first
                
                if let filteredRate = filteredRate {
                    let rate = ModelBankRate(rate: "1 \(self.currencyCodeMap[fromId]!) = \(filteredRate.rate) \(self.currencyCodeMap[toId]!)")
                    
                    rates.append(rate)
                    
                    if rates.count > 0 {
                        let bankRate = ModelBankRates(bank: bankName, rates: rates)
                        bankRates.append(bankRate)
                    }
                }
            }
        }
    }
}
