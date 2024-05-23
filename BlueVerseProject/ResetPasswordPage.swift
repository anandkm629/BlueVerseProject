//
//  ResetPasswordPage.swift
//  BlueVerseProject
//
//  Created by Nickelfox on 15/05/24.
//

import Foundation
import UIKit

class ResetPasswordPage : UIViewController , UITextFieldDelegate {
    
    
    @IBOutlet weak var blueVerseLogo: UIImageView!
    
    @IBOutlet weak var newPasswordLabel: UILabel!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var reEnterPasswd: UITextField!
    
    @IBOutlet weak var resetbtn: UIButton!
    @IBOutlet weak var passTypeLabel: UILabel!
    @IBOutlet weak var enterPasswd: UITextField!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var resetPasswd: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        enterPasswd.delegate = self
        reEnterPasswd.delegate = self
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
    
    @IBAction func resetPassword(_ sender: UIButton) {
        guard let password = enterPasswd.text,
              let reenteredPassword = reEnterPasswd.text else {
            return
        }
        if password != reenteredPassword {
            // Display an alert indicating that passwords do not match
            showAlert(title: "Password Mismatch", message: "The passwords you entered do not match. Please try again.")
            return
        }
    }
 
// MARK: Alert function
    
    func showAlert(title: String, message: String) {
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(okAction)
            present(alertController, animated: true, completion: nil)
        }

    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            textField.resignFirstResponder()
            return false
        }
}
