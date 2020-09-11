//
//  City.swift
//  Project3_WeatherToday
//
//  Created by 안유진 on 2020/08/06.
//  Copyright © 2020 Apple inc. All rights reserved.
//

import Foundation

struct City: Codable {
    let city_name: String
    let state: Int
    let celsius: Float
    let rainfall_probability: Int
}
