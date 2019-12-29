//
//  ContentView.swift
//  SwiftUIPlayer
//
//  Created by Александр on 29.12.2019.
//  Copyright © 2019 Александр. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var userData: UserData
    
    var body: some View {
        Text("Hello World")
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
