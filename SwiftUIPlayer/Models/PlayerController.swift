//
//  PlayerController.swift
//  SwiftUIPlayer
//
//  Created by Александр on 30.12.2019.
//  Copyright © 2019 Александр. All rights reserved.
//

import Foundation

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
        
        player.setCurrentItem(with: song)
        player.playPausePlayer()
        
        playlist.setCurrentSong(song)
        // waiting for new status?
        
    }
    
    func nowPlaying(_ song: Song) -> Bool {
        return player.isPlaying && playlist.currentSong == song
    }
    
}
