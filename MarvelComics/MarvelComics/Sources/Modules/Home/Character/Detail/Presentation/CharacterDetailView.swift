import UIKit
import Kingfisher
import SwiftUI

extension Character.Detail {
    struct MainView: View {
        @StateObject private var viewModel: ViewModel
        private let isPreview: Bool

        init(viewModel: ViewModel, isPreview: Bool = false) {
            _viewModel = StateObject(wrappedValue: viewModel)
            self.isPreview = isPreview
        }

        var body: some View {
            GeometryReader {
                let safeArea = $0.safeAreaInsets
                let size = $0.size
                ContentView(
                    safeArea: safeArea,
                    size: size,
                    viewModel: viewModel,
                    isPreview: isPreview
                ).ignoresSafeArea(.container, edges: .top)
            }
        }
    }

    struct ContentView: View {
        private var safeArea: EdgeInsets
        private var size: CGSize
        private let isPreview: Bool
        @ObservedObject private var viewModel: ViewModel
        @State private var isSharing = false

        public init(
            safeArea: EdgeInsets,
            size: CGSize,
            viewModel: ViewModel,
            isPreview: Bool = false
        ) {
            self.safeArea = safeArea
            self.size = size
            self.isPreview = isPreview
            _viewModel = ObservedObject(wrappedValue: viewModel)
        }

        var body: some View {
            ZStack {
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
                    ScrollView(.vertical, showsIndicators: false) {
                        VStack {
                            makeCharacterHeaderView(with: model)
                            VStack {
                                Text(Character.Detail.Constants.Success.title)
                                    .padding(Character.Detail.Constants.Success.padding)
                                    .fontWeight(.heavy)
                                makeSeriesListView(with: model)
                            }
                        }
                        .overlay(alignment: .top) {
                            makeNavBarView(with: {
                                viewModel.onBackButtonClicked()
                            }, model: model)
                        }
                    }
                    .coordinateSpace(name: "SCROLL")
                }
            }.onAppear {
                guard !isPreview else { return }
                viewModel.onAppear()
            }
            .animation(.easeInOut, value: viewModel.state)
        }
    }
}

// Mark: - Series List View -

extension Character.Detail.ContentView {
    @ViewBuilder
    func makeSeriesListView(with model: Any?) -> some View {
        if let model = model as? Character.Detail.Model,
           let series = model.series {
            VStack(spacing: Character.Detail.Constants.Series.padding) {
                ForEach(series.indices, id: \.self) { index in
                    HStack(spacing: Character.Detail.Constants.Series.padding) {
                        KFImage(url: series[index].thumbnail)
                            .placeholder {
                                Image(uiImage: UIImage.imageNotAvailable)
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(
                                        width: Character.Detail.Constants.Series.width,
                                        height: Character.Detail.Constants.Series.height
                                    )
                            }
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(
                                width: Character.Detail.Constants.Series.width,
                                height: Character.Detail.Constants.Series.height
                            )
                            .clipShape(RoundedRectangle(cornerRadius: Character.Detail.Constants.Series.cornerRadius)
                            )
                            .clipped()

                        VStack(alignment: .leading) {
                            Text(series[index].title)
                                .font(.headline)
                                .fontWeight(.semibold)
                                .foregroundColor(.black)

                            VStack(alignment: .leading) {
                                if let description = series[index].description {
                                    Text(description)
                                        .font(.footnote)
                                        .lineLimit(Character.Detail.Constants.Series.descriptionMaxLines)
                                        .foregroundColor(.gray)
                                }
                                if let formattedYears = series[index].formattedYears {
                                    Text(formattedYears)
                                        .font(.caption)
                                        .foregroundColor(.primary)
                                }
                                Image(uiImage: series[index].rating.image)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(
                                        width: Character.Detail.Constants.Series.ratingImageSize,
                                        height: Character.Detail.Constants.Series.ratingImageSize
                                    )
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }.padding([.horizontal], Character.Detail.Constants.Series.padding)

                }
            }.background(.white)
        } else {
            EmptyView()
        }
    }
}

// MARK: - Header View -

extension Character.Detail.ContentView {
    @ViewBuilder
    func makeCharacterHeaderView(with model: Any?) -> some View {
        if let model = model as? Character.Detail.Model {
            let height = size.height * Character.Detail.Constants.Header.heightPercentage
            GeometryReader { proxy in

                let size = proxy.size
                let minY = proxy.frame(in: .named("SCROLL")).minY
                let progress = minY / (height * (minY > 0 ? 0.5 : 0.8))

                KFImage(url: model.character?.thumbnail)
                    .placeholder {
                        Image(uiImage: UIImage.imageNotAvailable)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: size.width, height: size.height + (minY > 0 ? minY : 0))
                    }
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: size.width, height: size.height + (minY > 0 ? minY : 0 ))
                    .clipped()
                    .overlay(content: {
                        ZStack(alignment: .bottom) {
                            Rectangle()
                                .fill(
                                    .linearGradient(colors: [
                                        .black.opacity(0 - progress),
                                        .black.opacity(0.1 - progress),
                                        .black.opacity(0.3 - progress),
                                        .black.opacity(0.5 - progress),
                                        .black.opacity(0.8 - progress),
                                        .black.opacity(1),
                                    ], startPoint: .top, endPoint: .bottom)
                                )
                            VStack(spacing: .zero) {
                                Text(model.character?.name ?? "")
                                    .foregroundColor(.white)
                                    .font(Character.Detail.Constants.Header.titleFont)
                                    .multilineTextAlignment(.center)
                            }
                            .opacity(1 + (progress > 0 ? -progress : progress))
                            .padding(.bottom, Character.Detail.Constants.Header.bottomPadding)
                            .offset(y: minY < 0 ? minY : 0 )
                        }
                    })
                    .offset(y: -minY)
            }
            .frame(height: height + safeArea.top)
        } else {
            EmptyView()
        }
    }
}

