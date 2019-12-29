//
//  UserData.swift
//  SwiftUIPlayer
//
//  Created by Александр on 29.12.2019.
//  Copyright © 2019 Александр. All rights reserved.
//

import Combine
import SwiftUI

final class UserData: ObservableObject {
    
    @Published var songList = songListData
    
}
