//
//  ContentView.swift
//  iBox
//
//  Created by Loris on 12/19/19.
//  Copyright © 2019 Loris. All rights reserved.
//

import SwiftUI

//To-Do List!
//    - Build a formatDate for timer from 00:00:00 (didSet, willSet)
//    - Display dinamyc timer date
//    - Create Start and Stop Timer function
//    - Store Starting Date and Final Date

struct ContentView: View {
    // Text settings for the event
    @State private var titleEvent = ""
    @State private var notesEvent = ""
    
    // Timer settings
    @State private var currentDate = Date()
    @State private var timerDisplay = 0
    let second = Calendar.current.dateComponents([.second], from: Date()).second!
    let minute = Calendar.current.dateComponents([.minute], from: Date()).minute!
    let timer = Timer.publish(every: 1, on: .main, in: .common)
    
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
                
                Text("m\(minute)" + " : " + "s\(second)")
                    .onReceive(timer) { input in
                        self.currentDate = input
                        self.timerDisplay += 1
                }
                
                Spacer()
                
                VStack {
                    Text("Notes")
                    TextField("Short notes for the Event", text: $notesEvent)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                .padding(50)
                
                Spacer()
                
                Button("Start") {
                    self.timer.connect()
                }
                
                Spacer()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
