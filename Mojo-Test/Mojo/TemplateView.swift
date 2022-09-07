//
//  TemplateView.swift
//  Mojo
//
//  Created by Lucas Ortis on 07/09/2022.
//

import SwiftUI
import SpriteKit

struct TemplateView: View {
    
    let template: Template
    let size: CGSize
    
    var body: some View {
        SpriteView(scene: TemplateScene(template: template, size: size))
            .frame(width: size.width, height: size.height)
                    .ignoresSafeArea()
    }
}

struct TemplateView_Previews: PreviewProvider {
    static var previews: some View {
        TemplateView(template: [:], size: CGSize.zero)
    }
}
