//
//  DateTools.swift
//  App
//
//  Created by Carlos Vicente on 22/01/2019.
//

import Foundation

struct DateTools {
    static func convertDateToAppDateFormat(_ date: Date) -> Date? {
        let resultDateFormatter = DateFormatter()
        resultDateFormatter.dateFormat = "dd-MM-yyyy HH:mm"
        resultDateFormatter.locale = Locale(identifier: "es")
        let dateString = resultDateFormatter.string(from: date)
        return resultDateFormatter.date(from: dateString)
    }
}
