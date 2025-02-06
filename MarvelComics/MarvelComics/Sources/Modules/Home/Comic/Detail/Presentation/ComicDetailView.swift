//
//  ComicDetailView.swift
//  MarvelComics
//
//  Created by Gary Dos Santos de Andrade on 3/2/25.
//

import Foundation
import SwiftUI
import Kingfisher

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
                switch viewModel.state {
                case .none: EmptyView()
                case .loading:
                    Loading.View.SwiftUIView()
                        .transition(.opacity)
                        .zIndex(1)
                case .failure(let error):
                    Alert.MainView(model: .defaultError(
                        with: error.name,
                        actionHandler: {
                            viewModel.onBackButtonClicked()
                        }))
                case .success(let model):
                    VStack(spacing: .zero) {
                        Spacer().frame(height: Constants.navBarHeight)

                        ScrollView(showsIndicators: false) {
                            VStack(spacing: 20.0)  {
                                GeometryReader { geometry in
                                    Color.clear
                                        .onAppear {
                                            scrollOffset = .zero
                                        }
                                        .onChange(of: geometry.frame(in: .global).minY) { _, newOffset in
                                            withAnimation(.easeInOut(duration: 0.2)) {
                                                scrollOffset = -newOffset
                                            }
                                        }
                                }.frame(height: .zero)
                                makeComicHeaderView(with: model)
                                makeCharactersView(with: model)
                                makeStoriesView(with: model)
                                makeCreatorsView(with: model)
                            }
                        }
                    }
                    makeNavBarView(
                        with: model,
                        onBackButtonClicked: { viewModel.onBackButtonClicked() }
                    )
                }
            }.onAppear{
                guard !isPreview else { return }
                viewModel.onAppear()
            }
            .edgesIgnoringSafeArea(.top)
        }
    }
}

// MARK: - Characters View -

extension Comic.Detail.MainView {
    @ViewBuilder
    func makeCharactersView(
        with model: Any?
    ) -> some View {
        if let model = model as? Comic.Detail.Model,
           let characters = model.characters, !characters.isEmpty {
            VStack(alignment: .leading) {
                // Horizontal Scroll Views
                Text(Constants.Characters.title)
                    .font(.headline)
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: Constants.Characters.spacing) {
                        ForEach(characters.indices, id: \.self) { index in
                            ZStack {
                                KFImage(characters[index].thumbnail)
                                    .placeholder {
                                        Image(uiImage: UIImage.imageNotAvailable)
                                            .resizable()
                                            .frame(
                                                width: Constants.Characters.width,
                                                height: Constants.Characters.height
                                            )
                                            .cornerRadius(Constants.Characters.cornerRadius)
                                    }
                                    .resizable()
                                    .frame(
                                        width: Constants.Characters.width,
                                        height: Constants.Characters.height
                                    )
                                    .cornerRadius(Constants.Characters.cornerRadius)

                                LinearGradient(
                                    gradient: Gradient(colors: [.clear, .black]),
                                    startPoint: .top,
                                    endPoint: .bottom
                                )
                                .frame(
                                    width: Constants.Characters.width,
                                    height: Constants.Characters.height
                                ).cornerRadius(Constants.Characters.cornerRadius)

                                VStack {
                                    Spacer()
                                    Text(characters[index].name)
                                        .foregroundColor(.white)
                                        .font(.subheadline)
                                        .lineLimit(2)
                                        .padding(.all, Constants.Characters.padding)
                                        .frame(maxWidth: .infinity)
                                }
                                .frame(
                                    width: Constants.Characters.width,
                                    height: Constants.Characters.height
                                )
                            }
                        }
                    }
                }
            }.padding(.horizontal)
        } else {
            EmptyView()
        }
    }
}

// MARK: - Stories View -

extension Comic.Detail.MainView {
    @ViewBuilder
    func makeStoriesView(
        with model: Any?
    ) -> some View {
        if let model = model as? Comic.Detail.Model,
           let stories = model.stories, !stories.isEmpty {
            VStack(alignment: .leading) {
                Text(Constants.Stories.title)
                    .font(.headline)
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: Constants.Stories.horizontalSpacing) {
                        ForEach(stories.indices, id: \.self) { index in
                            VStack(alignment: .leading, spacing: 8) {
                                Text(stories[index].type.name)
                                    .font(.caption)
                                    .fontWeight(.bold)
                                    .foregroundColor(.gray)

                                Text(stories[index].title)
                                    .lineLimit(1)
                                    .truncationMode(.tail)
                                    .font(.headline)
                                    .foregroundColor(.primary)

                                if let date = stories[index].date?.toString() {
                                    Text(date)
                                        .font(.subheadline)
                                        .foregroundColor(.secondary)
                                }
                            }
                            .padding()
                            .frame(
                                width: Constants.Stories.width,
                                alignment: .leading
                            )
                            .background(Color(.systemGray6))
                            .clipShape(
                                RoundedRectangle(cornerRadius: Constants.Stories.cornerRadius)
                            )
                        }
                    }
                }
            }.padding(.horizontal)
        } else {
            EmptyView()
        }
    }
}

// MARK: - Creators View -

