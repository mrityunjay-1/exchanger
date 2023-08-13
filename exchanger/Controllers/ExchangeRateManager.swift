//
//  ExchangeRateManager.swift
//  exchanger
//
//  Created by Mrityunjay Kumar on 13/08/23.
//

import Foundation

protocol ExchangeRateDelegate {
    func getExchangeRateData (data: ExchangeRateModel)
}

class ExchangeRateManager {
    
    var delegate: ExchangeRateDelegate?
    
    func getExchangeRate (selectedCurrency: String) {
        if let url = URL(string: "https://rest.coinapi.io/v1/exchangerate/BTC/\(selectedCurrency)?apikey=3DCDE12A-D170-4395-A53F-335A9D639818") {
            
            let urlSession = URLSession(configuration: .default)
            
            let task = urlSession.dataTask(with: url) { ( data: Data?, response: URLResponse?, error: Error?) in
                
                if error != nil {
                    print(error!)
                    return;
                }
                
                if let safeData = data {
                    print(String(data: safeData, encoding: .utf8)!)
                    self.parseData(data: safeData)
                }
                
            }
            
            task.resume()
        }
    }
    
    func parseData(data: Data) {
        do {
            let decoder = JSONDecoder()
            let workableData = try decoder.decode(ExchangeRateModel.self, from: data)
            print(workableData.rate)
            
            self.delegate?.getExchangeRateData(data: workableData)
            
        } catch {
            print(error)
        }
    }
}
