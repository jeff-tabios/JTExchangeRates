//
//  CurrencyRatesViewModel.swift
//  ExchangeRates
//
//  Created by Jeff Tabios on 3/21/21.
//  Copyright © 2021 Jeff Tabios. All rights reserved.
//

import Foundation

class ExchangeRatesViewModel {
    let bankService = BankService()
    
    var fromId: Int?
    var toId: Int?
    
    var rates: [ModelCurrencyRates]?
    var bankMap: [Int: String] = [:]
    var currencyCodeMap: [Int: String] = [:]
    
    var bankRates: [ModelBankRates] = []
    
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
