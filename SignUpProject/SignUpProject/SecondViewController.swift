//
//  SecondViewController.swift
//  SignUpProject
//
//  Created by 이서영 on 2022/01/12.
//

import UIKit

class SecondViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate, UITextViewDelegate {
    
    // MARK: - UI Components
    lazy var imagePicker: UIImagePickerController = {
        let picker: UIImagePickerController = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        picker.delegate = self
        return picker
    }()
    
    @IBOutlet weak var idField: UITextField?
    @IBOutlet weak var pwField: UITextField?
    @IBOutlet weak var pwCheckField: UITextField?
    @IBOutlet weak var introText: UITextView?
    @IBOutlet weak var imageView: UIImageView?
    @IBOutlet weak var cancelBtn: UIButton?
    @IBOutlet weak var nextBtn: UIButton?
    
    // MARK: - Action Methods
    @IBAction func tapView(_ sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    
    @objc func pressImageView(_ sender: UIGestureRecognizer) {
        self.present(self.imagePicker, animated: true, completion: nil)
        print("press ImageView")
    }
    
    @IBAction func pressCancelButton() {
        // 화면 왼쪽 하단의 '취소' 버튼을 누르면 모든 정보가 지워지고 이전 화면1로 되돌아갑니다.
        self.idField?.text = ""
        self.pwField?.text = ""
        self.pwCheckField?.text = ""
        self.introText?.text = ""
        self.imageView?.image = nil
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func pressNextButton() {
        saveUserInformation()
    }
    
    // 사용자가 모든 정보를 기입한 상태가 아니라면 화면 오른쪽 하단의 '다음' 버튼은 기본적으로 비활성화되어있으며, 프로필 이미지, 아이디, 자기소개가 모두 채워지고, 패스워드가 일치하면 '다음' 버튼이 활성화됩니다.

    // MARK: - View
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setDelegate()
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(pressImageView(_:)))
        self.imageView?.addGestureRecognizer(tapRecognizer)
    }
    
    // MARK: - Methods
    func setDelegate() {
        self.nextBtn?.isEnabled = false
        self.idField?.delegate = self
        self.pwField?.delegate = self
        self.pwCheckField?.delegate = self
        self.introText?.delegate = self
    }
    
    func setNextBtnState() {
        if let id = self.idField?.text, let pw = self.pwField?.text, let pwCheck = self.pwCheckField?.text, let intro = self.introText?.text, let image = self.imageView?.image {
            if !id.isEmpty && !pw.isEmpty && pw == pwCheck && !intro.isEmpty {
                self.nextBtn?.isEnabled = true
            } else {
                self.nextBtn?.isEnabled = false
            }
        } else {
            self.nextBtn?.isEnabled = false
        }
    }
    func textFieldDidChangeSelection(_ textField: UITextField) {
        setNextBtnState()
        print("textfield")
    }
    
    func textViewDidChangeSelection(_ textView: UITextView) {
        setNextBtnState()
        print("textview")
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let originalImage: UIImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            self.imageView?.image = originalImage
        }
        setNextBtnState()
        self.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        setNextBtnState()
        self.dismiss(animated: true, completion: nil)
    }
    
    func saveUserInformation() {
        UserInformation.shared.id = self.idField?.text
        UserInformation.shared.password = self.pwField?.text
        UserInformation.shared.introduce = self.introText?.text
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
