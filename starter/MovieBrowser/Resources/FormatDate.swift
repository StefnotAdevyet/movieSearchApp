//
//  FormatDate.swift
//  MovieBrowser
//
//  Created by developer on 6/13/22.
//  Copyright © 2022 Lowe's Home Improvement. All rights reserved.
//

import Foundation

extension DateFormatter {
    static let posixFormatter : DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter
    }()
}
