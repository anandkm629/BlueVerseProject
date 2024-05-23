//
//  URLSession.swift
//  BlueVerseProject
//
//  Created by Nickelfox on 22/05/24.
//
import Foundation


    public let email = "vaibhaw.anand+1@nickelfox.com"
    public let password = "Password@1"

public class UrlFetch {
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
                print(response!)
            } else {
                completion(.failure(NSError(domain: "No Data", code: 0, userInfo: nil)))
            }
        }
        
        task.resume()
    }
    //let email = "vaibhaw.anand+1@nickelfox.com"
    //let password = "Password@1"
    
    public func performLogin() {
        
        
        login(email: email, password: password) { result in
            switch result {
            case .success(let data):
                // Handle successful response data
                print("Response data: \(data)")
            case .failure(let error):
                // Handle error
                print("Error: \(error)")
            }
        }
    }
    
}
