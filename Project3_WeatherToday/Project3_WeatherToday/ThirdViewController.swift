//
//  ThirdViewController.swift
//  Project3_WeatherToday
//
//  Created by 안유진 on 2020/08/06.
//  Copyright © 2020 Apple inc. All rights reserved.
//

import UIKit

class ThirdViewController: UIViewController {

    //MARK: - properties
    @IBOutlet private weak var weatherImageView: UIImageView?
    @IBOutlet private weak var weatherNameLabel: UILabel?
    @IBOutlet private weak var celsiusLabel: UILabel?
    @IBOutlet private weak var rainfallProbabilityLabel: UILabel?
    internal var setToCelsius: String?
    internal var setToRainfallProbability: String?
    internal var setToWeatherName: String?
    
    //MARK: - lifeCycle
    override internal func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override internal func viewWillAppear(_ animated: Bool){
        super.viewWillAppear(animated)
        celsiusLabel?.text = setToCelsius
        rainfallProbabilityLabel?.text = setToRainfallProbability
        switch setToWeatherName{
        case "sunny":
            weatherNameLabel?.text = "해"
            weatherImageView?.image = UIImage(named: "sunny")
        case "cloudy":
            weatherNameLabel?.text = "구름"
            weatherImageView?.image = UIImage(named: "cloudy")
        case "rainy":
            weatherNameLabel?.text = "비"
            weatherImageView?.image = UIImage(named: "rainy")
        case "snowy":
            weatherNameLabel?.text = "눈"
            weatherImageView?.image = UIImage(named: "snowy")
        default:
            break
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
