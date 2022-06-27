//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by newbie on 26.06.2022.
//

import SwiftUI

struct ContentView: View {
    @State private var alertMessage = ""
    @State private var showingAlert = false
    @State private var score = 0
    
    
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [.mint, .black], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            VStack {
                VStack {
                    Text("Choose the flag of")
                        .foregroundColor(.white)
                        .font(.subheadline.weight(.heavy))
                    Text(countries[correctAnswer])
                        .foregroundColor(.white)
                        .font(.largeTitle.bold())
                }
                ForEach(0..<3) { number in
                    Button {
                        showScore(number)
                    } label: {
                        Image(countries[number])
                            .renderingMode(.original)
                            .padding()
                            .clipShape(Capsule())
                            .shadow(radius: 10)
                    }
                }
            }
        }
        .alert(alertMessage, isPresented: $showingAlert) {
            Button("Continue", action: askQuestion)
        } message: {
            Text("Your score is \(score)")
        }
    }
    
    private func showScore(_ number: Int) {
        if number == correctAnswer {
            alertMessage = "Correct"
            score += 1
        } else {
            alertMessage = "Wrong"
            score -= 1
        }
        showingAlert = true
    }
    
    private func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
