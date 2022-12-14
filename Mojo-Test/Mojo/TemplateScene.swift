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
    
    func build(template: Template, parent: SKNode) {
        let node = SKSpriteNode()
        
        setupSize(template: template, node: node, parent: parent)
        setupAnchor(template: template, node: node)
        setupPosition(template: template, node: node, parent: parent)
        setupBackground(template: template, node: node)
        setupMedia(template: template, node: node, parent: parent)
        
        parent.addChild(node)
        
        setupChildren(template: template, node: node, parent: parent)
    }
    
    private func setupMedia(template: Template, node: SKNode, parent: SKNode) {
        guard let media = template["media"] as? String,
              let contentMode = template["media_content_mode"] as? String,
              let image = UIImage(named: media) else {
            return
        }
        
        let texture = SKTexture(image: image)
        let sprite = SKSpriteNode(texture: texture, size: node.frame.size)
        sprite.anchorPoint = CGPoint.zero
        sprite.position = CGPoint.zero
        
        if contentMode == "fit" {
            let imageRatio = texture.size().height / texture.size().width
            var w = node.frame.width
            var h = w * imageRatio
            
            if texture.size().height > texture.size().width {
                w = node.frame.height * imageRatio
                
                if w > node.frame.width {
                    w = node.frame.width
                    h = w * imageRatio
                }
            } else if h > node.frame.height {
                h = node.frame.height
                w = h / imageRatio
            }
            
            sprite.size = CGSize(width: w, height: h)
            sprite.anchorPoint = CGPoint(x: 0.5, y: 0.5)
            sprite.position = CGPoint(x: node.frame.midX, y: node.frame.midY)
        }
        
        node.addChild(sprite)
    }
    
    private func setupSize(template: Template, node: SKSpriteNode, parent: SKNode) {
        var wFactor = 1.0
        var hFactor = 1.0
        
        if let factor = template["width"] as? Double {
            wFactor = factor
        }
        if let factor = template["height"] as? Double {
            hFactor = factor
        }
        
        node.size = CGSize(width: parent.frame.size.width * wFactor, height: parent.frame.size.height * hFactor)
    }
    
    private func setupAnchor(template: Template, node: SKSpriteNode) {
        var xAnchor = "left"
        var yAnchor = "bottom"
        
        if let anchor = template["anchor_x"] as? String {
            xAnchor = anchor
        }
        
        if let anchor = template["anchor_y"] as? String {
            yAnchor = anchor
        }
        
        var xAnchorValue = 0.0
        var yAnchorValue = 0.0
        
        if xAnchor == "center" {
            xAnchorValue = 0.5
        } else if xAnchor == "right" {
            xAnchorValue = 1
        }
        
        if yAnchor == "center" {
            yAnchorValue = 0.5
        } else if yAnchor == "top" {
            yAnchorValue = 1
        }
        
        node.anchorPoint = CGPoint(x: xAnchorValue, y: yAnchorValue)
    }
    
    private func setupPosition(template: Template, node: SKSpriteNode, parent: SKNode) {
        var xFactor = 0.0
        var yFactor = 0.0
        
        if let factor = template["x"] as? Double {
            xFactor = factor
        }
        if let factor = template["y"] as? Double {
            yFactor = factor
        }
        
        let x = parent.frame.size.width * xFactor
        let y = parent.frame.size.height * yFactor
        
        node.position = CGPoint(x: x, y: y)
    }
    
    private func setupBackground(template: Template, node: SKSpriteNode) {
        var color = SKColor.black
        
        if let hexColor = template["background_color"] as? String {
            color = SKColor(hex: hexColor)
        }
        
        node.color = color
    }
    
    private func setupChildren(template: Template, node: SKSpriteNode, parent: SKNode) {
        guard let children = template["children"] as? [Template] else { return }
        
        var parentNode = node
        let padding = template["padding"] as? Double ?? 0.0
        
        // Childs node is usefull only if padding is positive
        if padding != 0.0 {
            let xPadding = padding * node.frame.size.width
            let yPadding = padding * node.frame.size.height
            let scaledSize = CGSize(width: node.frame.size.width - 2*xPadding, height: node.frame.size.height - 2*yPadding)
            let x = node.anchorPoint.x.isZero ? xPadding : -(node.anchorPoint.x * scaledSize.width)
            let y = node.anchorPoint.y.isZero ? yPadding : -(node.anchorPoint.y * scaledSize.height)
            
            let childsNode = SKSpriteNode()
            childsNode.size = scaledSize
            childsNode.position = CGPoint(x: x, y: y)
            
            node.addChild(childsNode)
            
            parentNode = childsNode
        }
        
        for child in children {
            build(template: child, parent: parentNode)
        }
    }
    
}
