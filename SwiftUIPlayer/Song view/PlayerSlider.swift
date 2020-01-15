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
    @EnvironmentObject var playerManager: PlayerManager

    @State private var currentPlayerTime: Double = 0.0
    @State private var songLenght: Double = 1.0
    var song: Song
    
    var body: some View {
        
        HStack {
            
            Text("\(toMinSec(self.currentPlayerTime))")
                .frame(width: 50)
                .lineLimit(1)
                .onReceive(self.playerManager.loadingStatusChanged) { status in
                        guard self.playerManager.isCurrentSong(self.song), !status else { return }
                        self.songLenght = self.playerManager.getPlayingDuration() ?? 1.0
                }

            Spacer()
            
            GeometryReader { geometry in
                Slider(value: self.$currentPlayerTime, in: 0.0...self.songLenght)
                    .onReceive(self.playerManager.timeChanged) { _ in
                        guard self.playerManager.isCurrentSong(self.song) else { self.currentPlayerTime = 0.0; return }
                        self.currentPlayerTime = self.player.currentTimeInSeconds
                }
                .gesture(DragGesture(minimumDistance: 0)
                .onChanged({ value in
                    guard self.playerManager.isCurrentSong(self.song) else { return }
                    let coefficient = abs(Double(self.songLenght) / Double(geometry.size.width))
                    self.playerManager.rewindTime(to: Double(value.location.x) * coefficient)
                    
                }))
            }
            .frame(height: 30)
            
            Spacer()
            
            if self.songLenght == 1.0 {
                ActivityIndicator(isAnimating: .constant(true), style: .medium)
            } else {
                Text("\(toMinSec(self.songLenght))")
                    .frame(width: 50)
                    .lineLimit(1)
            }
            
            
            
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
