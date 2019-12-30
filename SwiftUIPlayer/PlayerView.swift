//
//  ContentView.swift
//  SwiftUIPlayer
//
//  Created by Александр on 29.12.2019.
//  Copyright © 2019 Александр. All rights reserved.
//

import SwiftUI

struct PlayerView: View {
    
    @EnvironmentObject var player: AudioPlayer
    
    var body: some View {
        
        HStack(alignment: .center, spacing: 15) {
            
            Image(systemName: "backward.end")
                .onTapGesture {
                    self.player.playNextSong()
            }
            
            Image(systemName: self.player.isPlaying ? "pause" : "play")
                .resizable()
                .frame(width: 30, height: 30)
                .onTapGesture {
                    self.player.playPausePlayer()
            }
            
            Image(systemName: "forward.end")
                .onTapGesture {
                    self.player.playNextSong()
            }
            
        }
        
        
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        PlayerView()
            .environmentObject(AudioPlayer())
    }
}
