//
//  ForgotPasswordPage.swift
//  BlueVerseProject
//
//  Created by Nickelfox on 14/05/24.
//

import Foundation
import UIKit

class ForgotPasswordPage: UIViewController , UITextViewDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var BlueVerselogo: UIImageView!
    @IBOutlet weak var resetPasswordLabl: UILabel!
    @IBOutlet weak var registerEmail: UITextField!
    
    @IBOutlet weak var privacyLabel: UILabel!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var btn: UIButton!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var forgetPassLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        registerEmail.delegate = self
        mainView.layer.cornerRadius = 12
        mainView.layer.masksToBounds = true
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(backArrowTapped))
        backBtn.addGestureRecognizer(tapGesture)
        backBtn.isUserInteractionEnabled = true

    }
    
    @objc func backArrowTapped() {
        self.navigationController?.popViewController(animated: true)
        self.dismiss(animated: true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            textField.resignFirstResponder()
            return false
        }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        let newViewController = ViewController()
        present(newViewController, animated: true, completion: nil)
    }

    
//    @IBAction func showKeyboard(_ sender : UIButton ) {
//        self.registerEmail.becomeFirstResponder()
//    }
//    @IBAction func hideKeyboard(_ sender : UIButton ){
//        self.registerEmail.resignFirstResponder()
//    }
}
