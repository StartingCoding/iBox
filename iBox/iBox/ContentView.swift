//
//  ContentView.swift
//  iBox
//
//  Created by Loris on 12/19/19.
//  Copyright © 2019 Loris. All rights reserved.
//

import SwiftUI

//To-Do List!
//✅    - Create Start and Stop Timer function -> https://stackoverflow.com/questions/56504410/how-to-update-text-using-timer-in-swiftui
//    - Store Starting Date and Final Date

struct ContentView: View {
    // Text settings for the event
    @State private var titleEvent = ""
    @State private var notesEvent = ""
    
    // Timer settings
    @State private var timerIsRunning = false
    @State private var timer: Timer?
    
    @State private var startDate = Date()
    @State private var stopDate = Date()
    
    // Timer Display
    @State private var seconds = 0
    @State private var minutes = 0
    @State private var hours = 0
    
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
                
                Text("\(hours)h : \(minutes)m : \(seconds)s")
                
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
        guard timerIsRunning == true else {
            timer?.invalidate()
            
            self.hours = 0
            self.minutes = 0
            self.seconds = 0
            
            self.stopDate = Date()
            
            return
        }
        
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) {_ in
            self.startDate = Date()
            self.ticking()
        }
    }
    
    // The logic of the time displayed
    func ticking() {
        if self.minutes >= 3 && self.seconds >= 3 {
            self.minutes = 0
            self.seconds = 0
            self.hours += 1
            return
        } else if self.seconds >= 3 {
            self.seconds = 0
            self.minutes += 1
            return
        }
        
        self.seconds += 1
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
