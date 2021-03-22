//
//  BankService.swift
//  ExchangeRates
//
//  Created by Jeff Tabios on 3/21/21.
//  Copyright © 2021 Jeff Tabios. All rights reserved.
//

import Foundation

final class BankService: API {
    
    func getAllData(completion: @escaping (Result<(ModelBanks?, ModelCurrencies?, [ModelCurrencyRates]?), APIServiceError>)->Void) {
        
        var banks: ModelBanks?
        var currencies: ModelCurrencies?
        var currencyRates: [ModelCurrencyRates]? = []
        let group = DispatchGroup()
        
        group.enter()
        getBanks { result in
            switch result {
            case .success(let resultBanks):
                banks = resultBanks
            case .failure(let error):
                completion(.failure(error))
            }
            group.leave()
        }
        
        group.enter()
        getCurrencies { result in
            switch result {
            case .success(let resultCurrencies):
                currencies = resultCurrencies
            case .failure(let error):
                completion(.failure(error))
            }
            group.leave()
        }
        
        group.wait()
        
        let bankIds = banks?.data.map { $0.id }
        
        bankIds?.forEach { (bankId) in
            group.enter()
            getCurrencyRate(bankId: bankId) { result in
                switch result {
                case .success(let resultRate):
                    let rates = ModelCurrencyRates(bankId: bankId, rates: resultRate)
                    currencyRates?.append(rates)
                case .failure(let error):
                    completion(.failure(error))
                }
                group.leave()
            }
        }
        
        group.notify(queue: .main) {
            completion(.success((banks, currencies, currencyRates)))
        }
    }
    
    func getCurrencyRates(bankIds: [Int], completion: @escaping (Result<[ModelCurrencyRates]?, APIServiceError>)->Void) {
        
        var currencyRates: [ModelCurrencyRates]? = []
        let group = DispatchGroup()
        
        bankIds.forEach { (bankId) in
            group.enter()
            getCurrencyRate(bankId: bankId) { result in
                switch result {
                case .success(let resultRate):
                    let rates = ModelCurrencyRates(bankId: bankId, rates: resultRate)
                    currencyRates?.append(rates)
                case .failure(let error):
                    completion(.failure(error))
                }
                group.leave()
            }
        }
        
        group.notify(queue: .main) {
            completion(.success(currencyRates))
        }
    }
    
    func getCurrencyRate(bankId: Int, completion: @escaping (Result<ModelCurrencyRate, APIServiceError>)->Void) {
        request(endPoint: CurrencyRatesAPI.getBankRates(bankId: bankId).endpoint, completion: completion)
    }
    
    func getBanks(completion: @escaping (Result<ModelBanks, APIServiceError>)->Void) {
        request(endPoint: CurrencyRatesAPI.getBanks.endpoint, completion: completion)
    }
    
    func getCurrencies(completion: @escaping (Result<ModelCurrencies, APIServiceError>)->Void) {
        request(endPoint: CurrencyRatesAPI.getCurrencies.endpoint, completion: completion)
    }
        
}
