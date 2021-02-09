//
//  AudioRecorderApp.swift
//  AudioRecorder
//
//  Created by Alexander Zwerner on 12/27/20.
//

import SwiftUI

@main
struct AudioRecorderApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(audioRecorder: AudioRecorder())
        }
    }
}
