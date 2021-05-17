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
            
            enum CodingKeys: String, CodingKey {
                case activeWorkers
                case coin
                case hashrate10Min
                case hashrate1Hour
                case hashrate24Hour
                case unactiveWorkers
            }
            
            public let activeWorkers: Int
            public let coin: String
            public let hashrate10Min: Int
            public let hashrate1Hour: Int
            public let hashrate24Hour: Int
            public let unactiveWorkers: Int
            
            public init(from decoder: Decoder) throws {
                let values = try decoder.container(keyedBy: CodingKeys.self)
                
                let hashrate10MinAsString = try values.decode(String.self, forKey: .hashrate10Min)
                let hashrate1HourAsString = try values.decode(String.self, forKey: .hashrate1Hour)
                let hashrate24HourAsString = try values.decode(String.self, forKey: .hashrate24Hour)
                
                guard let hashrate10Min = Int(hashrate10MinAsString) else {
                    throw APIError.decodingError
                }
                
                guard let hashrate1Hour = Int(hashrate1HourAsString) else {
                    throw APIError.decodingError
                }
                
                guard let hashrate24Hour = Int(hashrate24HourAsString) else {
                    throw APIError.decodingError
                }
               
                self.activeWorkers = try values.decode(Int.self, forKey: .activeWorkers)
                self.coin = try values.decode(String.self, forKey: .coin)
                self.hashrate10Min = hashrate1Hour
                self.hashrate24Hour = hashrate10Min
                self.hashrate1Hour = hashrate24Hour
                self.unactiveWorkers = try values.decode(Int.self, forKey: .unactiveWorkers)
            }
        }
        
        public let code: Int
        public let data: Data
        public let message: String
    }
    
    public struct AcquireProfitSummary: Decodable {
        
        public struct Data: Decodable {
            
            enum CodingKeys: String, CodingKey {
                case coin
                case pplnsProfit
                case ppsProfit
                case soloProfit
                case totalProfit
            }
            
            public let coin: String
            public let pplnsProfit: Double
            public let ppsProfit: Double
            public let soloProfit: Double
            public let totalProfit: Double
            
            public init(from decoder: Decoder) throws {
                let values = try decoder.container(keyedBy: CodingKeys.self)
                
                let pplnsProfitAsString = try values.decode(String.self, forKey: .pplnsProfit)
                let ppsProfitAsString = try values.decode(String.self, forKey: .ppsProfit)
                let soloProfitAsString = try values.decode(String.self, forKey: .soloProfit)
                let totalProfitAsString = try values.decode(String.self, forKey: .totalProfit)
                
                guard let pplnsProfit = Double(pplnsProfitAsString) else {
                    throw APIError.decodingError
                }
                
                guard let ppsProfit = Double(ppsProfitAsString) else {
                    throw APIError.decodingError
                }
                
                guard let soloProfit = Double(soloProfitAsString) else {
                    throw APIError.decodingError
                }
                
                guard let totalProfit = Double(totalProfitAsString) else {
                    throw APIError.decodingError
                }
                
                self.coin = try values.decode(String.self, forKey: .coin)
                self.pplnsProfit = pplnsProfit
                self.ppsProfit = ppsProfit
                self.soloProfit = soloProfit
                self.totalProfit = totalProfit
            }
        }
        
        public let code: Int
        public let data: Data
        public let message: String
    }
}
