//
//  Get_Handling.swift
//  Plant Water App
//
//  Created by Deven H on 10/3/25.
//

func handleGetRequest(url: String) -> dataStruct {
    return jsonDataToStruct(jsonData: jsonStringToData(jsonString: makeGetRequest(urlString: url))!)!
}
