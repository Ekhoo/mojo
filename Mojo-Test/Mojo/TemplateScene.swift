//
//  TemplateScene.swift
//  Mojo
//
//  Created by Lucas Ortis on 07/09/2022.
//

import Foundation
import SpriteKit

class TemplateScene: SKScene {
    
    init(template: Template, size: CGSize) {
        super.init(size: size)
        
        build(template: template, parent: self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func buildImage(template: Template, parent: SKNode) {
        let image = UIImage(named: "media1")
        let texture = SKTexture(image: image!)
        let node = SKSpriteNode(texture: texture)

        node.position = CGPoint(x: size.width, y: size.height)
             
        parent.addChild(node)
    }
    
    func build(template: Template, parent: SKNode) {
        for (key, value) in template {
            //build(template: template, parent: parent)
        }
    }
    
    /*override func didMove(to view: SKView) {
    }*/
    
}
