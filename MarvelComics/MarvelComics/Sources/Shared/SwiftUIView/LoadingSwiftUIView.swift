//
//  LoadingSwiftUIView.swift
//  MarvelComics
//
//  Created by Gary Dos Santos de Andrade on 26/1/25.
//

import SwiftUI
import Kingfisher

extension Loading.View {
    struct GIFView: UIViewRepresentable {
        let gifName: String
        let gifExtension: String

        func makeUIView(context: Context) -> UIImageView {
            let imageView = UIImageView()
            imageView.contentMode = .scaleAspectFit
            imageView.translatesAutoresizingMaskIntoConstraints = false
            return imageView
        }

        func updateUIView(_ uiView: UIImageView, context: Context) {
            // Load the gif from the bundle
            if let path = Bundle.main.url(forResource: gifName, withExtension: gifExtension) {
                let resource = LocalFileImageDataProvider(fileURL: path)
                uiView.kf.setImage(with: resource)
            }
            uiView.frame.size = CGSize(width: 10.0, height: 10.0)
        }
    }

    struct ContentView: View {
        var body: some View {
            ZStack {
                // Full black background
                Color.black
                    .edgesIgnoringSafeArea(.all)

                // Centered GIF view
                GIFView(gifName: "loading", gifExtension: "gif")
                    .frame(width: 100, height: 100)
                    .scaledToFit() // Set the size of the GIF
            }
        }
    }
}