// MARK: - NavBar View -

extension Character.Detail.ContentView {
    @ViewBuilder
    func makeNavBarView(
        with onBackButtonClicked: @escaping () -> Void,
        model: Any?
    ) -> some View {
        if let model = model as? Character.Detail.Model {
            let height = size.height * 0.45
            GeometryReader { proxy in
                let minY = proxy.frame(in: .named("SCROLL")).minY
                let height = size.height * 0.45
                let progress = minY / (height * (minY > 0 ? 0.5 : 0.8))
                let titleProgress =  minY / height

                HStack(spacing: 15) {
                    Button {
                        onBackButtonClicked()
                    } label: {
                        Image.iconBack
                            .foregroundColor(.white)
                    }
                    Spacer(minLength: 0)

                    Button {
                        isSharing.toggle()
                    } label: {
                        Image.iconShare
                            .foregroundColor(.white)
                    }.sheet(isPresented: $isSharing) {
                        ShareSheet(activityItems: [
                            model.character?.name ?? "",
                            Character.Detail.Constants.marvelUrl]
                        )
                    }
                }
                .overlay(content: {
                    Text(model.character?.name ?? "")
                        .foregroundColor(.white)
                        .fontWeight(.semibold)
                        .offset(y: -titleProgress > 0.75 ? 0 : 45)
                        .clipped()
                        .animation(.easeOut(duration: 0.25), value: -titleProgress > 0.75)
                })
                .padding(.top, safeArea.top)
                .padding([.horizontal,.bottom], 15)
                .background(
                    ZStack {
                        KFImage(url: model.character?.thumbnail)
                            .placeholder {
                                Image(uiImage: UIImage.imageNotAvailable)
                                    .resizable()
                                    .blur(radius: 20.0, opaque: true)
                                    .frame(height: 100)
                                    .aspectRatio(contentMode: .fill)

                            }
                            .resizable()
                            .blur(radius: 20.0, opaque: true)
                            .frame(height: 100)
                            .scaledToFill()
                            .clipped()
                        Color.black.opacity(0.5)
                    }.opacity(-progress > 1 ? 1 : 0)
                )
                .offset(y: -minY)
            }
            .frame(height: height)
        } else {
            EmptyView()
        }
    }
}

// MARK: - Share Content -

extension Character.Detail.ContentView {
    struct ShareSheet: UIViewControllerRepresentable {
        var activityItems: [Any]

        func makeUIViewController(context: Context) -> UIActivityViewController {
            let activityViewController = UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
            return activityViewController
        }

        func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {
            // No updates needed in this case
        }
    }
}

// MARK: - PreviewsS -

struct CharacterDetailContenView_Previews: PreviewProvider {
    static var previews: some View {
        return Character.Detail.MainView(
            viewModel: .preview,
            isPreview: true
        )
    }
}

struct CharacterDetailContenViewError_Previews: PreviewProvider {
    static var previews: some View {
        return Character.Detail.MainView(
            viewModel: .previewError,
            isPreview: true
        )
    }
}

struct CharacterDetailContenViewLoading_Previews: PreviewProvider {
    static var previews: some View {
        return Character.Detail.MainView(
            viewModel: .previewLoading,
            isPreview: true
        )
    }
}
