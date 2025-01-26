//
//  LoadingSwiftUIView.swift
//  MarvelComics
//
//  Created by Gary Dos Santos de Andrade on 26/1/25.
//

import SwiftUI
import WebKit

extension Loading.View {
    struct SwiftUIView: View {
        var body: some View {
            ZStack {
                Color(Loading.Constants.backgroundColor)
                    .edgesIgnoringSafeArea(.all)
                
                GifImageView()
                    .background(Color.clear)
                    .frame(
                        width: Loading.Constants.Size.loaderSize,
                        height: Loading.Constants.Size.loaderSize,
                        alignment: .center
                    )
                    .scaledToFit()
            }
        }
    }
    
    private struct GifImageView: UIViewRepresentable {
        func makeUIView(context: Context) -> WKWebView {
            let webview = WKWebView()
            guard let url = Bundle.main.url(
                forResource: Loading.Constants.gifName,
                withExtension: Loading.Constants.gifExtension
            ), let data = try? Data(contentsOf: url) else {
                return WKWebView()
            }
            webview.load(
                data,
                mimeType: Loading.Constants.mimeType,
                characterEncodingName: Loading.Constants.encoding,
                baseURL: url.deletingLastPathComponent()
            )
            return webview
        }
        func updateUIView(_ uiView: WKWebView, context: Context) {
            uiView.reload()
        }
    }
}
