//
//  UIImageView+LS.swift
//  Listen
//
//  Created by Bashir Sentongo on 02/07/2019.
//  Copyright © 2019 Bashir Sentongo. All rights reserved.
//


import UIKit
import SDWebImage

extension UIImageView {
    
    func ls_downloadAndCacheImage(with pUrl: String) {
        if let url = URL(string: pUrl) {
            sd_setImage(with: url, completed: nil)
        }
    }
}
