//
//  ViewController.swift
//  BlueVerseProject
//
//  Created by Nickelfox on 14/05/24.
//

import UIKit

class ViewController: UIViewController , UITextFieldDelegate {
    
    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var credentialsLabel: UIView!
    @IBOutlet weak var blueVerseLogo: UIImageView!
    @IBOutlet weak var emailId: UITextField!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var passwd: UITextField!
    @IBOutlet weak var eyeONOffImg: UIButton!
    @IBOutlet weak var checkBox: UIButton!
    @IBOutlet weak var forgetbtn: UIButton!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    
    var isChechBoxToggle = false
    
    
    //    public let email = "vaibhaw.anand+1@nickelfox.com"
    //    public let password = "Password@1"
    
    weak var activeField: UITextField?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailId.delegate = self
        passwd.delegate = self
        self.hidePasswordButtonConfig()
        
        // MARK: CheckBox Functionality added
        
        checkBox.setImage(UIImage(named: "emptyCheckBox"), for: .normal)
        checkBox.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
        
        
        
        
        // MARK: Handle the keyboard
        
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.keyboardDidShow),
                                               name: UIResponder.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.keyboardWillBeHidden),
                                               name: UIResponder.keyboardWillHideNotification, object: nil)
        
        emailId.keyboardType = .default
        passwd.keyboardType = .default
        contentView.layer.cornerRadius = 8
        loginBtn.layer.cornerRadius = 10
        loginBtn.backgroundColor = UIColor(red: 179/255, green: 187/255, blue: 199/255, alpha: 1.0)
        loginBtn.setTitleColor(UIColor.white, for: .normal)
        scrollView.backgroundColor = UIColor(red: 245/255, green: 241/255, blue: 237/255, alpha: 1.0)
        
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: UITextfield Delegates
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == emailId {
            if let email = emailId.text, !email.isEmpty, email.isValidEmail {
                emailId.layer.borderColor = UIColor(red: 201/255, green: 216/255, blue: 239/255, alpha: 1).cgColor
                print("Valid email")
                emailId.layer.borderWidth = 0
            } else {
                emailId.layer.borderColor = UIColor(red: 255/255, green: 64/255, blue: 73/255, alpha: 1).cgColor
                print("Invalid email")
                emailId.layer.borderWidth = 1.0
            }
        }
    }

    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        activeField = textField
    }
    
    @objc func keyboardDidShow(notification: Notification) {
        let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue
        guard let activeField = activeField, let keyboardHeight = keyboardSize?.height else { return }
        
        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: keyboardHeight, right: 0.0)
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
        let activeRect = activeField.convert(activeField.bounds, to: scrollView)
        scrollView.scrollRectToVisible(activeRect, animated: true)
    }
    
    @objc func keyboardWillBeHidden(notification: Notification) {
        let contentInsets = UIEdgeInsets.zero
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
    }
    
    // MARK: Checkbox Functionality
    @objc func buttonClicked() {
        // Change the image of the button when it's clicked
        if isChechBoxToggle {
            
            checkBox.setImage(UIImage(named: "checkImg"), for: .normal)
            isChechBoxToggle.toggle()
        }
        else{
            checkBox.setImage(UIImage(named: "emptyCheckBox"), for: .normal)
            isChechBoxToggle.toggle()
        }
        
        
        
    }
    // MARK: Password visible and hidden
    
    func hidePasswordButtonConfig() {
        self.eyeONOffImg.setImage(UIImage(named: "hideEyeIcon"), for: .normal)
        self.eyeONOffImg.addTarget(self, action: #selector(hidePasswordButton), for: .touchUpInside)
    }
    @objc func hidePasswordButton() {
        passwd.isSecureTextEntry.toggle()
        let imageName = passwd.isSecureTextEntry ? "EyeOff" : "EyeOn"
        eyeONOffImg.setImage(UIImage(named: imageName), for: .normal)
        
    }
    
    @IBAction func checkMarkTapped(_ sender: UIButton) {
        // if sender.isSelected =!sender.isSelected
    }
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if let email = emailId.text, let password = passwd.text,
           (!email.isEmpty && !password.isEmpty ) {
            loginBtn.backgroundColor = UIColor(red: 31/255, green: 89/255, blue: 175/255, alpha: 1.0)
            loginBtn.isEnabled = true
            loginBtn.setTitleColor(UIColor.white, for: .normal)
        } else {
            loginBtn.backgroundColor = UIColor(red: 179/255, green: 187/255, blue: 199/255, alpha: 1.0)
            //loginBtn.isEnabled = false
            //loginBtn.setTitleColor(UIColor.white, for: .normal)
        }
    }
    
    
    
    
}

