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
            RadialGradient(stops: [
                .init(color: Color(red: 0.15, green: 0.30, blue: 0.65), location: 0.35),
                .init(color: Color(red: 0.65, green: 0.13, blue: 0.23), location: 0.35)
            ], center: .top, startRadius: 200, endRadius: 700)
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                Text("Guess the flag")
                    .font(.largeTitle.bold())
                    .foregroundColor(.white)
                VStack {
                    VStack {
                        Text("Choose the flag of")
                            .foregroundColor(.secondary)
                            .font(.subheadline.weight(.heavy))
                        Text(countries[correctAnswer])
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
                .frame(maxWidth: .infinity)
                .padding()
                .background(.thinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 25))
                
                Spacer()
                Spacer()
                
                Text("Score: \(score)")
                    .font(.title.bold())
                    .foregroundColor(.white)
                Spacer()
            }
            .padding()
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
