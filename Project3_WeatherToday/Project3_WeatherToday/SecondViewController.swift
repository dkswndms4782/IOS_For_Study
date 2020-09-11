//
//  SecondViewController.swift
//  Project3_WeatherToday
//
//  Created by 안유진 on 2020/08/06.
//  Copyright © 2020 Apple inc. All rights reserved.
//

import UIKit
import Foundation

class SecondViewController: UIViewController,UITableViewDataSource{
    //MARK: - properties
    @IBOutlet weak var secondTableView: UITableView?
    private let cellIdentifier: String = "cityCell"
    internal var koreanName: String?
    internal var assetName: String?
    private var cities: [City] = []
    
    //MARK: - tableViewDataSource
    internal func tableView(_ tableView: UITableView,
                            numberOfRowsInSection section: Int) -> Int {
        return cities.count
    }
    
    internal func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: cityTableViewCell
            = tableView.dequeueReusableCell(withIdentifier: cellIdentifier,
                                                                    for: indexPath) as! cityTableViewCell
        let city: City = cities[indexPath.row]
        cell.cityNameLabel?.text = city.city_name
        cell.celsiusLabel?.text = "섭씨 " + "\(city.celsius)" + "도 / 화씨 " +
            "\(String(format: "%.1f",(city.celsius+40)*9/5-40))" + "도"
        //소수점 다루기. String(format: "%.3f",값)
        switch city.celsius {
        case(0...10):
            cell.celsiusLabel?.textColor = UIColor.systemBlue
        case(25...):
            cell.celsiusLabel?.textColor = UIColor.systemRed
        default:
            break
        }
        
        cell.rainfallProbabilityLabel?.text = "강수확률 " +
            "\(city.rainfall_probability)" + "%"
        switch city.rainfall_probability {
        case (60...):
            cell.rainfallProbabilityLabel?.textColor = UIColor.systemOrange
        default:
            break
        }
        
        switch city.state {
        case 10:
            cell.weatherImageView?.image = UIImage(named: "sunny")
            cell.cityWeather = "sunny"
        case 11:
            cell.weatherImageView?.image = UIImage(named: "cloudy")
            cell.cityWeather = "cloudy"
        case 12:
            cell.weatherImageView?.image = UIImage(named: "rainy")
            cell.cityWeather = "rainy"
        case 13:
            cell.weatherImageView?.image = UIImage(named: "snowy")
            cell.cityWeather = "snowy"
        default: break
        }
        
        return cell
    }

    //MARK: - lifeCycle
    override internal func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let jsonDecoder = JSONDecoder()
        guard let cityDataAsset = NSDataAsset(name: assetName!) else{
            return
        }
        
        do{
            cities = try jsonDecoder.decode([City].self,
                                            from: cityDataAsset.data)
        }catch{
            print(error.localizedDescription)
        }
        
        self.secondTableView?.dataSource = self
        self.secondTableView?.reloadData()
    }
    
    override internal func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.title = koreanName
    }

    // MARK: - Navigation
    override internal func prepare(for segue: UIStoryboardSegue,
                                   sender: Any?) {
        guard let nextViewController: ThirdViewController = segue.destination
                        as? ThirdViewController else{
                         return
                 }
        guard let cell: cityTableViewCell = sender
            as? cityTableViewCell else{
                     return
                 }
        
        nextViewController.setToCelsius = cell.celsiusLabel?.text
        nextViewController.setToRainfallProbability = cell.rainfallProbabilityLabel?.text
        nextViewController.setToWeatherName = cell.cityWeather
    }
}
