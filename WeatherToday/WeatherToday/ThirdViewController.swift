//
//  ThirdViewController.swift
//  WeatherToday
//
//  Created by 이서영 on 2022/01/24.
//

import UIKit

class ThirdViewController: UIViewController {
    // MARK: - Properties
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var weatherLabel: UILabel!
    @IBOutlet weak var degreeLabel: UILabel!
    @IBOutlet weak var rainfallLabel: UILabel!
    var weatherImageData: UIImage?
    var weatherLabelData: String?
    var degreeLabelData: String?
    var rainfallLabelData: String?
    

    // MARK: - Load View
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setData()
    }
    
    // MARK: - Methods
    func setData() {
        guard let weather = weatherImageData, let weatherText = weatherLabelData, let degreeText = degreeLabelData, let rainfallText = rainfallLabelData else {
            return
        }
        weatherImage.image = weather
        weatherLabel.text = weatherText
        degreeLabel.text = degreeText
        rainfallLabel.text = rainfallText
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
