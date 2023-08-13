//
//  ExchangeModel.swift
//  exchanger
//
//  Created by Mrityunjay Kumar on 13/08/23.
//

import Foundation

class ExchangeRateModel: Codable {
    var time: String
    var asset_id_base: String
    var asset_id_quote: String
    var rate: Double
}
