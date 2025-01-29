import UIKit
import Kingfisher
import SwiftUI

extension Character.Detail {
    struct MainView: View {
        @StateObject private var viewModel: ViewModel

        init(viewModel: ViewModel) {
            _viewModel = StateObject(wrappedValue: viewModel)
        }

        var body: some View {
            GeometryReader {
                let safeArea = $0.safeAreaInsets
                let size = $0.size
                ContentView(
                    safeArea: safeArea,
                    size: size,
                    viewModel: viewModel
                ).ignoresSafeArea(.container, edges: .top)
            }
        }
    }

    struct ContentView: View {
        private var safeArea: EdgeInsets
        private var size: CGSize
        @ObservedObject private var viewModel: ViewModel

        public init(safeArea: EdgeInsets, size: CGSize, viewModel: ViewModel) {
            self.safeArea = safeArea
            self.size = size
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
                    AlertSwiftUIView(model: .defaultError(
                        with: error.localizedDescription,
                        actionHandler: {
                            viewModel.onBackButtonClicked()
                        }))
                case .success(let model):
                    ScrollView(.vertical, showsIndicators: false) {
                        VStack{
                            // MARK: - Artwork
                            HeaderView(with: model)
                            VStack{
                                Text(Character.Detail.Constants.Success.title)
                                    .padding(Character.Detail.Constants.Success.padding)
                                    .fontWeight(.heavy)
                                SeriesListView(with: [model])
                            }
                        }
                        .overlay(alignment: .top) {
                            NavBarView(with: {
                                viewModel.onBackButtonClicked()
                            }, model: model)
                        }
                    }
                    .coordinateSpace(name: "SCROLL")
                }
            }.onAppear {
                viewModel.onAppear()
            }
            .animation(.easeInOut, value: viewModel.state)
        }
    }
}

// Mark: - Series List View -

extension Character.Detail.ContentView {
    @ViewBuilder
    func SeriesListView(with model: [Any?]) -> some View {
        if let model = model as? [Character.List.Model] {
            VStack(spacing: Character.Detail.Constants.Series.verticalPadding) {
                ForEach(model.indices, id: \.self) { index in
                    HStack(spacing: Character.Detail.Constants.Series.horizontalPadding) {
                        // TODO: add image
                        KFImage(URL(string: ""))
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
                            .clipped()

                        // TODO: add Data
                        Text("Name")
                            .font(.callout)
                            .fontWeight(.semibold)
                            .foregroundColor(.gray)

                        VStack(alignment: .leading, spacing: 6){
                            Text(model[index].name)
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                            Text("Data")
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }
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
    func HeaderView(with model: Any?) -> some View {
        if let model = model as? Character.List.Model {
            let height = size.height * Character.Detail.Constants.Header.heightPercentage
            GeometryReader { proxy in

                let size = proxy.size
                let minY = proxy.frame(in: .named("SCROLL")).minY
                let progress = minY / (height * (minY > 0 ? 0.5 : 0.8))

                KFImage(URL(string: "" ))
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
                            // MARK: - Gradient Overlay
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
                                Text(model.name)
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
    func NavBarView(
        with onBackButtonClicked: @escaping () -> Void,
        model: Any?
    ) -> some View {
        if let model = model as? Character.List.Model {
            let height = size.height * 0.45
            GeometryReader{ proxy in
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

                    } label: {
                        Image.iconShare
                            .foregroundColor(.white)
                    }
                }
                .overlay(content: {
                    Text(model.name)
                        .foregroundColor(.white)
                        .fontWeight(.semibold)
                        .offset(y: -titleProgress > 0.75 ? 0 : 45)
                        .clipped()
                        .animation(.easeOut(duration: 0.25), value: -titleProgress > 0.75)
                })
                .padding(.top, safeArea.top + 10)
                .padding([.horizontal,.bottom], 15)
                .background(
                    Color.red
                        .opacity(-progress > 1 ? 1 : 0)
                )
                .offset(y: -minY)
            }
            .frame(height: height)
        } else {
            EmptyView()
        }
    }
}

// MARK: - Preview -

struct CharacterDetailContenView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = Character.Detail.ViewModel(coordinator: nil)
        let model = Character.List.Model(id: 1, name: "Character Name")
        viewModel.state = .success(model)
        return Character.Detail.MainView(viewModel: viewModel)
    }
}
