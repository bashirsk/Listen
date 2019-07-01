//
//  LS+DateFormatter.swift
//  Listen
//
//  Created by Bashir Sentongo on 07/05/2019.
//  Copyright © 2019 Bashir Sentongo. All rights reserved.
//

import UIKit

extension Date {
    
    func ls_setDateFormat(date pDate: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM, yyyy"
        let date = dateFormatter.string(from: pDate)
        return date
    }
    
    var ls_setUpDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM, yyyy"
        return dateFormatter.string(from: self)
    }
}
