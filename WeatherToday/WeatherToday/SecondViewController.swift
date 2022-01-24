//
//  SecondViewController.swift
//  WeatherToday
//
//  Created by 이서영 on 2022/01/24.
//

import UIKit

class SecondViewController: UIViewController, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    var country: String?
    let cellIdeitifier: String = "CityCell"
    var cities: [City] = []
    // MARK: - Load View
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        decodeJSON()
        self.tableView.reloadData()
    }
    
    // MARK: - Methods
    func decodeJSON() {
        let jsonDecoder: JSONDecoder = JSONDecoder()
        guard let countryCode = country else {
            return
        }
        guard let dataAsset: NSDataAsset = NSDataAsset(name: countryCode) else {
            return
        }
        do {
            self.cities = try jsonDecoder.decode([City].self, from: dataAsset.data)
        } catch {
            print(error.localizedDescription)
        }
    }
    // MARK: - Methods for DataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: CityTableViewCell = tableView.dequeueReusableCell(withIdentifier: cellIdeitifier, for: indexPath) as? CityTableViewCell else {
            preconditionFailure("셀 가져오기 실패")
        }
        let city: City = cities[indexPath.row]
        cell.weatherImage.image = UIImage(named: city.weatherImage)
        cell.nameLabel.text = city.name
        cell.degreeLabel.text = city.degreeText
        cell.rainfallLabel.text = city.rainfallText
        
        return cell
    }

}
