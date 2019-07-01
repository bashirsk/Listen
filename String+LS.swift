//
//  String+LS.swift
//  Listen
//
//  Created by Bashir Sentongo on 01/07/2019.
//  Copyright © 2019 Bashir Sentongo. All rights reserved.
//

import Foundation

extension String {
    
    var ls_toSecureHTTPS: String {
        return self.contains("https") ? self :
        self.replacingOccurrences(of: "http", with: "https")
    }
}
