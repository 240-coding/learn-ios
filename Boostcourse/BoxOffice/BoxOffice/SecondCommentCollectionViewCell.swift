//
//  SecondCommentCollectionViewCell.swift
//  BoxOffice
//
//  Created by 이서영 on 2022/02/20.
//

import UIKit

class SecondCommentCollectionViewCell: UICollectionViewCell {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    @IBOutlet var nicknameTextField: UITextField!
    @IBOutlet var commentTextView: UITextView!
    @IBOutlet var commentPlaceholder: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setTextView()
        nicknameTextField.text = appDelegate.username
    }
    
    func setTextView() {
        self.commentTextView.layer.borderWidth = 1
        self.commentTextView.layer.borderColor = UIColor.orange.cgColor
        self.commentTextView.layer.cornerRadius = 5
    }
}

extension SecondCommentCollectionViewCell: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        self.commentPlaceholder.isHidden = !textView.text.isEmpty
    }
}
