//
//  ComicDetailView.swift
//  MarvelComics
//
//  Created by Gary Dos Santos de Andrade on 3/2/25.
//

import Foundation
import SwiftUI

extension Comic.Detail {
    struct MainView: View {
        @State private var scrollOffset: CGFloat = 0
        @StateObject private var viewModel: ViewModel
        private let isPreview: Bool

        init(viewModel: ViewModel, isPreview: Bool = false) {
            _viewModel = StateObject(wrappedValue: viewModel)
            self.isPreview = isPreview
        }


        var body: some View {
            ZStack(alignment: .top) {
                // ScrollView positioned below the navbar
                VStack(spacing: .zero) {
                    Spacer().frame(height: 100) // Space for navbar

                    ScrollView {
                        VStack(spacing: 20.0)  {
                            GeometryReader { geometry in
                                Color.clear
                                    .onAppear {
                                        scrollOffset = 0
                                    }
                                    .onChange(of: geometry.frame(in: .global).minY) { _, newOffset in
                                        withAnimation(.easeInOut(duration: 0.2)) {
                                            scrollOffset = -newOffset
                                        }
                                    }
                            }.frame(height: 0)

                            makeComicHeaderView()
                            makeSeriesView()
                            makeEventsView()
                            makeCreatorsView()
                        }
                    }
                }
                makeNavBarView()
            }
            .edgesIgnoringSafeArea(.top)
        }
    }
}

// MARK: - Series View -

extension Comic.Detail.MainView {
    @ViewBuilder
    func makeSeriesView(
    ) -> some View {
        VStack(alignment: .leading) {
            // Horizontal Scroll Views
            Text("Recommended Series")
                .font(.headline)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    ForEach(1...5, id: \.self) { index in
                        Image(uiImage: UIImage.imageNotAvailable)
                            .resizable()
                            .frame(width: 220, height: 140)
                            .cornerRadius(12)
                    }
                }
            }
        }.padding(.horizontal)

    }
}

// MARK: - Events View -

extension Comic.Detail.MainView {
    @ViewBuilder
    func makeEventsView(
    ) -> some View {
        VStack(alignment: .leading) {
            // Horizontal Scroll Views
            Text("Upcomming Events")
                .font(.headline)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 10) {
                    ForEach(1...5, id: \.self) { index in
                        VStack(alignment: .leading, spacing: 8) {
                            Text("event.date")
                                .font(.caption)
                                .fontWeight(.bold)
                                .foregroundColor(.gray)

                            Text("event.title")
                                .font(.headline)
                                .foregroundColor(.primary)

                            Text("event.location")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                        .padding()
                        .frame(width: 180, alignment: .leading)
                        .background(Color(.systemGray6))
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                    }
                }
            }
        }.padding(.horizontal)
    }
}

// MARK: - Creators View -

extension Comic.Detail.MainView {
    @ViewBuilder
    func makeCreatorsView(
    ) -> some View {
        VStack(alignment: .leading) {
            // Horizontal Scroll Views
            Text("Recommended Creators")
                .font(.headline)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 10) {
                    ForEach(1...5, id: \.self) { index in
                        Image(uiImage: UIImage.imageNotAvailable)
                            .resizable()
                            .frame(width: 90, height: 90)
                            .clipShape(Circle())
                            .overlay(
                                Circle().stroke(Color.black.opacity(0.7), lineWidth: 2)
                                    .padding(1)// Adds a gray border
                            )

                    }
                }
            }
        }.padding(.horizontal)
    }
}


// MARK: - NavBar View -

extension Comic.Detail.MainView {
    @ViewBuilder
    func makeNavBarView(
    ) -> some View {
        // Custom Navigation Bar
        ZStack {
            // Background blur effect that appears when scrolling
            Image(uiImage: UIImage.imageNotAvailable)
                .resizable()
                .scaledToFill()
                .blur(radius: 20.0, opaque: true)
                .frame(height: 100)
                .clipped()
                .opacity(min(scrollOffset / 100, 1)) // Gradual fade-in effect
        }
        .frame(height: 100)
        .background(.ultraThinMaterial.opacity(min(scrollOffset / 100, 1))) // Ensures smooth fade-in
        .animation(.easeInOut, value: scrollOffset)

        // Back button with circular background
        HStack {
            Button(action: { /* Handle back action */ }) {
                Image.iconBack
                    .foregroundColor(.white)
                    .frame(width: 40, height: 40)
                    .background(scrollOffset > 50 ? Color.clear : Color.black.opacity(0.3))
                    .clipShape(Circle())
                    .animation(.easeInOut, value: scrollOffset)
            }
            .padding(.leading, 16)
            Spacer()
        }       .overlay(content: {
            Text("ComicName")
                .foregroundColor(scrollOffset > 50 ? Color.white: Color.clear)
                .fontWeight(.semibold)
                .clipped()
        })
        .padding(.top, 50) // Adjust for safe area
    }
}

// MARK: - Comic Header View -

extension Comic.Detail.MainView {
    @ViewBuilder
    func makeComicHeaderView(
    ) -> some View {
        // Header
        VStack(alignment: .leading) {
            ZStack(alignment: .bottom) {
                Image(uiImage: UIImage.imageNotAvailable)
                    .resizable()
                    .frame(height: UIScreen.main.bounds.height * 0.40)
                    .clipped()
                    .cornerRadius(12)

                HStack {
                    VStack(alignment: .leading) {
                        Text("#6")
                            .font(.title)
                            .bold()
                            .foregroundColor(.white)
                        Text("Pasteles espaciales")
                            .foregroundColor(.white.opacity(0.8))
                    }
                    Spacer()
                    Button(action: {}) {
                        HStack {
                            Image(systemName: "checkmark.circle.fill")
                            Text("Got it!")
                        }
                        .padding(.horizontal, 12)
                        .padding(.vertical, 6)
                        .background(Color.green)
                        .foregroundColor(.white)
                        .clipShape(Capsule())
                    }
                }
                .padding()
                .background(LinearGradient(gradient: Gradient(colors: [Color.black.opacity(0.7), Color.clear]), startPoint: .bottom, endPoint: .top))
            }
            .clipShape(RoundedRectangle(cornerRadius: 12))

            // Comic info
            VStack(alignment: .leading, spacing: 8) {
                Text("Chew")
                    .font(.headline)
                HStack {
                    Image(systemName: "star.fill")
                        .foregroundColor(.yellow)
                    Text("4.5 · 45 reviews")
                }
                Text("Jul 2013")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }.padding(.top, 10.0)
        }.padding(.horizontal)
    }
}

struct ComicDetailMainView_Previews: PreviewProvider {
    static var previews: some View {
        return Comic.Detail.MainView(viewModel: .preview)
    }
}

