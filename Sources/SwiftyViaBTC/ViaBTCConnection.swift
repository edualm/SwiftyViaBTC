//
//  ViaBTCConnection.swift
//  SwiftyViaBTC
//
//  Created by Eduardo Almeida on 17/05/2021.
//

import Foundation

public class ViaBTCConnection {
    
    public enum ViaBTCError: Error {
        
        case invalidResponse
    }
    
    public typealias ProfitSummary = ViaBTCResponse.AcquireProfitSummary.Data
    public typealias Hashrate = ViaBTCResponse.AcquireHashrate.Data
    
    static private let Endpoint = "https://www.viabtc.com/res/openapi/v1"
    
    let apiKey: String
    
    public init(apiKey: String) {
        self.apiKey = apiKey
    }
    
    private func performCall<T: Decodable>(withPath path: String, queryString: String, completionHandler: @escaping (Result<T, ViaBTCError>) -> ()) {
        let url = URL(string: "\(ViaBTCConnection.Endpoint)\(path)?\(queryString)")!
        
        var urlRequest = URLRequest(url: url)
        
        urlRequest.addValue(apiKey, forHTTPHeaderField: "X-API-KEY")
        
        let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            guard error == nil, let response = response as? HTTPURLResponse else {
                completionHandler(.failure(.invalidResponse))
                
                return
            }
            
            if response.statusCode == 403 || response.statusCode == 500 {
                completionHandler(.failure(.invalidResponse))
                
                return
            }
            
            guard let data = data else {
                completionHandler(.failure(.invalidResponse))
                
                return
            }
            
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            
            guard let parsedResponse = try? decoder.decode(T.self, from: data) else {
                completionHandler(.failure(.invalidResponse))

                return
            }

            completionHandler(.success(parsedResponse))
        }
        
        task.resume()
    }
    
    public func acquireProfitSummary(coin: String, completionHandler: @escaping (Result<ProfitSummary, ViaBTCConnection.ViaBTCError>) -> ()) {
        performCall(withPath: "/profit", queryString: "coin=\(coin)") { (result: Result<ViaBTCResponse.AcquireProfitSummary, ViaBTCError>) in
            switch result {
            case .success(let response):
                completionHandler(.success(response.data))
                
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    public func acquireHashrate(coin: String, completionHandler: @escaping (Result<Hashrate, ViaBTCConnection.ViaBTCError>) -> ()) {
        performCall(withPath: "/hashrate", queryString: "coin=\(coin)") { (result: Result<ViaBTCResponse.AcquireHashrate, ViaBTCError>) in
            switch result {
            case .success(let response):
                completionHandler(.success(response.data))
                
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
}
