//
//  API.swift
//  ExchangeRates
//
//  Created by Jeff Tabios on 3/21/21.
//  Copyright © 2021 Jeff Tabios. All rights reserved.
//

import Foundation

public enum APIServiceError: Error {
    case none
    case apiError
    case invalidEndpoint
    case invalidResponse
    case noData
    case decodeError
    case fileNotFound
}

protocol APIProtocol{
    func request<DomainModel: Codable>(endPoint: String, completion: @escaping (Result<DomainModel, APIServiceError>)->Void)
    func decode<DomainModel: Decodable>(completion: @escaping (Result<DomainModel, APIServiceError>)->Void)
}

class API: APIProtocol{
    
    var session: URLSession = URLSession.shared
    var dataTask: URLSessionDataTask?
    var data: Data?
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func request<DomainModel: Codable>(endPoint: String, completion: @escaping (Result<DomainModel, APIServiceError>)->Void){
        
        let url = URL(string: endPoint)!
        let request = URLRequest(url: url)
        
        dataTask = session.dataTask(with: request) { [weak self] (data, response, error) in

            defer {
                self?.dataTask = nil
            }

            if error != nil {
                completion(.failure(.apiError))
            } else if
                let data = data,
                let response = response as? HTTPURLResponse,
                response.statusCode == 200
            {
                self?.data = data
                self?.decode(completion: completion)
            }else{
                completion(.failure(.invalidResponse))
            }
        }
        
        dataTask?.resume()

    }
    
    func decode<DomainModel: Decodable>(completion: @escaping (Result<DomainModel, APIServiceError>)->Void){
        if let data = data {
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            guard let result = try? decoder.decode(DomainModel.self, from: data) else{
                completion(.failure(.decodeError))
                return
            }
            completion(.success(result))
        }else{
            completion(.failure(.decodeError))
        }
    }
}
