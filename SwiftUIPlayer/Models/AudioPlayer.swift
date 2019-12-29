//
//  AudioPlayer.swift
//  Agugai
//
//  Created by Александр on 15.11.2019.
//  Copyright © 2019 Александр. All rights reserved.
//

import Foundation
import AVKit
import Combine

final class AudioPlayer: AVPlayer, ObservableObject {
    
    // MARK: Publishers
    @Published var currentTimeInSeconds: Double = 0.0
    @Published var isPlaying: Bool = false
    var timeChanged: AnyPublisher<Double, Never>  {
        return $currentTimeInSeconds
            .eraseToAnyPublisher()
    }
    
    private let songList = songListData
    private var currentSong: Song? = nil
    private var timeObserverToken: Any?
    
    override init() {
        super.init()
        currentSong = songList.first
        registerObserves()
    }
    
    // MARK: observers
    private func registerObserves() {
        
        self.addObserver(self, forKeyPath: "currentItem", options: [.new], context: nil)
        let interval = CMTime(seconds: 1, preferredTimescale: CMTimeScale(NSEC_PER_SEC))
        timeObserverToken = self.addPeriodicTimeObserver(forInterval: interval, queue: .main) {
            [weak self] _ in
            self?.currentTimeInSeconds = self?.currentTime().seconds ?? 0.0
        }
        
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        guard keyPath == "currentItem" else { return }
        guard let item = currentItem  else { return }
            
        NotificationCenter.default.addObserver(self, selector: #selector(playerDidFinishPlaying(_:)), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: item)
        
    }
    
    @objc private func playerDidFinishPlaying(_ notification: Notification) {
        playNextSong()
    }
    
    // MARK: player controls
    func playPausePlayer() {
        
        if currentItem == nil {
            setCurrentItem(withSong: songList[0])
        }
        
        if isPlaying {
            self.pause()
        } else {
            self.play()
        }
        
        isPlaying.toggle()
        
    }
    
    func playNextSong() {
        // TODO
        
    }
    
    func playPreviuosSong() {
        // TODO
    }
    
    private func setCurrentItem(withSong song: Song) {
        
        // TODO: https://developer.apple.com/documentation/avfoundation/media_assets_playback_and_editing/responding_to_playback_state_changes
        guard let url = URL(string: song.url) else { return }
        currentSong = song
        let playerItem = AVPlayerItem(url: url)
        self.replaceCurrentItem(with: playerItem)
        
    }
    
    func rewindTime(to seconds: Double) {
        let timeCM = CMTime(seconds: seconds, preferredTimescale: CMTimeScale(NSEC_PER_SEC))
        self.seek(to: timeCM)
    }
    
    // MARK: deiniting
    deinit {
        
        self.removeObserver(self, forKeyPath: "currentItem")
        
        if let token = timeObserverToken {
            self.removeTimeObserver(token)
            timeObserverToken = nil
        }
        
    }
    
}
