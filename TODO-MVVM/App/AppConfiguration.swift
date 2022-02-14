//
//  APPCONFIGURATION.swift
//  TODO-MVVM
//
//  Created by Rami Ounifi on 14/2/2022.
//

import Foundation
 struct AppConfiguration {
    static let baseUrl: String = {
        guard let baseUrl = Bundle.main.object(forInfoDictionaryKey: "ApiBaseURL") as? String else {
            fatalError("url must not be empty in plist")
        }
        return baseUrl
    }()
}
