//
//  ContentView.swift
//  iBox
//
//  Created by Loris on 12/19/19.
//  Copyright © 2019 Loris. All rights reserved.
//

import SwiftUI

//To-Do List!
//  - Find a way to make the timer work even in background (DateInerval, Custom Date to be displayed) -> https://stackoverflow.com/questions/26405079/how-to-run-timer-thought-the-app-entered-background-or-is-terminated
// - Rework Basic Design
// - Work with Calendar API (EventKitUI)

struct ContentView: View {
    // Text settings for the event
    @State private var titleEvent = ""
    @State private var notesEvent = ""
    
    @State private var timerLabel = "00:00"
    
    // Timer settings
    @State private var timerIsRunning = false
    @State private var timer: Timer!
    
    // Some timer in your code which shows the number of seconds
    @State private var timeRemaining = 20
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.white, .blue, .blue, .white]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all)
            
            VStack() {
                Text("iBox")
                    .font(.largeTitle)
                
                Spacer()
                
                VStack {
                    Text("Title")
                    TextField("Title of the Event", text: $titleEvent)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                }
                .padding(50)
                
                Spacer()
                
                Text(timerLabel)
                
                Spacer()
                
                VStack {
                    Text("Notes")
                    TextField("Short notes for the Event", text: $notesEvent)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                .padding(50)
                
                Spacer()
                
                Button(action: {
                    self.timerIsRunning.toggle()
                    self.startTimer()
                }) {
                    if timerIsRunning == false {
                        Text("Start")
                            .foregroundColor(.green)
                    } else {
                        Text("Stop")
                            .foregroundColor(.red)
                    }
                }
                
                Spacer()
            }
        }
    }
    
    // The logic of start/stop timer
    func startTimer() {
        // Stop the timer when hitting Stop and reset time to a default setting
        guard timerIsRunning == true else {
            self.timeRemaining = 20
            self.timerLabel = "\(self.formattedTime(self.timeRemaining))"
            timer.invalidate()
            return
        }
        
        timer = Timer.every(1.second) { (timer: Timer) in
            self.timeRemaining -= 1
            // Updating timer label outlet. Formated time is another extension provided below for reference.
            self.timerLabel = "\(self.formattedTime(self.timeRemaining))"
            // MARK: Timer Done
            if self.timeRemaining <= 0 {
                timer.invalidate()
            }
        }
    }
    
    func formattedTime(_ totalSeconds: Int) -> String {
        let seconds = totalSeconds % 60
        let minutes = (totalSeconds / 60) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
