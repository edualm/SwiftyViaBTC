//
//  ViaBTCResponse.swift
//  SwiftyViaBTC
//
//  Created by Eduardo Almeida on 17/05/2021.
//

import Foundation

public enum ViaBTCResponse {
    
    enum APIError: Error {
        case decodingError
    }
    
    public struct AcquireHashrate: Decodable {
        
        public struct Data: Decodable {
            
            public let activeWorkers: Int
            public let coin: String
            public let hashrate10min: Int
            public let hashrate1hour: Int
            public let hashrate24hour: Int
            public let unactiveWorkers: Int
        }
        
        public let code: Int
        public let data: Data
        public let message: String
    }
    
    public struct AcquireProfitSummary: Decodable {
        
        public struct Data: Decodable {
            
            public let coin: String
            public let pplnsProfit: Double
            public let ppsProfit: Double
            public let soloProfit: Double
            public let totalProfit: Double
        }
        
        public let code: Int
        public let data: Data
        public let message: String
    }
}
