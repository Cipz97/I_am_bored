//
//  ActivityViewModel.swift
//  I_am_bored
//
//  Created by Matteo Cipone on 26.10.21.
//

import SwiftUI

class ActivityViewModel: ObservableObject {
    
    let categories = ["random", "education", "recreational", "social", "diy", "charity", "cooking", "relaxation", "music", "busywork"]
    @Published var activityModel = ActivityModel(activity: "")
    //necessary to perform NetworkingRequest to update UI
    let networkManager = NetworkManager()
    //performs Network Request with url depending on which category was passed in.
    func fetchActivity(_ category: String) {
        // storing value of parameter passed in to assign it a new value based on logic check if random was chosen
        var newCategory = category
        if newCategory == "random" {
            //if random was chosen a random category will be assigned starting from index 1 since index 0 is "random"
            newCategory = categories[Int.random(in: 1..<categories.count)]
        }
        let url = "https://www.boredapi.com/api/activity?type=\(newCategory)"
        networkManager.performRequest(url: url) { activityModel in
            self.activityModel.activity = activityModel.activity
        }
    }
}
