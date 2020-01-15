//
//  SongView.swift
//  SwiftUIPlayer
//
//  Created by Александр on 31.12.2019.
//  Copyright © 2019 Александр. All rights reserved.
//

import SwiftUI

struct SongView: View {
    
    @EnvironmentObject var player: AudioPlayer
    @EnvironmentObject var playerManager: PlayerManager
    
    @State var song: Song
    
    var body: some View {
        VStack {
            
            HStack {
                Text(song.name)
            }
            
            SongControlsView(song: $song)
            
            PlayerSlider(song: song)
            
            VolumeView()
            
        }
    }
    
}

struct SongView_Previews: PreviewProvider {
    static var previews: some View {
        SongView(song: Song(id: 1, name: "SoundHelix Song 1", url: "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3"))
    }
}
