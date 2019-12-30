//
//  SongListData.swift
//  SwiftUIPlayer
//
//  Created by Александр on 29.12.2019.
//  Copyright © 2019 Александр. All rights reserved.
//

import Foundation

class SongList {
    
    let songListData: [Song] = load("SongList.json")
    var currentSong: Song {
        get {
            return songListData[songIndex]
        }
    }
    
    private var songIndex = 0
    
    func setNextSong() {
        
        if songIndex + 1 == songListData.count {
            songIndex = 0
        } else {
            songIndex += 1
        }
        
    }
    
    func setPreviousSong() {
        
        if songIndex == 0 {
            songIndex = songListData.count - 1
        } else {
            songIndex -= 1
        }
        
    }
    
}



func load<T: Decodable>(_ filename: String, as type: T.Type = T.self) -> T {
    let data: Data
    
    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
    else {
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
