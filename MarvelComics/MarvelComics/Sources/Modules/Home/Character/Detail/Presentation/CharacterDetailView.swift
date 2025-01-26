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

    struct ContentView2: View {
        @ObservedObject var viewModel: ViewModel

        var body: some View {
            ZStack {
                switch viewModel.state {
                case .loading:
                    Loading.View.SwiftUIView()
                    //                        .frame(width: 10.0 , height: 10.0)
                        .transition(.opacity)
                        .zIndex(1)
                case .success:
                    Text("Success!").font(.largeTitle).foregroundColor(.green)
                case .failure:
                    Text("Something went wrong.").font(.largeTitle).foregroundColor(.red)
                case .none:
                    EmptyView()
                }
            }
            .onAppear {
                viewModel.onAppear()
            }
            .animation(.easeInOut, value: viewModel.state)
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
                case .success:
                    ScrollView(.vertical, showsIndicators: false) {
                        VStack{
                            // MARK: - Artwork
                            HeaderView()
                            VStack{
                                Text("Popular")
                                    .fontWeight(.heavy)
                                AlbumView()
                            }
                        }
                        .overlay(alignment: .top) {
                            HeaderView2(with: viewModel)
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

// Mark: - Album View -

extension Character.Detail.ContentView {
    @ViewBuilder
    func AlbumView() -> some View {
        VStack(spacing:  25) {
            ForEach(albums.indices, id: \.self) { index in
                HStack(spacing: 25) {
                    Text("\(index + 1)")
                        .font(.callout)
                        .fontWeight(.semibold)
                        .foregroundColor(.gray)

                    VStack(alignment: .leading, spacing: 6){
                        Text(albums[index].albumName)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                        Text("2,282,938")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)

                    Image(systemName: "ellipsis")
                        .foregroundColor(.gray)

                }

            }
        }.background(.white)
    }
}

// MARK: - Header View -

extension Character.Detail.ContentView {
    @ViewBuilder
    func HeaderView() -> some View {
        let height = size.height * Character.Detail.Constants.Header.heightPercentage
        GeometryReader{ proxy in

            let size = proxy.size
            let minY = proxy.frame(in: .named("SCROLL")).minY
            let progress = minY / (height * (minY > 0 ? 0.5 : 0.8))

            KFImage(URL(string: "" ))
                .placeholder {
                    Image(uiImage: UIImage.imageNotAvailable)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: size.width, height: size.height + (minY > 0 ? minY : 0 ))
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
                        VStack(spacing: 0) {
                            Text("Fally\nIpupa")
                                .foregroundColor(.white)
                                .font(.system(size: 45))
                                .fontWeight(.bold)
                                .multilineTextAlignment(.center)

                            Text("710,329 monthly listeners".uppercased())
                                .font(.caption)
                                .fontWeight(.bold)
                                .foregroundColor(.gray)
                                .padding(.top, 15)
                        }
                        .opacity(1 + (progress > 0 ? -progress : progress))
                        .padding(.bottom, Character.Detail.Constants.Header.bottomPadding)

                        // Moving with Scroll View
                        .offset(y: minY < 0 ? minY : 0 )
                    }
                })
                .offset(y: -minY)
        }
        .frame(height: height + safeArea.top)
    }
}

// MARK: - Header View -

extension Character.Detail.ContentView {
    // MARK: - Header View
    @ViewBuilder
    func HeaderView2(with viewModel: Character.Detail.ViewModel) -> some View {
        let height = size.height * 0.45
        GeometryReader{ proxy in
            let minY = proxy.frame(in: .named("SCROLL")).minY
            let height = size.height * 0.45
            let progress = minY / (height * (minY > 0 ? 0.5 : 0.8))
            let titleProgress =  minY / height

            HStack(spacing: 15) {
                Button {
                    viewModel.onBackButtonClicked()
                } label: {
                    Image(systemName: "chevron.left")
                        .font(.title3)
                        .foregroundColor(.white)
                }
                Spacer(minLength: 0)


                Button {

                } label: {
                    Image(systemName: "square.and.arrow.up")
                        .font(.title3)
                        .foregroundColor(.white)
                }
            }
            .overlay(content: {
                Text("Fally Ipupa")
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
    }
}


struct CharacterDetailContenView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = Character.Detail.ViewModel(coordinator: nil)
        Character.Detail.MainView(viewModel: viewModel)
    }
}



struct Album: Identifiable{
    var id = UUID().uuidString
    var albumName: String

}


var albums: [Album] = [


    Album(albumName: "Arsenal des belles mélodies"),
    Album(albumName: "Bloqué"),
    Album(albumName: "Se Yo"),
    Album(albumName: "Droit Chemin"),
    Album(albumName: "Destin"),
    Album(albumName: "Tokooos II"),
    Album(albumName: "Tokooos II Gold"),
    Album(albumName: "Science - Fiction"),
    Album(albumName: "Strandje Aan De Maas"),
    Album(albumName: "Inama"),
    Album(albumName: "Par Terre - A COLOR SHOW"),
    Album(albumName: "QALF infinity"),
    Album(albumName: "Berna Reloaded"),
    Album(albumName: "Flavour of Africa"),
    Album(albumName: "Control"),
    Album(albumName: "Gentleman 2.0"),
    Album(albumName: "Power 'Kosa Leka' : Vol 1"),
    Album(albumName: "Historia"),
    Album(albumName: "Tokooos"),
    Album(albumName: "Fleur Froide - Second état : la cristalisation"),

]
