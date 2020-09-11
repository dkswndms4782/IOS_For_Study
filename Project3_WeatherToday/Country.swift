//
//  Country.swift
//  Project3_WeatherToday
//
//  Created by 안유진 on 2020/08/06.
//  Copyright © 2020 Apple inc. All rights reserved.
//

import Foundation

struct Country: Codable {
    let koreanName: String
    let assetName: String
    
    enum CodingKeys:String, CodingKey {
        case koreanName = "korean_name"
        case assetName = "asset_name"
    }
}
