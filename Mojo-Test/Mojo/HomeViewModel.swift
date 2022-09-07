//
//  HomeViewModel.swift
//  Mojo
//
//  Created by Lucas Ortis on 07/09/2022.
//

import Foundation
import SwiftUI

final class HomeViewModel: ObservableObject {
    
    let itemsPerLine = 3
    let spacing = 16.0
    let templateRepository = TemplateRepository()
    
    @Published var templates: [Template]? = nil
    @Published var selectedTemplate: Template? = nil
    
    init() {
        templateRepository.fetchTemplates { templates in
            DispatchQueue.main.async {
                self.templates = templates
            }
        }
    }
    
}
