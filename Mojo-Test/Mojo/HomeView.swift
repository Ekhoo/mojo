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
                
                if viewModel.selectedTemplate != nil {
                    DetailsView(viewModel: viewModel)
                } else if let templates = viewModel.templates {
                    let itemWidth =  (geometry.size.width - (Double(viewModel.itemsPerLine) * viewModel.spacing)) / Double(viewModel.itemsPerLine)
                    let itemHeight = itemWidth * 2
                    
                    ScrollView {
                        LazyVGrid(columns: [GridItem(.adaptive(minimum: itemWidth, maximum: itemWidth))], spacing: viewModel.spacing) {
                            ForEach((0..<templates.count), id: \.self) { item in
                                let template = templates[item]
                                
                                Button(action: {
                                    withAnimation {
                                        self.viewModel.selectedTemplate = template
                                    }
                                }) {
                                    TemplateView(template: template, size: CGSize(width: itemWidth, height: itemHeight))
                                        .frame(width: itemWidth, height: itemHeight)
                                        .cornerRadius(10)
                                }
                            }
                        }
                        .padding(.top, viewModel.spacing)
                    }
                } else {
                    ProgressView().progressViewStyle(CircularProgressViewStyle(tint: Color.black))
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
