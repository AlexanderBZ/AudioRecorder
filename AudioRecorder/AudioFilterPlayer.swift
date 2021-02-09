//
//  AudioFilterPlayer.swift
//  AudioRecorder
//
//  Created by Alexander Zwerner on 1/28/21.
//

import Foundation
import AVFoundation


class AudioFilterPlayer: NSObject, ObservableObject, AVAudioPlayerDelegate {
    let engine = AVAudioEngine()
    let speedControl = AVAudioUnitVarispeed()
    let pitchControl = AVAudioUnitTimePitch()
    
    func filterAudio(_ url: URL) throws {
        
        let playbackSession = AVAudioSession.sharedInstance()
        
        do {
            try playbackSession.overrideOutputAudioPort(AVAudioSession.PortOverride.speaker)
        } catch {
            print("Playing over the device's speakers failed")
        }
        
        do {
            let file = try AVAudioFile(forReading: url)

            let audioPlayerFilter = AVAudioPlayerNode()
            
            engine.attach(audioPlayerFilter)
            engine.attach(pitchControl)
            engine.attach(speedControl)
            
            engine.connect(audioPlayerFilter, to: speedControl, format: nil)
            engine.connect(pitchControl, to: engine.mainMixerNode, format: nil)
            engine.connect(speedControl, to: pitchControl, format: nil)
            
            audioPlayerFilter.scheduleFile(file, at: nil)
            
            try engine.start()
            audioPlayerFilter.play()
        } catch {
            print("Playback failed")
        }

    }
}
