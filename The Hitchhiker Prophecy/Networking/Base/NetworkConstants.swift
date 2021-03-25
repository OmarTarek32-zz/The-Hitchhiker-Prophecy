//
//  NetworkConstants.swift
//  The Hitchhiker Prophecy
//
//  Created by Mohamed Matloub on 6/10/20.
//  Copyright © 2020 SWVL. All rights reserved.
//

import Foundation

enum NetworkConstants {
    // TODO: Add the API keys with CocoaPods Keys
    static let baseUrl = "https://gateway.marvel.com"
    static let publicKey = "0ff3b430b26be667084c985ff952af5e"
    static let privateKey = "208dddb9fd1bde96138a9cc333bf2514f4bdac60"
    static let timeStamp = String(Date().timeIntervalSince1970)
    static let apiHash = (timeStamp+privateKey+publicKey).MD5HashValue
}
