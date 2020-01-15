//
//  PlayerSlider.swift
//  SwiftUIPlayer
//
//  Created by Александр on 31.12.2019.
//  Copyright © 2019 Александр. All rights reserved.
//

import SwiftUI

struct PlayerSlider: View {
    
    @EnvironmentObject var player: AudioPlayer
    @EnvironmentObject var playerController: PlayerController

    @State private var currentPlayerTime: Double = 0.0
    @State private var songLenght: Double = 1.0
    var song: Song
    
    var body: some View {
        
        HStack {
            
            Text("\(toMinSec(self.currentPlayerTime))")
                .frame(width: 50)
                .lineLimit(1)

            Spacer()
            
            GeometryReader { geometry in
                Slider(value: self.$currentPlayerTime, in: 0.0...self.songLenght)
                    .onReceive(self.player.timeChanged) { _ in
                        guard self.playerController.isCurrentSong(self.song) else { self.currentPlayerTime = 0.0; return }
                        self.currentPlayerTime = self.player.currentTimeInSeconds
                }
                .gesture(DragGesture(minimumDistance: 0)
                .onChanged({ value in
                    
                    let coefficient = abs(Double(self.songLenght) / Double(geometry.size.width))
                    self.playerController.rewindTime(to: Double(value.location.x) * coefficient)
                    
                }))
            }
            .frame(height: 30)
            
            Spacer()
            
            Text("\(toMinSec(self.songLenght))")
                .frame(width: 50)
                .lineLimit(1)
            
        }
        .padding()
        
    }
    
    private func toMinSec(_ seconds : Double) -> String {
        let (_,  minf) = modf(seconds / 3600)
        let (min, secf) = modf(60 * minf)
        let seconds = Int(60 * secf)
        return "\(Int(min)):\(seconds < 10 ? "0\(seconds)" : "\(seconds)")"
    }
    
}

struct PlayerSlider_Previews: PreviewProvider {
    static var previews: some View {
        PlayerSlider(song: Song(id: 1, name: "SoundHelix Song 1", url: "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3"))
    }
}
