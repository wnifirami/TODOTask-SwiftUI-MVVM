//
//  BundleExtension.swift
//  TODO-MVVM
//
//  Created by Rami Ounifi on 15/2/2022.
//

import Foundation

extension Bundle {
     func encode<T>(_ value: T?) throws -> Data? where T : Codable {
        guard let object = value else {
            debugPrint("can't encode")
           return nil }
        do {
            let jsonEncoder = JSONEncoder()
            return try jsonEncoder.encode(object.self)
            
        } catch let error {
            debugPrint("can't encode", error)
            return nil
        }
    }
    
    func decode<T: Codable>(_ data: String?) -> T {
        /// steps:

        guard let data = data?.data(using: .utf8) else {
            fatalError("uncorrect data")
        }
        // 3 - Create a decoder
        let decoder = JSONDecoder()
        // 4 - Create proprty from decoder data
        guard let loaded = try? decoder.decode(T.self, from: data) else {
            fatalError("can't decode data")
        }
        // 5 - Return the ready to use data
        return loaded
    }
}
