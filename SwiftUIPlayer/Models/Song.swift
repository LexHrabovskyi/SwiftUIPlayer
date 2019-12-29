//
//  Song.swift
//  SwiftUIPlayer
//
//  Created by Александр on 29.12.2019.
//  Copyright © 2019 Александр. All rights reserved.
//

import Foundation

struct Song: Hashable, Codable, Identifiable {
    
    let id: Int
    let name: String
    let url: String
    let lenght: Double
    
}
