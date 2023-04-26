//
//  ImagePicker.swift
//  PhotoBooth
//
//  Created by ksd on 26/04/2023.
//

import SwiftUI
import PhotosUI

@MainActor // betyder at klassens kode ALTID kører på main thread
class ImagePicker: ObservableObject {
    
    @Published var images: [Image] = []
    @Published var imageSelections: [PhotosPickerItem] = [] {
        didSet {
            Task {
                if !imageSelections.isEmpty {
                    try await loadTransferable(from: imageSelections)
                    imageSelections = []
                }
            }
        }
    }
    
    
    func loadTransferable(from imageSelections: [PhotosPickerItem]) async throws {
        do  {
            for imageSelection in imageSelections {
                if let data = try await imageSelection.loadTransferable(type: Data.self)  {
                    if let uiImage = UIImage(data: data) {
                        self.images.append(Image(uiImage: uiImage))
                    }
                }
            }
        } catch {
            fatalError("Kaj er en spade")
        }
    }
}
