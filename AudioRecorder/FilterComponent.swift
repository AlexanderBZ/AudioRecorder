//
//  FilterComponent.swift
//  AudioRecorder
//
//  Created by Alexander Zwerner on 1/28/21.
//

import SwiftUI

struct FilterComponent: View {
    var filterName: String
    var filterImage: String
    var filter: String
    var audioURL: URL
    
    @ObservedObject var audioFilterPlayer = AudioFilterPlayer()

    var body: some View {
        VStack {
            Button(action: {audioFilterPlayer.filterAudio(audioURL)}) {
                ZStack {
                    Circle()
                        .stroke(Color.black, lineWidth: 5)
                        .frame(width: 70, height: 70)
                    Image(systemName: "\(filterImage)")
                        .renderingMode(.original)
                        .font(.system(size: 32))
                }
            }
            Text(filterName)
                .fontWeight(.light)
        }
    }
}

struct FilterComponent_Previews: PreviewProvider {
    static var previews: some View {
        FilterComponent(filterName: "Chipmunk", filterImage: "eye", filter: "pitch", audioURL: audioFilterPlayer.recordings[0].fileURL, audioFilterPlayer: AudioFilterPlayer())
    }
}
