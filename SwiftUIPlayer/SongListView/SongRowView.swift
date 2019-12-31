//
//  SongRowView.swift
//  SwiftUIPlayer
//
//  Created by Александр on 31.12.2019.
//  Copyright © 2019 Александр. All rights reserved.
//

import SwiftUI

struct SongRowView: View {
    
    var song: Song
    @EnvironmentObject var player: AudioPlayer
    @EnvironmentObject var playerController: PlayerController
    
    var body: some View {
        HStack {
            Image(systemName: self.player.isPlaying && self.playerController.nowPlaying(song) ? "pause" : "play")
                .resizable()
                .frame(width: 24, height: 24)
                .padding()
                .onTapGesture {
                    self.playerController.playOrPause(song: self.song)
            }
            
            Text(song.name)
                .bold()
            
            if self.playerController.nowLoading(song) {
                Spacer()
                Text("loading")
            }
        }
    }
}

struct SongRowView_Previews: PreviewProvider {
    static var previews: some View {
        
        let playlist = Playlist()
        let player = AudioPlayer()
        
        return SongRowView(song: Song(id: 1, name: "SoundHelix Song 1", url: "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3", lenght: 372.0))
            .environmentObject(player)
            .environmentObject(playlist)
            .environmentObject(PlayerController(player: player, for: playlist))
    }
}
