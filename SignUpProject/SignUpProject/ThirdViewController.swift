//
//  ThirdViewController.swift
//  SignUpProject
//
//  Created by 이서영 on 2022/01/12.
//

import UIKit

class ThirdViewController: UIViewController, UITextFieldDelegate {
    // MARK: - UI Components
    @IBOutlet weak var phoneField: UITextField?
    @IBOutlet weak var birthLabel: UILabel?
    @IBOutlet weak var birthPicker: UIDatePicker?
    @IBOutlet weak var cancelBtn: UIButton?
    @IBOutlet weak var prevBtn: UIButton?
    @IBOutlet weak var signUpBtn: UIButton?
    let dateFormatter: DateFormatter = {
        let formatter: DateFormatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeZone = TimeZone(identifier: "UTC")
        return formatter
    }()
    
    // MARK: - IBAction
    @IBAction func tapView(_ sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    
    @IBAction func didDatePickerChanged(_ sender: UIDatePicker) {
        let date: Date = sender.date
        let dateString: String = self.dateFormatter.string(from: date)
        self.birthLabel?.text = dateString
        setSignUpBtnState()
    }
    
    @IBAction func pressCancelButton(_ sender: UIButton) {
        self.phoneField?.text = ""
        self.birthLabel?.text = ""
    }
    
    @IBAction func pressPrevButton(_ sender: UIButton) {
        saveUserInformation()
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func pressSignUpButton(_ sender: UIButton) {
        saveUserInformation()
        self.dismiss(animated: true, completion: nil)
    }
    // MARK: - Load View
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.phoneField?.text = UserInformation.shared.phone
        self.birthPicker?.date = convertStringToDate(UserInformation.shared.birth)
        self.birthLabel?.text = UserInformation.shared.birth
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setDelegate()
    }
    
    // MARK: - Methods
    func setDelegate() {
        self.phoneField?.delegate = self
    }
    
    func setSignUpBtnState() {
        if let phone = self.phoneField?.text, let birth = self.birthLabel?.text {
            if !phone.isEmpty && birth != "Label" {
                self.signUpBtn?.isEnabled = true
            } else {
                self.signUpBtn?.isEnabled = false
            }
        } else {
            self.signUpBtn?.isEnabled = false
        }
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        setSignUpBtnState()
        print("textfield")
    }
    
    func convertStringToDate(_ date: String?) -> Date {
        var dateData: Date = Date()
        if let dateString: String = date {
            if dateString != "Label" {
                dateData = dateFormatter.date(from: dateString)!
            }
        }
        return dateData
    }
    
    func saveUserInformation() {
        UserInformation.shared.phone = self.phoneField?.text
        UserInformation.shared.birth = self.birthLabel?.text
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
