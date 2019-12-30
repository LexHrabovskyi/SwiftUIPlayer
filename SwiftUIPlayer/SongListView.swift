//
//  ContentView.swift
//  SwiftUIPlayer
//
//  Created by Александр on 29.12.2019.
//  Copyright © 2019 Александр. All rights reserved.
//

import SwiftUI

struct SongListView: View {
    
    @EnvironmentObject var playlist: Playlist
    @EnvironmentObject var player: AudioPlayer
    @EnvironmentObject var playerController: PlayerController
    
    var body: some View {
        
        List {
            
            ForEach(playlist.songListData) { song in
                HStack {
                    Image(systemName: self.playerController.nowPlaying(song) ? "pause" : "play")
                        .onTapGesture {
                            self.playerController.playOrPause(song: song)
                    }
                    Text(song.name)
                }
            }
            
        }
        
        
    }
    
}

struct ContentView_Previews: PreviewProvider {
    
    static var previews: some View {
        
        let playlist = Playlist()
        let player = AudioPlayer()
        
        return SongListView()
            .environmentObject(player)
            .environmentObject(playlist)
            .environmentObject(PlayerController(player: player, for: playlist))
    }
    
}
