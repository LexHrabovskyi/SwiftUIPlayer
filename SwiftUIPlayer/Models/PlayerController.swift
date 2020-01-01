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
import SwiftUI

class PlayerController: ObservableObject {
    
    @Published var isLoading: Bool = false
    var loadingStatusChanged: AnyPublisher<Bool, Never>  {
        return $isLoading
            .eraseToAnyPublisher()
    }
    
    private let playlist: Playlist
    private let player: AudioPlayer
    
    init(player: AudioPlayer, for playlist: Playlist) {
        self.player = player
        self.playlist = playlist
    }
    
    // MARK: player controls
    func playOrPause(song: Song) {
        
        guard song != playlist.currentSong else {
            player.playPausePlayer()
            return
        }
        
        playlist.setCurrentSong(song)
        isLoading = true
        
        // MARK: subscribing for beginning of song playing
        var waitingForStatusChanging: AnyCancellable?
        waitingForStatusChanging = player.timePlayerStatusChanged.sink { newStatus in
            guard newStatus == .playing else { return }
            
            // TODO: set control panel
            self.isLoading = false
            waitingForStatusChanging?.cancel()
        }
        
        player.setCurrentItem(with: song)
        
    }
    
    func rewindTime(to seconds: Double) {
        let timeCM = CMTime(seconds: seconds, preferredTimescale: CMTimeScale(NSEC_PER_SEC))
        player.seek(to: timeCM)
    }
    
    func forward15Sec() {
        guard let song = playlist.currentSong else { return }
        let currentTime = player.currentTimeInSeconds
        let forwardTime = song.lenght > currentTime + 15.0 ? currentTime + 15.0 : song.lenght
        rewindTime(to: forwardTime)
    }
    
    func backward15Sec() {
        let currentTime = player.currentTimeInSeconds
        let backwardTime = currentTime > 15.0 ? currentTime - 15.0 : 0.0
        rewindTime(to: backwardTime)
    }
    
    func getCurrentSong() -> Song {
        return playlist.currentSong!
    }
    
    // MARK: checking functions
    func nowPlaying(_ song: Song) -> Bool {
        return player.isPlaying && playlist.currentSong == song
    }
    
    func nowLoading(_ song: Song) -> Bool {
        return nowPlaying(song) && isLoading
    }
    
    func isCurrentSong(_ song: Song) -> Bool {
        return playlist.currentSong == song
    }
    
}
