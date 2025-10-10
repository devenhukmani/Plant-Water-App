//
//  JSON_Handling.swift
//  Plant Water App
//
//  Created by Deven H on 10/10/25.
//

import Foundation

var fileContent: String = ""

func jsonFileToData(filename: String) -> Data? {
    // 1. Locate the JSON file in the main bundle
    
    guard let url = Bundle.main.url(forResource: filename, withExtension: "json") else {
            fatalError("Failed to locate " + filename + ".json in bundle.")
    }
    guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load " + filename + ".json from bundle.")
        }

    return data
}

func jsonFileToStruct(filename: String) -> Decodable{
    let jsonData = jsonFileToData(filename: filename)
    do {
        let decoder = JSONDecoder()
        let decoded = try decoder.decode(dataStruct.self, from: jsonData!)
        return decoded
    }catch{
        print("Error decoding JSON: \(error)")
    }
    return "error" as Decodable
}

func jsonStringToData(jsonString: String) -> Data? {
    guard let data = jsonString.data(using: .utf8) else {
        print("Error: Could not convert JSON string to data with UTF-8 encoding.")
        return nil
    }
    return data
}

struct dataStruct: Decodable {
    let name: String
    let age: Int
    let isStudent: Bool
    let courses: String
}