// MARK: Store the text textField Values

var enterEmail: String = ""
var enterPass: String = ""




// MARK: API Call

extension ViewController {
    struct LoginRequest: Codable {
        let email: String
        let password: String
        let app: String
    }
    
    func login(email: String, password: String, completion: @escaping (Result<Data, Error>) -> Void) {
        let urlString = "https://api.dev.blueverse.foxlabs.in/api/v1/user/authenticate"
        
        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        let loginData = LoginRequest(email: email, password: password, app: "DEALER")
        
        do {
            request.httpBody = try JSONEncoder().encode(loginData)
        } catch {
            completion(.failure(error))
            return
        }
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse, !(200...299).contains(httpResponse.statusCode) {
                let statusCode = httpResponse.statusCode
                completion(.failure(NSError(domain: "HTTP Error", code: statusCode, userInfo: nil)))
                return
            }
            
            if let data = data {
                completion(.success(data))
            } else {
                completion(.failure(NSError(domain: "No Data", code: 0, userInfo: nil)))
            }
        }
        
        task.resume()
    }
    
    func performLogin() {
        let email = enterEmail
        let password = enterPass
        print(email, password)
        login(email: email, password: password) { result in
            switch result {
            case .success(let data):
                do {
                    let userResponse = try JSONDecoder().decode(UserResponse.self, from: data)
                    let token = userResponse.data.user.token
                    
                    
                    DispatchQueue.main.async {
                        // Perform UI updates on the main thread
                        self.showAlert1(title: "Success", message: "Logged In", okHandler: {
                            self.navigateToWallet()
                        })
                        
                        
                    }
                    
                    print("Auth Token: \(token)")
                } catch {
                    print("Error decoding JSON: \(error)")
                }
            case .failure(let error):
                
                DispatchQueue.main.async {
                    self.showAlert2(title: "Login Failed", message: "Incorrect credentials")
                }
                
                print("Error: \(error)")
                
            }
        }
    }
    
    // MARK: Alert function
    
    
    func showAlert1(title: String, message: String, okHandler: (() -> Void)?) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            // Call the okHandler closure when the "OK" button is tapped
            okHandler?()
        }
        alertController.addAction(okAction)
        
        // Make sure to present the alert from a view controller
        // Assuming this function is called from a UIViewController subclass
        present(alertController, animated: true, completion: nil)
    }
    
    
    func showAlert2(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    
    // MARK: Login Tap Functionality
    
    @IBAction func loginTapped(_ sender: UIButton) {
        
        enterEmail = emailId.text ?? ""
        enterPass = passwd.text ?? ""
        
        
        self.performLogin()
        
    }
    
    // MARK: Navigation to Wallet
    
    func navigateToWallet() {
        if let vc = UIStoryboard.init(name: "Wallet", bundle: Bundle.main).instantiateViewController(withIdentifier: "WalletViewController") as? WalletViewController {
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
    }
}

extension String {
    
    public var isValidEmail: Bool {
        if !isEmpty {
            let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
            let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegex)
            return emailTest.evaluate(with: self)
        }
        return false
    }

}
