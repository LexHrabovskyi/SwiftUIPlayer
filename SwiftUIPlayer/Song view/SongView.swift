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
    @EnvironmentObject var playerController: PlayerController
    
    var song: Song
    
    var body: some View {
        VStack {
            
            Text(song.name)
            
            
            
        }
    }
    
}

struct SongView_Previews: PreviewProvider {
    static var previews: some View {
        SongView(song: Song(id: 1, name: "SoundHelix Song 1", url: "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3", lenght: 372.0))
    }
}