extension Comic.Detail.MainView {
    @ViewBuilder
    func makeCreatorsView(
        with model : Any?
    ) -> some View {
        if let model = model as? Comic.Detail.Model,
           let creators = model.creators, !creators.isEmpty {
            VStack(alignment: .leading) {
                Text(Constants.Creators.title)
                    .font(.headline)
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: Constants.Creators.horizontalSpacing) {
                        ForEach(creators.indices, id: \.self) { index in
                            ZStack {
                                KFImage(creators[index].thumbnail)
                                    .placeholder {
                                        Image(uiImage: UIImage.imageNotAvailable)
                                            .resizable()
                                            .frame(
                                                width: Constants.Creators.size,
                                                height: Constants.Creators.size
                                            )
                                            .clipShape(Circle())
                                    }.resizable()
                                    .frame(
                                        width: Constants.Creators.size,
                                        height: Constants.Creators.size
                                    )
                                    .clipShape(Circle())

                                LinearGradient(
                                    gradient: Gradient(colors: [.clear, .black]),
                                    startPoint: .top,
                                    endPoint: .bottom
                                )
                                .frame(
                                    width: Constants.Creators.size,
                                    height: Constants.Creators.size
                                )
                                .clipShape(Circle())

                                VStack {
                                    Spacer()
                                    Text(creators[index].fullName)
                                        .foregroundColor(.white)
                                        .font(.caption)
                                        .lineLimit(2)
                                        .padding(.bottom, Constants.Creators.paddingBottom)
                                        .padding(.horizontal, Constants.Creators.paddingHorizontal)
                                        .frame(maxWidth: .infinity)
                                }
                                .frame(
                                    width: Constants.Creators.size,
                                    height: Constants.Creators.size
                                )
                            }
                        }
                    }
                }
            }.padding(.horizontal)
        } else {
            EmptyView()
        }
    }
}


// MARK: - NavBar View -

extension Comic.Detail.MainView {
    @ViewBuilder
    func makeNavBarView(
        with model : Any?,
        onBackButtonClicked: @escaping () -> Void
    ) -> some View {
        let model = model as? Comic.Detail.Model
        let maxScrollOffset = Constants.navBarHeight / 2
        ZStack {
            KFImage(model?.comic?.thumbnail)
                .placeholder {
                    Image(uiImage: UIImage.imageNotAvailable)
                        .resizable()
                        .scaledToFill()
                        .blur(radius: Constants.NavBar.blur, opaque: true)
                        .frame(height: Constants.navBarHeight)
                        .clipped()
                        .opacity(min(scrollOffset / Constants.navBarHeight, 1))
                }.resizable()
                .scaledToFill()
                .blur(radius: Constants.NavBar.blur, opaque: true)
                .frame(height: Constants.navBarHeight)
                .clipped()
                .opacity(min(scrollOffset / Constants.navBarHeight, 1))
        }
        .frame(height: Constants.navBarHeight)
        .background(.ultraThinMaterial.opacity(min(scrollOffset / Constants.navBarHeight, 1)))
        .animation(.easeInOut, value: scrollOffset)

        HStack {
            Button(action: {
                onBackButtonClicked()
            }) {
                Image.iconBack
                    .foregroundColor(.white)
                    .frame(
                        width: Constants.NavBar.size,
                        height: Constants.NavBar.size
                    )
                    .background(scrollOffset > maxScrollOffset ? Color.clear : Constants.NavBar.opacityColor)
                    .clipShape(Circle())
                    .animation(.easeInOut, value: scrollOffset)
            }
            .padding(.leading, Constants.NavBar.padding)
            Spacer()
        }       .overlay(content: {
            Text(model?.comic?.title ?? "")
                .foregroundColor(scrollOffset > maxScrollOffset ? Color.white: Color.clear)
                .lineLimit(1)
                .truncationMode(.tail)
                .fontWeight(.semibold)
                .frame(
                    maxWidth: UIScreen.main.bounds.width - Constants.NavBar.horizontalPadding,
                    alignment: .center
                )
                .clipped()
        })
        .padding(.top, maxScrollOffset)
    }
}

// MARK: - Comic Header View -

extension Comic.Detail.MainView {
    @ViewBuilder
    func makeComicHeaderView(
        with model: Any?
    ) -> some View {
        if let model = model as? Comic.Detail.Model,
           let comic = model.comic {
            VStack(alignment: .leading) {
                let height = UIScreen.main.bounds.height
                let width = UIScreen.main.bounds.width
                ZStack(alignment: .bottom) {
                    KFImage(comic.thumbnail)
                        .placeholder {
                            Image(uiImage: UIImage.imageNotAvailable)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(
                                    width: Constants.Header.getWidth(with: width),
                                    height: Constants.Header.getHeight(with: height)
                                )
                                .clipped()
                                .cornerRadius(Constants.Header.cornerRadius)
                                .padding(.horizontal, 10.0)
                        }.resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(
                            width: Constants.Header.getWidth(with: width),
                            height: Constants.Header.getHeight(with: height)
                        )
                        .cornerRadius(Constants.Header.cornerRadius)
                        .clipped()
                        .padding(.horizontal, 10.0)

                    HStack {
                        VStack(alignment: .leading) {
                            Text(comic.title)
                                .font(.title)
                                .bold()
                                .foregroundColor(.white)
                        }
                        Spacer()
                    }
                    .padding()
                    .background(Constants.Header.linearGradient)
                }.frame(
                    width: Constants.Header.getWidth(with: width),
                    height: Constants.Header.getHeight(with: height)
                )
                .clipShape(RoundedRectangle(cornerRadius: Constants.Header.cornerRadius))

                // Comic info
                VStack(alignment: .leading, spacing: Constants.Header.spacing) {
                    Text(comic.title)
                        .font(.headline)
                    if let price = comic.price {
                        HStack {
                            Constants.Header.cartImage
                            Text(price)
                        }
                    }
                    if let date = comic.date?.toString() {
                        Text(date)
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                }.padding(.top, Constants.Header.spacingTop)
            }.padding(.horizontal)
        } else {
            EmptyView()
        }
    }
}

// MARK: - Previews -

struct ComicDetailMainView_Previews: PreviewProvider {
    static var previews: some View {
        return Comic.Detail.MainView(viewModel: .preview, isPreview: true)
    }
}
