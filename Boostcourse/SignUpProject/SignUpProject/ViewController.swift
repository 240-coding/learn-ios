//
//  ViewController.swift
//  SignUpProject
//
//  Created by 이서영 on 2022/01/12.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var idField: UITextField?
    
    @IBAction func tapView(_ sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.idField?.text = UserInformation.shared.id
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

}

