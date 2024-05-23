//
//  LoginEntity.swift
//  BlueVerseProject
//
//  Created by Nickelfox on 22/05/24.
//

import Foundation
import UIKit

import Foundation

struct UserResponse: Codable {
    let code: Int
    let status: Int
    let message: String
    let error: Bool
    let data: UserData
}

struct UserData: Codable {
    let user: User
}

struct User: Codable {
    let token: String
    let isKycDone: Bool
    let role: String
}

