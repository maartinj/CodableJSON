//
//  StorageFunctions.swift
//  CTHelpSPMMaster
//
//  Created by Stewart Lynch on 2019-06-28.
//  Copyright © 2019 CreaTECH Solutions. All rights reserved.
//

import Foundation

class StorageFunctions {
    static let backupURL = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!.appendingPathComponent("backup.json")
    static let bundleURL = Bundle.main.url(forResource: "Seed", withExtension: "json")
    
    static func retrieveBooks() -> [BookItem] {
         var url = backupURL
        if !FileManager().fileExists(atPath: backupURL.path) {
            url = bundleURL!
        }
        let decoder = JSONDecoder()
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Unable to decode data")
        }
        guard let bookItems = try? decoder.decode([BookItem].self, from: data) else {
            fatalError("Failed to decode JSON from data")
        }
        return bookItems
    }
    
    
    static func storeBooks(books:[BookItem]) {
        let encoder = JSONEncoder()
        guard let bookJSONData = try? encoder.encode(books) else {
            fatalError("Could not encode data")
        }
        let bookJSON = String(data: bookJSONData, encoding: .utf8)!
        do {
            try bookJSON.write(to: backupURL, atomically: true, encoding: .utf8)
        } catch {
            print("Could not save file to directory: \(error.localizedDescription)")
        }
    }
}
