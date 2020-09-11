//
//  ViewController.swift
//  Project3_WeatherToday
//
//  Created by 안유진 on 2020/08/06.
//  Copyright © 2020 Apple inc. All rights reserved.
//

import UIKit
import SwiftUI

class ViewController: UIViewController,UITableViewDataSource {

    //MARK: - properties
    @IBOutlet weak var tableView: UITableView?
    private let countryCellIdentifier: String = "countryCell"
    private var countries: [Country] = []
    
    //MARK: - tableViewDataSource
    internal func tableView(_ tableView: UITableView,
                            numberOfRowsInSection section: Int) -> Int {
        return countries.count
    }
    
    internal func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: countryTableViewCell
            = tableView.dequeueReusableCell(withIdentifier: countryCellIdentifier,
                                                                       for: indexPath) as! countryTableViewCell
        let country: Country = countries[indexPath.row]
        
        cell.countryNameLabel?.text = country.koreanName
        cell.flagImageView?.image = UIImage(named:"flag_" +  "\(country.assetName)")
        return cell
    }
    
    //MARK: - lifeCycle
    override internal func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let jsonDecoder = JSONDecoder()
        guard let countryDataAsset: NSDataAsset = NSDataAsset(name: "countries") else {
            return
        }
        
        do {
            countries = try jsonDecoder.decode([Country].self, from: countryDataAsset.data)
        } catch {
            print(error.localizedDescription)
            print(error)
        }
        
        self.tableView?.dataSource = self
        self.tableView?.reloadData()
    }
    
    // MARK: - Navigation
    override internal func prepare(for segue: UIStoryboardSegue,
                                   sender: Any?) {
        guard let nextViewController:
            SecondViewController = segue.destination
                as? SecondViewController else{
                return
        }
        guard let cell: countryTableViewCell = sender
            as? countryTableViewCell else{
            return
        }
        
        nextViewController.koreanName = cell.countryNameLabel?.text
        for country in countries {
            if country.koreanName == cell.countryNameLabel?.text {
                nextViewController.assetName = country.assetName
            }//countryTableViewCell에서 assetName변수 설정해 준 후 table함수에서 cellName이랑 설정해줄때 cell.assetName을 설정해주면 for문으로 일일이 찾지 않아도 됨.
            
        }
    }
}
