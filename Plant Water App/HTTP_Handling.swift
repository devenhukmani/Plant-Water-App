//
//  HTTP Handling.swift
//  Plant Water App
//
//  Created by Deven H on 9/29/25.
//

import Foundation

func makeGetRequest(urlString: String) {
    guard let url = URL(string: urlString) else {
        print("Invalid URL")
        return
    }

    let task = URLSession.shared.dataTask(with: url) { data, response, error in
        if let error = error {
            print("Error: \(error.localizedDescription)")
            return
        }

        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode) else {
            print("Invalid response or status code")
            return
        }

        if let data = data {
            // Process the received data (e.g., decode JSON)
            print("Received data: \(String(data: data, encoding: .utf8) ?? "Unable to decode")")
        }
    }
    task.resume()
}

func makePostRequest(urlString: String, parameters: String) {
    guard let url = URL(string: urlString) else {
        print("Invalid URL")
        return
    }
    var request = URLRequest(url: url)
    request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
    request.setValue("application/json", forHTTPHeaderField: "Accept")
    request.httpMethod = "POST"
    /*let parameters: String = """
    {
      "name": "Alice Wonderland",
      "age": 30,
      "isStudent": false,
      "courses": [
        {
          "title": "Advanced Python",
          "credits": 3
        },
        {
          "title": "Web Development",
          "credits": 4
        }
      ],
      "contact": {
        "email": "alice@example.com",
        "phone": null
      },
      "address": {
        "street": "123 Rabbit Hole",
        "city": "Wonderland",
        "zip": "12345"
      }
    }
    """*/
    let encoder = JSONEncoder()
    do{
        request.httpBody = try encoder.encode(parameters)
    }catch{
        print(error)
    }

    let task = URLSession.shared.dataTask(with: request) { data, response, error in
        guard
            let data = data,
            let response = response as? HTTPURLResponse,
            error == nil
        else {                                                               // check for fundamental networking error
            print("error", error ?? URLError(.badServerResponse))
            return
        }
        
        guard (200 ... 299) ~= response.statusCode else {                    // check for http errors
            print("statusCode should be 2xx, but is \(response.statusCode)")
            print("response = \(response)")
            return
        }
        
        // do whatever you want with the `data`, e.g.:
        
        do {
            let responseObject = try JSONDecoder().decode(ResponseObject<Foo>.self, from: data)
            print(responseObject)
        } catch {
            print(error) // parsing error
            
            if let responseString = String(data: data, encoding: .utf8) {
                print("responseString = \(responseString)")
            } else {
                print("unable to parse response as string")
            }
        }
    }

    task.resume()
}

/*extension CharacterSet {
    static let urlQueryValueAllowed: CharacterSet = {
        let generalDelimitersToEncode = ":#[]@" // does not include "?" or "/" due to RFC 3986 - Section 3.4
        let subDelimitersToEncode = "!$&'()*+,;="
        
        var allowed: CharacterSet = .urlQueryAllowed
        allowed.remove(charactersIn: "\(generalDelimitersToEncode)\(subDelimitersToEncode)")
        return allowed
    }()
}*/

// sample Decodable objects for https://httpbin.org

struct ResponseObject<T: Decodable>: Decodable {
    let form: T    // often the top level key is `data`, but in the case of https://httpbin.org, it echos the submission under the key `form`
}

struct Foo: Decodable {
    let id: String
    let name: String
}

//POST code from Rob at https://stackoverflow.com/questions/26364914/http-request-in-swift-with-post-method
