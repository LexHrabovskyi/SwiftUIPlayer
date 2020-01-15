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
    @EnvironmentObject var playerManager: PlayerManager
    
    @State private var listIsLoading = false
    
    var body: some View {
        
        NavigationView {
            
            ZStack {
                List {
                    ForEach(playlist.songList) { song in
                        SongRowView(song: song)
                    }
                }
                
                ActivityIndicator(isAnimating: self.$listIsLoading, style: .large)
                    .onReceive(self.playlist.$listIsLoading) { value in
                        self.listIsLoading = value
                }
            }
            .navigationBarTitle("From soundhelix.com", displayMode: .inline)
            .navigationBarItems(trailing: Button(action: {self.playlist.updateList()}, label: {
                Image(systemName: "arrow.clockwise.icloud")
            }))
            
        }
        .onAppear {
            self.playlist.updateList()
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
            .environmentObject(PlayerManager(player: player, for: playlist))
    }
    
}


