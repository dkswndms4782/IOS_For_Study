//
//  countryTableViewCell.swift
//  Project3_WeatherToday
//
//  Created by 안유진 on 2020/08/06.
//  Copyright © 2020 Apple inc. All rights reserved.
//

import UIKit

class countryTableViewCell: UITableViewCell {

    //MARK: - properties
    @IBOutlet internal weak var flagImageView: UIImageView?
    @IBOutlet internal weak var countryNameLabel: UILabel?
    
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
