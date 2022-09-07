//
//  TemplateRepository.swift
//  Mojo
//
//  Created by Lucas Ortis on 07/09/2022.
//

import Foundation

typealias Template = [String: Any]

class TemplateRepository {
    
    func fetchTemplates(completion: @escaping ([Template]?) -> Void) {
        guard let url = URL(string: "https://ptitchevreuil.github.io/mojo/templates.json") else {
            completion(nil)
            return
        }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
            if error != nil {
                completion(nil)
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode),
                  let data = data else {
                completion(nil)
                return
            }
            
            do {
                guard let json = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves) as? [String: [Template]],
                      let templates = json["templates"] else {
                    completion(nil)
                    return
                }
                
                // Remove 'data' node in order to handle parent and children the same way
                var filteredTemplates = [Template]()
                for item in templates {
                    var newTemplate = Template()
                    newTemplate["name"] = item["name"]
                    
                    if let payload = item["data"] as? Template {
                        for (key, value) in payload {
                            newTemplate[key] = value
                        }
                    }
                    
                    filteredTemplates.append(newTemplate)
                }
                
                completion(filteredTemplates)
            } catch {
                completion(nil)
            }
        }
        
        task.resume()
    }
    
}
