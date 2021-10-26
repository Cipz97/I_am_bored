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
    let networkManager = NetworkManager()
    
    func fetchActivity(_ category: String) {
        var newCategory = category
        if newCategory == "random" {
            newCategory = categories[Int.random(in: 1..<categories.count)]
        }
        let url = "https://www.boredapi.com/api/activity?type=\(newCategory)"
        networkManager.performRequest(url: url) { activityModel in
            self.activityModel.activity = activityModel.activity
        }
    }
}
