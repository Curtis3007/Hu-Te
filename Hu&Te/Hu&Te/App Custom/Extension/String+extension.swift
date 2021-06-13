//
//  String+extension.swift
//  Hu&Te
//
//  Created by BigSur on 03/06/2021.
//

import Foundation

extension String {
    func toJSON() -> Any? {
        guard let data = self.data(using: .utf8, allowLossyConversion: false) else { return nil }
        return try? JSONSerialization.jsonObject(with: data, options: .mutableContainers)
    }
    
    func convertToDate() -> Date {
        let dateFormatter = DateFormatter()
        //dateFormatter.locale = Locale(identifier: "UTC+08:00") // set locale to reliable US_POSIX
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        return dateFormatter.date(from: self) ?? Date()
    }
}
