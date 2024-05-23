//
//  UserVerificationPage.swift
//  BlueVerseProject
//
//  Created by Nickelfox on 14/05/24.
//

import Foundation
import UIKit

class UserVerificationPage: UIViewController , UITextFieldDelegate {
    
    @IBOutlet weak var blueVerseLogo: UIImageView!
    
    @IBOutlet weak var userVerificationLabel: UILabel!
    
    @IBOutlet weak var otpSentLabel: UILabel!
    @IBOutlet weak var mainView: UIView!
    
    
    @IBOutlet weak var resendBtn: UIButton!
    
    @IBOutlet weak var otpInputField: UITextField!
    
    @IBOutlet weak var confirmBtn: UIButton!
    
    @IBOutlet weak var backBtn: UIButton!
    
    let correct_Otp="123456"
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureUI()
        otpInputField.delegate = self
        mainView.layer.cornerRadius = 12
        mainView.layer.masksToBounds = true
    }
    
    @IBAction func verifyOTP(_ sender: UIButton) {
           guard let enteredOTP = otpInputField.text else {
               showAlert(title: "Error", message: "Please enter the OTP.")
               return
           }

           if enteredOTP == correct_Otp {
               showAlert(title: "Success", message: "OTP is correct.")
           } else {
               showAlert(title: "Error", message: "Incorrect OTP. Please try again.")
           }
       }
  
// MARK: Alert function
    
    func showAlert(title: String, message: String) {
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(okAction)
            present(alertController, animated: true, completion: nil)
        }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if let otp = otpInputField.text , !otp.isEmpty {
            confirmBtn.backgroundColor = UIColor(red: 31/255, green: 89/255, blue: 175/255, alpha: 1)
            confirmBtn.isEnabled = true
        }else {
            confirmBtn.backgroundColor = UIColor(red: 179/255, green: 187/255, blue: 199/255, alpha: 1)
            
        }
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            textField.resignFirstResponder()
            return false
        }
    func configureUI() {
        confirmBtn.layer.cornerRadius = 8
    }
}
