//
//  JSON_Handling.swift
//  Plant Water App
//
//  Created by Deven H on 10/10/25.
//

import Foundation

var fileContent: String = ""

func jsonFileToData(filename: String) -> Data? {
    guard let url = Bundle.main.url(forResource: filename, withExtension: "json") else {
            fatalError("Failed to locate " + filename + ".json in bundle.")
    }
    guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load " + filename + ".json from bundle.")
        }

    return data
}

func jsonFileToStruct(filename: String) -> dataStruct{
    let jsonData = jsonFileToData(filename: filename)
    do {
        let decoder = JSONDecoder()
        let decoded = try decoder.decode(dataStruct.self, from: jsonData!)
        return decoded
    }catch{
        print("Error decoding JSON: \(error)")
    }
    return dataStruct(device: "", ssid: "", password: "", plantName: "", waterLevel: -1, on: false, auto: false, schedule: "", currentData: -1)
}

func jsonStringToData(jsonString: String) -> Data? {
    guard let data = jsonString.data(using: .utf8) else {
        print("Error: Could not convert JSON string to data with UTF-8 encoding.")
        return nil
    }
    return data
}

func jsonDataToStruct(jsonData: Data) -> dataStruct?{
    do {
        let decoder = JSONDecoder()
        let decoded = try decoder.decode(dataStruct.self, from: jsonData)
        return decoded
    }catch{
        print("Error decoding JSON: \(error)")
    }
    return dataStruct(device: "", ssid: "", password: "", plantName: "", waterLevel: -1, on: false, auto: false, schedule: "", currentData: -1)
}

func writeDataToJson(data: dataStruct, filename: String){
    let encoder = JSONEncoder()
    var jsonData: Data = Data()
    do{
        jsonData = try encoder.encode(data)
    }catch {
        print("Error encoding JSON: \(error)")
    }
    guard let url = Bundle.main.url(forResource: filename, withExtension: "json") else {
            fatalError("Failed to locate " + filename + ".json in bundle.")
    }
    do {
        try jsonData.write(to: url, options: [.atomicWrite])
        print("Successfully wrote JSON to \(url.lastPathComponent)")
    }catch {
        print("Error writing JSON to file: \(error)")
    }
}

func structToDictionary(data: dataStruct) -> [String: Any] {
    return ["ssid": data.ssid, "password": data.password, "device": data.device, "schedule": data.schedule]
}

struct dataStruct: Decodable, Encodable{
    var device: String
    var ssid: String
    var password: String
    var plantName: String
    var waterLevel: Int
    var on: Bool
    var auto: Bool
    var schedule: String
    var currentData: Int
}
