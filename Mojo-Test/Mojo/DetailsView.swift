//
//  ContentView.swift
//  Mojo
//
//  Created by Lucas Ortis on 07/09/2022.
//

import SwiftUI

struct DetailsView: View {
    
    @ObservedObject var viewModel: HomeViewModel
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .center) {
                Color.white
                
                if let selectedTemplate = viewModel.selectedTemplate {
                    TemplateView(template: selectedTemplate, size: CGSize(width: geometry.size.width, height: geometry.size.height))
                        .frame(width: geometry.size.width, height: geometry.size.height)
                }
                
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
            }
        }
        .ignoresSafeArea()
    }
}
