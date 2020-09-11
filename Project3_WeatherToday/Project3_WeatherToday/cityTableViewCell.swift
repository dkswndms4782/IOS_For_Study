//
//  cityTableViewCell.swift
//  Project3_WeatherToday
//
//  Created by 안유진 on 2020/08/06.
//  Copyright © 2020 Apple inc. All rights reserved.
//

import UIKit

class cityTableViewCell: UITableViewCell {

    //MARK: - properties
    @IBOutlet internal weak var weatherImageView: UIImageView?
    @IBOutlet internal weak var cityNameLabel: UILabel?
    @IBOutlet internal weak var celsiusLabel: UILabel?
    @IBOutlet internal weak var rainfallProbabilityLabel: UILabel?
    var cityWeather: String?
    
    //MARK: - methods
    override internal func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override internal func setSelected(_ selected: Bool,
                                       animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}
