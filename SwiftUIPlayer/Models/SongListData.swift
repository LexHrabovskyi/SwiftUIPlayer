//
//  SongListData.swift
//  SwiftUIPlayer
//
//  Created by Александр on 29.12.2019.
//  Copyright © 2019 Александр. All rights reserved.
//

import Foundation

class Playlist: ObservableObject {
    
    let songListData: [Song] = load("SongList.json")
    var currentSong: Song? = nil
    
    func setCurrentSong(_ song: Song) {
         currentSong = song
    }
    
    func setNextSong(_ backward: Bool = false) {
        
        guard let _ = currentSong else {
            currentSong = songListData.first!
            return
        }
        
        let currentIndex = songListData.firstIndex(of: currentSong!)!
        var nextIndex = 0
        
        if backward {
            let zeroIndex = currentIndex == 0
            nextIndex = zeroIndex ? songListData.count - 1 : currentIndex - 1
        } else {
            let lastIndex = (currentIndex == songListData.count - 1)
            nextIndex = lastIndex ? 0 : currentIndex + 1
        }
        
        currentSong = songListData[nextIndex]
        
    }
    
}

func load<T: Decodable>(_ filename: String, as type: T.Type = T.self) -> T {
    
    let data: Data
    
    guard let file = Bundle.main.url(forResource: filename, withExtension: nil) else {
        fatalError("Couldn't find \(filename) in main bundle.")
    }
    
    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
    }
    
    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
    }
    
}
