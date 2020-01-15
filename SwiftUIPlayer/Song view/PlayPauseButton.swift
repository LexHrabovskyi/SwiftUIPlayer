//
//  PlayPauseButton.swift
//  SwiftUIPlayer
//
//  Created by Александр on 15.01.2020.
//  Copyright © 2020 Александр. All rights reserved.
//

import SwiftUI

struct PlayPauseButton: View {
    
    @EnvironmentObject var playerManager: PlayerManager
    @State private var nowPlaying = false
    var song: Song
    var size: CGFloat = 24
    
    var body: some View {
        
        Image(systemName: nowPlaying ? "pause" : "play")
            .resizable()
            .frame(width: size, height: size)
            .onReceive(playerManager.playingSongPublisher) { value in
                guard let playingSong = value.0, playingSong == self.song else { self.nowPlaying = false; return }
                self.nowPlaying = value.1
        }
            .onTapGesture {
                self.playerManager.playOrPause(song: self.song)
        }
        
    }
}

struct PlayPauseButton_Previews: PreviewProvider {
    static var previews: some View {
        PlayPauseButton(song: Song(id: 1, name: "SoundHelix Song 1", url: "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3"))
    }
}
