//
//  CarouselView.swift
//  Sportify
//
//  Created by Febrian Daniel on 22/03/24.
//

import SwiftUI

struct CarouselView: View {
    let imagesNames: [String]
    @State private var currentIndex = 0
    let timer = Timer.publish(every: 5, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack(spacing:0){
            TabView(selection:$currentIndex){
                ForEach(0..<imagesNames.count,id: \.self){ imageIndex in
                    Image(imagesNames[imageIndex])
                        .resizable()
                        .scaledToFill()
                        .frame(height: 145)
                        .cornerRadius(10)
                        .clipped()
                        .tag(imageIndex)
                }
            }
            .tabViewStyle(PageTabViewStyle())
//            .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
        }
        .onReceive(timer){_ in
            withAnimation {
                currentIndex = (currentIndex + 1) % imagesNames.count
            }
        }
    }
}

#Preview {
    CarouselView(imagesNames: ["dummyVenue1","dummyVenue2","dummyVenue3"])
}
