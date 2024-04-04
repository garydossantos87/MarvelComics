import UIKit

import SwiftUI

extension Alert {
    struct MainView: View {
        let model: Model
        var body: some View {
            ZStack {
                Alert.Constants.backgroundColor.edgesIgnoringSafeArea(.all)
                
                VStack(spacing: Alert.Constants.spacing) {
                    Text(model.title)
                        .font(.headline)
                        .padding([.top, .horizontal])
                    Text(model.subtitle)
                        .font(.body)
                        .padding(.horizontal)
                    
                    Button(action: {
                        model.actionHandler()
                    }) {
                        Text(model.actionTitle)
                            .font(.headline)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.primaryColor)
                            .foregroundColor(.white)
                    }.padding(.top)
                }
                .background(Color.white)
                .cornerRadius(Alert.Constants.cornerRadius)
                .padding(.horizontal, Alert.Constants.horizontalPadding)
            }
        }
    }
}

struct ContentView: View {
    var body: some View {
        let model = Alert.Model(
            title: "Title",
            subtitle: "Subtitle",
            actionTitle: "OK",
            actionHandler: {}
        )
        Alert.MainView(model: model)
    }
}

// MARK: - Previews -

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
