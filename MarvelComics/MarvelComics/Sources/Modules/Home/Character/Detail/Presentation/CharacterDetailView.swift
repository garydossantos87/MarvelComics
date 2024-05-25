import UIKit

import SwiftUI

extension Character.Detail {
    struct MainView: View {
        var safeArea: EdgeInsets
        var size: CGSize
        
        var body: some View {
            ScrollView {
                ZStack {
                    // Bottom Layer
                    VStack(spacing: 20) {
                        HeaderView()
                        HeaderView()
                        HeaderView()
                        HeaderView()
                        HeaderView()
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 300)
                    
                    // Top Layer (Header)
                    GeometryReader { gr in
                        ZStack {
                            VStack {
                                Image(.imageNotAvailable)
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(height:
                                            calculateHeight(minHeight: 140,
                                                            maxHeight: 300,
                                                            yOffset: gr.frame(in: .global).origin.y))
                                    .clipped()
                                // Show a shadow when minHeight is reached
                                    .shadow(radius: self.calculateHeight(minHeight: 120,
                                                                         maxHeight: 300,
                                                                         yOffset: gr.frame(in: .global).origin.y) < 140 ? 8 : 0)
                                    .overlay(
                                        Text("UTAH")
                                            .font(.system(size: 70, weight: .black))
                                            .foregroundColor(.white)
                                            .opacity(0.8))
                                // Offset just on the Y axis
                                    .offset(y: gr.frame(in: .global).origin.y < 0 // Is it going up?
                                            ? abs(gr.frame(in: .global).origin.y) // Push it down!
                                            : -gr.frame(in: .global).origin.y) // Push it up!
                                Spacer() // Push header to top
                            }
                            HeaderView2()
                        }
                    }
                }
            }.edgesIgnoringSafeArea(.vertical)
        }
        
        func calculateHeight(minHeight: CGFloat, maxHeight: CGFloat, yOffset: CGFloat) -> CGFloat {
            // If scrolling up, yOffset will be a negative number
            if maxHeight + yOffset < minHeight {
                // SCROLLING UP
                // Never go smaller than our minimum height
                return minHeight
            } else if maxHeight + yOffset > maxHeight {
                // SCROLLING DOWN PAST MAX HEIGHT
                return maxHeight + (yOffset * 0.5) // Lessen the offset
            }
            
            // SCROLLING DOWN
            return maxHeight + yOffset
        }
    }
}

extension Character.Detail.MainView {
    @ViewBuilder
    func HeaderView() -> some View {
        Image(.imageNotAvailable)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(height: 200, alignment: .bottom)
            .cornerRadius(20)
            .shadow(color: .gray, radius: 10, x: 0, y: 5)
            .overlay(VStack {
                Spacer()
                Text("Title")
                    .padding(.bottom, 20)
                    .opacity(0.85)
                    .font(.system(size: 30, weight: .black))
                    .foregroundColor(.white)
            })
        
    }
    
    @ViewBuilder
    func HeaderView2() -> some View {
        GeometryReader{ proxy in
            let minY = proxy.frame(in: .named("SCROLL")).minY
            let height = size.height * 0.45
            let progress = minY / (height * (minY > 0 ? 0.5 : 0.8))
            let titleProgress =  minY / height
            
            HStack(spacing: 15) {
                Button {
                    
                } label: {
                    Image(systemName: "chevron.left")
                        .font(.title3)
                        .foregroundColor(.white)
                }
                Spacer(minLength: 0)
                
                
                Button {
                    
                } label: {
                    Text("FOLLOWING")
                        .font(.caption)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 6)
                        .border(.white, width: 1.5)
                }
                .opacity(1 + progress)
                
                Button {
                    
                } label: {
                    Image(systemName: "ellipsis")
                        .font(.title3)
                        .foregroundColor(.white)
                }
            }
            .overlay(content: {
                Text("Fally Ipupa")
                    .fontWeight(.semibold)
                    .offset(y: -titleProgress > 0.75 ? 0 : 45)
                    .clipped()
                    .animation(.easeOut(duration: 0.25), value: -titleProgress > 0.75)
            })
            .padding(.top, safeArea.top + 10)
            .padding([.horizontal,.bottom], 15)
            .background(
                Color.black
                    .opacity(-progress > 1 ? 1 : 0)
            )
            .offset(y: -minY)
            
            
            
        }
        .frame(height: 35)
    }
}

struct CharacterDetail_ContentView: View {
    var body: some View {
        GeometryReader {
            Character.Detail.MainView(
                safeArea: $0.safeAreaInsets,
                size: $0.size
            )
            .ignoresSafeArea(.container, edges: .top)
        }
    }
}

// MARK: - Previews -

struct CharacterDetail_ContentView_Previews: PreviewProvider {
    static var previews: some View {
        CharacterDetail_ContentView()
    }
}
