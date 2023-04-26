//
//  StartView.swift
//  PhotoBooth
//
//  Created by ksd on 26/04/2023.
//

import SwiftUI

struct StartView: View {
    var body: some View {
        TabView {
            ContentView()
                .tabItem {
                    Label("Et Billede", systemImage: "photo")
                }
            MultiImagePickerView()
                .tabItem {
                    Label("Flere Billeder", systemImage: "photo.on.rectangle.angled")
                    
                }
        }
    }
}

struct StartView_Previews: PreviewProvider {
    static var previews: some View {
        StartView()
    }
}
