//
//  ApiService.swift
//  NASAApp
//
//  Created by Eduard Sinyakov on 10.04.2021.
//

import Foundation

class ApiService {
    private let apiKey = "poaF8NYvAG221b84cjQcVzKKVzDBpniWSHECVV9C"
    
    func requestGame(completion: @escaping (_ invoiceState: [PictureOfDayModel]?, _ error: String?) -> Void) {
        let urlString = "https://api.nasa.gov/planetary/apod?start_date=2021-03-10&api_key=\(apiKey)"
        let url = URL(string: urlString)!
        var request = URLRequest(url: url)
        request.configure(.get)

        let task = URLSession.shared.dataTask(with: request) { data, response, error in

            if let error = self.handleErrors(response, error) {
                completion(nil, error)
                return
            }

            guard let data = data else {
                completion(nil, "Server error. \nPlease, try again later.")
                return
            }
//            if let parsedData = try? JSONSerialization.jsonObject(with: data) as? NSDictionary {
//                print("parsedData requestPayoutState: \(parsedData)")
//            }
//            let event = JSONDataToObject(GameModels.self, from: data)
//            let event = try? JSONDecoder().decode(GameModels.self, from: data)
            do {
                let result = try JSONDecoder().decode([PictureOfDayModel].self, from: data)
                completion(result, nil)
            } catch {
                print(error.localizedDescription)
                completion(nil, error.localizedDescription)
            }
        }

        task.resume()
    }
    
    private func handleErrors(_ response: URLResponse?, _ error: Error?) -> String? {
        guard let response = response as? HTTPURLResponse,
            error == nil else {
                return "Server error. \nPlease, try again later."
        }

        if response.statusCode == 200 {
            return nil
        }

        if response.statusCode == 404 {
            return "Please, check internet connection."
        }

        if response.statusCode == 400 {
            return "Server error. \nPlease, try again later."
        }

        if response.statusCode == 401 {
            return "Please, log out and sign in again."
        }

        return "Server error. \nPlease, try again later."
    }
}

enum URLS: String {
    case APOD = "https://api.nasa.gov/planetary/apod?start_date=2021-03-10&api_key=DEMO_KEY"
}

extension URLRequest {
    mutating func configure(
        _ method: HttpMethod,
        _ parameters: [String: Any?]? = nil
    ) {
//        self.addValue("Bearer \(AuthenticationService.shared.accessToken ?? "")",
//            forHTTPHeaderField: "Authorization")
        self.addValue("application/json", forHTTPHeaderField: "Content-Type")

        self.httpMethod = method.rawValue
        if let strongParameters = parameters, !strongParameters.isEmpty {
            self.httpBody = try? JSONSerialization.data(withJSONObject: strongParameters)
        }
    }
}
enum HttpMethod: String {
    case post = "POST"
    case get = "GET"
    case put = "PUT"
}
