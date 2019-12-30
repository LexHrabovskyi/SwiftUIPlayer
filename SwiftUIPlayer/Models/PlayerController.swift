//
//  PlayerController.swift
//  SwiftUIPlayer
//
//  Created by Александр on 30.12.2019.
//  Copyright © 2019 Александр. All rights reserved.
//

import Foundation
import AVKit
import Combine

class PlayerController: ObservableObject {
    
    private let playlist: Playlist
    private let player: AudioPlayer
    
    init(player: AudioPlayer, for playlist: Playlist) {
        self.player = player
        self.playlist = playlist
    }
    
    func playOrPause(song: Song) {
        
        guard song != playlist.currentSong else {
            player.playPausePlayer()
            return
        }
        
        playlist.setCurrentSong(song)
        
        // MARK: subscribing for beginning of song playing
        var waitingForStatusChanging: AnyCancellable?
        waitingForStatusChanging = player.timePlayerStatusChanged.sink { newStatus in
            guard newStatus == .playing else { return }
            
            // TODO: set control panel
            self.player.isPlaying = true
            waitingForStatusChanging?.cancel()
        }
        
        player.setCurrentItem(with: song)
        
    }
    
    func nowPlaying(_ song: Song) -> Bool {
        return player.isPlaying && playlist.currentSong == song
    }
    
}
