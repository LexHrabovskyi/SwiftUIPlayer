//
//  SongControlsView.swift
//  SwiftUIPlayer
//
//  Created by Александр on 31.12.2019.
//  Copyright © 2019 Александр. All rights reserved.
//

import SwiftUI

struct SongControlsView: View {
    
    @EnvironmentObject var player: AudioPlayer // TODO: delete it!
    @EnvironmentObject var playerController: PlayerController
    @Binding var song: Song
    
    var body: some View {
        
        HStack {
            
            Spacer()
            
            Image(systemName: "gobackward.15")
                .resizable()
                .frame(width: 24, height: 24)
                .onTapGesture {
                    self.playerController.backward15Sec()
            }
            
            Spacer()
            
            Image(systemName: self.player.isPlaying && self.playerController.nowPlaying(song) ? "pause" : "play")
                .resizable()
                .frame(width: 36, height: 36)
                .padding()
                .onTapGesture {
                    self.playerController.playOrPause(song: self.song)
            }
            
            Spacer()
            
            Image(systemName: "goforward.15")
                .resizable()
                .frame(width: 24, height: 24)
                .onTapGesture {
                    self.playerController.forward15Sec()
            }
            
            Spacer()
            
        }
            .padding()
        
    }
}

struct SongControlsView_Previews: PreviewProvider {
    static var previews: some View {
        SongControlsView(song: .constant(Song(id: 1, name: "SoundHelix Song 1", url: "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3", lenght: 372.0)))
    }
}