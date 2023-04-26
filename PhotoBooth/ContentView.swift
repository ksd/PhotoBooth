//
//  ContentView.swift
//  PhotoBooth
//
//  Created by ksd on 26/04/2023.
//

import SwiftUI
import PhotosUI

struct ContentView: View {
    @State private var showPicturePicker = false
    @State private var selectedItem: PhotosPickerItem?
    @State private var selectedImage: Image?
    
    var body: some View {
        VStack {
            if let selectedImage {
                selectedImage
                    .resizable()
                    .foregroundColor(.gray)
                    .scaledToFit()
                .frame(width: 200)
                    .padding()
            } else {
                Image(systemName: "globe")
                    .imageScale(.large)
                    .foregroundColor(.accentColor)
            }
            Button("Vælg Billede"){
                showPicturePicker.toggle()
            }.buttonStyle(.bordered)
        }
        .padding()
        .photosPicker(isPresented: $showPicturePicker,
                      selection: $selectedItem,
                      matching: .images)
        .onChange(of: selectedItem) { newValue in
            Task {
                if let imageData = try? await newValue?.loadTransferable(type: Data.self),
                   let image = UIImage(data: imageData) {
                    selectedImage = Image(uiImage: image)
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
