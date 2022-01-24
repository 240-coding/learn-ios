//
//  ViewController.swift
//  WeatherToday
//
//  Created by 이서영 on 2022/01/21.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource {
    // MARK: - Properties
    @IBOutlet weak var tableView: UITableView!
    let cellIdentifier: String = "CountryCell"
    var countries: [Country] = []
    // MARK: - Load View
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let jsonDecoder: JSONDecoder = JSONDecoder()
        guard let dataAsset: NSDataAsset = NSDataAsset(name: "countries") else {
            return
        }
        
        do {
            self.countries = try jsonDecoder.decode([Country].self, from: dataAsset.data)
        } catch {
            print(error.localizedDescription)
        }
        
        self.tableView.reloadData()
    }

    // MARK: - UITableView Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.countries.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: CountryTableViewCell = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifier, for: indexPath) as? CountryTableViewCell else {
            preconditionFailure("테이블 뷰 가져오기 실패")
        }
        let country: Country = self.countries[indexPath.row]
        cell.countryImage?.image = UIImage(named: country.imageName)
        cell.nameLabel?.text = country.name
        
        return cell
    }

}

