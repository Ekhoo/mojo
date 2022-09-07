//
//  LocalCache.swift
//  Mojo
//
//  Created by Lucas Ortis on 07/09/2022.
//

import Foundation

final class LocalCache {
    
    static let shared = LocalCache()
    private let defaults = UserDefaults.standard
    
    enum Keys: String {
        case templates
    }
    
    var templates: [Template]? {
        get {
            return defaults.object(forKey: Keys.templates.rawValue) as? [Template]
        }
        set (value) {
            defaults.set(value, forKey: Keys.templates.rawValue)
        }
    }
    
}

