//
//  String+Extension.swift
//  Weather-SwiftUI
//
//  Created by Apple on 28/12/2020.
//

import Foundation
extension String {
    var removeWhiteSpace: String {
       return self.replacingOccurrences(of: " ", with: "")
    }
    
    var formattedDate: String {
        var dateAsString = String(self.components(separatedBy: "GMT").first ?? "")
        dateAsString = dateAsString.replacingOccurrences(of: "PM", with: "")
        dateAsString = dateAsString.replacingOccurrences(of: "AM", with: "")
        return self.removeWhiteSpace
    }
    
    var hour: String {
        let formatted = self.components(separatedBy: ":")
        return formatted.first ?? ""
    }
}
