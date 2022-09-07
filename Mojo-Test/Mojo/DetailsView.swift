//
//  ContentView.swift
//  Mojo
//
//  Created by Lucas Ortis on 07/09/2022.
//

import SwiftUI

struct DetailsView: View {
    
    @ObservedObject var viewModel: HomeViewModel
    
    func buildTemplate(geometry: GeometryProxy) -> TemplateView? {
        guard let selectedTemplate = viewModel.selectedTemplate else { return nil }
        
        viewModel.templateView = TemplateView(template: selectedTemplate, size: CGSize(width: geometry.size.width, height: geometry.size.height))
        
        return viewModel.templateView
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .center) {
                Color.white
                
                buildTemplate(geometry: geometry)
                
                VStack {
                    HStack {
                        Spacer()
                        
                        Button(action: {
                            withAnimation {
                                self.viewModel.selectedTemplate = nil
                            }
                        }) {
                            ZStack {
                                Color.black
                                
                                Image(systemName: "xmark")
                                    .frame(width: 30, height: 30)
                                    .foregroundColor(.white)
                            }
                            .frame(width: 40, height: 40)
                            .cornerRadius(20)
                        }
                        .padding(.top, 50)
                        .padding(.trailing, 30)
                    }
                    
                    Spacer()
                }
                
                VStack {
                    Spacer()
                    HStack {
                        Button(action: {
                            guard let template = viewModel.templateView else { return }
                            let image = template.snapshot()
                            UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
                        }) {
                            ZStack {
                                Color.black
                                
                                Image(systemName: "square.and.arrow.up")
                                    .frame(width: 30, height: 30)
                                    .foregroundColor(.white)
                            }
                            .frame(width: 40, height: 40)
                            .cornerRadius(20)
                        }
                        .padding(.bottom, 40)
                    }
                }
            }
        }
        .ignoresSafeArea()
        .onDisappear() {
            viewModel.templateView = nil
        }
    }
}
