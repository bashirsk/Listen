//
//  LS+UIImageView.swift
//  Listen
//
//  Created by Bashir Sentongo on 15/04/2019.
//  Copyright © 2019 Bashir Sentongo. All rights reserved.
//

import UIKit
import SDWebImage

extension UIImageView {
    
    func ls_downloadAndCacheImage(with pUrl: String) {
        if let url = URL(string: pUrl) {
            self.sd_setImage(with: url, completed: nil)
        }
    }
}
