//
//  StringExtension.swift
//  The Hitchhiker Prophecy
//
//  Created by Omar Tarek on 3/22/21.
//  Copyright © 2021 SWVL. All rights reserved.
//

import Foundation
import CryptoKit

extension String {
    
    var MD5HashValue: String {
        let computed = Insecure.MD5.hash(data: self.data(using: .utf8)!)
        return computed.map { String(format: "%02hhx", $0) }.joined()
    }
}
