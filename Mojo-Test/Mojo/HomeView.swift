//
//  ContentView.swift
//  Mojo
//
//  Created by Lucas Ortis on 07/09/2022.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject var viewModel = HomeViewModel()
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .center) {
                Color.white
                
                if let templates = viewModel.templates {
                    ScrollView {
                        LazyVGrid(columns: [GridItem(.adaptive(minimum: viewModel.itemSize.width, maximum: viewModel.itemSize.height))], spacing: 16) {
                            ForEach((0..<templates.count), id: \.self) { item in
                                let template = templates[item]
                                
                                TemplateView(template: template, size: viewModel.itemSize)
                                    .frame(width: viewModel.itemSize.width, height: viewModel.itemSize.height)
                            }
                        }
                    }
                } else {
                    ProgressView().progressViewStyle(CircularProgressViewStyle(tint: Color.white))
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
