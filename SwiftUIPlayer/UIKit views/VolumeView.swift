//
//  VolumeView.swift
//  SwiftUIPlayer
//
//  Created by Александр on 31.12.2019.
//  Copyright © 2019 Александр. All rights reserved.
//

import SwiftUI
import UIKit
import MediaPlayer

struct VolumeView: View {
    
    var body: some View {
        
        HStack(alignment: .center) {
            
            Image(systemName: "volume")
            
                MPVolumeViewRepresenter()
                    .frame(height: 24)
                    .offset(y: 2)
            
            Image(systemName: "volume.3")
            
        }.padding(.horizontal)
        
    }
    
}

struct MPVolumeViewRepresenter: UIViewRepresentable {
    
    
    func makeUIView(context: Context) -> MPVolumeView {
        let volumeView = MPVolumeView()
//        volumeView.showsRouteButton = false // TODO: deprecated
        return volumeView
    }
    
    func updateUIView(_ uiView: MPVolumeView, context: UIViewRepresentableContext<MPVolumeViewRepresenter>) {
        // ...
    }
    
}

struct VolumeView_Previews: PreviewProvider {
    static var previews: some View {
        VolumeView()
    }
}
