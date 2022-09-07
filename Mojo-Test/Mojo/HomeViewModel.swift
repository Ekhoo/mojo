//
//  HomeViewModel.swift
//  Mojo
//
//  Created by Lucas Ortis on 07/09/2022.
//

import Foundation
import SwiftUI

final class HomeViewModel: ObservableObject {
    
    let itemSize = CGSize(width: 120, height: 240)
    let templateRepository = TemplateRepository()
    
    @Published var templates: [Template]? = nil
    
    init() {
        templateRepository.fetchTemplates { templates in
            DispatchQueue.main.async {
                self.templates = templates
            }
        }
    }
    
}
