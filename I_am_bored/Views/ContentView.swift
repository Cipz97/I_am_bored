//
//  ContentView.swift
//  I_am_bored
//
//  Created by Matteo Cipone on 26.10.21.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var activityViewModel = ActivityViewModel()
    @State private var selectedCategory = "random"
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color("ElectronBlue"), Color("LightYellow")]),
                           startPoint: .topLeading,
                           endPoint: .bottomTrailing)
                .ignoresSafeArea()
            VStack {
                Spacer()
                HeaderView()
                Picker("Choose a category", selection: $selectedCategory) {
                    ForEach(activityViewModel.categories, id: \.self) { category in
                        Text(category.capitalized).tag(category)
                    }
                }.pickerStyle(.wheel)
                AnswerView(activityModel: activityViewModel.activityModel)
                Spacer()
                ButtonView(activityViewModel: activityViewModel, category: selectedCategory)
                Spacer()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
        ContentView()
            .preferredColorScheme(.dark)
    }
}
//MARK: - Button
struct ButtonView: View {
    var activityViewModel: ActivityViewModel
    var category: String
    var body: some View {
        Button(action: {
            activityViewModel.fetchActivity(category)
        }) {
            Text("I'm going to...")
                .fontWeight(.semibold)
                .padding()
                .font(.system(size: 25))
                .foregroundColor(Color("HeadingColor"))
        }
        .frame(width: 230.0, height: 90.0)
        .background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color.white/*@END_MENU_TOKEN@*/)
        .cornerRadius(20)
        .shadow(color: .black, radius: 5, x: 5, y: 5)
    }
}
//MARK: - Displayed Answer
struct AnswerView: View {
    var activityModel: ActivityModel
    var body: some View {
        VStack {
            Text(activityModel.activity)
                .fontWeight(.bold)
                .foregroundColor(Color("HeadingColor"))
                .font(.system(size: 35))
                .multilineTextAlignment(.center)
        }
        .frame(width: 350, height: 200)
        .padding(.horizontal)
        .animation(.default)
    }
}
//MARK: - Header
struct HeaderView: View {
    var body: some View {
        VStack {
            Text("I AM BORED...")
                .font(.system(size: 47))
                .fontWeight(.bold)
                .padding()
                .foregroundColor(.white)
                .shadow(color: .black, radius: 1, x: 2, y: 2)
            Text("Pick a category and press the button for an exciting new activity!")
                .multilineTextAlignment(.center)
                .foregroundColor(.white)
                .font(.system(size: 22))
                .padding(.horizontal)
        }
    }
}
