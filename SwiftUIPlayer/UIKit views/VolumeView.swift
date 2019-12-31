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
            Image("MVvolumeDown")
                .renderingMode(.original)
                .resizable()
                .frame(width: 24, height: 24)
            
                MPVolumeViewRepresenter()
                    .frame(height: 24)
                    .offset(y: 2)
            
            Image("MVvolumeUp")
                .renderingMode(.original)
                .resizable()
                .frame(width: 24, height: 24)
            
        }.padding(.horizontal)
        
    }
    
}

struct MPVolumeViewRepresenter: UIViewRepresentable {
    
    
    func makeUIView(context: Context) -> MPVolumeView {
        
        let volumeView = MPVolumeView()
//        if let sliderView = volumeView.subviews.first as? UISlider {
//            sliderView.minimumTrackTintColor = UIColor(red: 0.805, green: 0.813, blue: 0.837, alpha: 1)
//            sliderView.thumbTintColor = UIColor(red: 0.805, green: 0.813, blue: 0.837, alpha: 1)
//            sliderView.maximumTrackTintColor = UIColor(red: 0.906, green: 0.91, blue: 0.929, alpha: 1)
//        }
        
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
