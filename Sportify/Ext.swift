//
//  Ext.swift
//  Sportify
//
//  Created by Febrian Daniel on 13/04/24.
//

import Foundation
import SwiftUI
import MapKit
import Contacts

extension Date.FormatStyle {
    func withTimeZone(_ timeZone: TimeZone) -> Date.FormatStyle {
        var copy = self
        copy.timeZone = timeZone
        return copy
    }
}

extension Date {
    var onlyDate: Date? {
        get {
            let calender = Calendar.current
            var dateComponents = calender.dateComponents([.year, .month, .day], from: self)
            dateComponents.timeZone = NSTimeZone.system
            return calender.date(from: dateComponents)
        }
    }
    
    var onlyTime: Date? {
        get {
            let calender = Calendar.current
            var timeComponents = calender.dateComponents([.hour, .minute], from: self)
            timeComponents.timeZone = NSTimeZone.system
            return calender.date(from: timeComponents)
        }
    }
    
    func getDateFormatted(timeStyle: DateFormatter.Style, dateStyle: DateFormatter.Style) -> String {
        let formatter = DateFormatter()
        formatter.timeStyle = timeStyle
        formatter.dateStyle = dateStyle
        formatter.timeZone = TimeZone.current
        
        return formatter.string(from: self)
    }
}

extension MKPlacemark {
    var formattedAddress: String? {
        guard let postalAddress = postalAddress else { return nil }
        return CNPostalAddressFormatter.string(from: postalAddress, style: .mailingAddress).replacingOccurrences(of: "\n", with: ", ")
    }
}
