//
//  UserData.swift
//  BlueVerseProject
//
//  Created by Nickelfox on 22/05/24.
//

import Foundation

struct UserData: Codable {
    let token: String
    let isKycDone: Bool
    let role: String
}
