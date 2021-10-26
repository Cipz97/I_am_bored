//
//  NetworkManager.swift
//  I_am_bored
//
//  Created by Matteo Cipone on 26.10.21.
//

import Foundation

class NetworkManager {
    
    
    
    func performRequest(url: String, completion: @escaping(ActivityModel) -> Void) {
       
        guard let url = URL(string: url) else { return }
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let safeData = data {
                if let decodedResponse = try? JSONDecoder().decode(ActivityModel.self, from: safeData) {
                    DispatchQueue.main.async {
                        // updates activityModel with new data fetched from BoredAPI
                        completion(ActivityModel(activity: decodedResponse.activity))
                    }
                    return
                }
            }
            print("Fetch failed: \(error?.localizedDescription ?? "Unknown Error")")
        }.resume()
    }
}
