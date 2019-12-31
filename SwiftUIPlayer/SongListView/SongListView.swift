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
        
        NavigationView {
            List {
                ForEach(playlist.songListData) { song in
                    SongRowView(song: song)
                }
            }
            .navigationBarTitle("From soundhelix.com")
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


