//
//  LiveView.swift
//
//  Copyright © 2018 Lucas Ferraço. All rights reserved.
//

import PlaygroundSupport
import SpriteKit

let skView = SKView(frame: UIScreen.main.bounds)

let skScene = SKScene(size: skView.frame.size)
skScene.scaleMode = .aspectFill
skScene.addChild(BackgroundNode(sceneSize: skView.frame.size))

skView.presentScene(skScene)

PlaygroundSupport.PlaygroundPage.current.liveView = skView
