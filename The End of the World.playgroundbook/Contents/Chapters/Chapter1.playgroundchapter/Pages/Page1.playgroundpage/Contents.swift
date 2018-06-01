//#-hidden-code
//
//  Contents.swift
//
//  Copyright © 2018 Lucas Ferraço. All rights reserved.
//
//#-end-hidden-code
/*:
 # Mission briefing
 To start your mission define the text velocity of your preference.
 
 Choose the text velocity, put the Live View on full screen and 'Run My Code'!
*/
//#-hidden-code
import PlaygroundSupport
import SpriteKit

let skView = SKView(frame: UIScreen.main.bounds)

let scene = StarTextScene(size: skView.frame.size)
scene.scaleMode = .aspectFit

func setTextVelocity(_ v: Int) {
	scene.velocityMultiplier = v
}
//#-end-hidden-code
setTextVelocity(/*#-editable-code*/1/*#-end-editable-code*/)

//#-hidden-code
skView.presentScene(scene)
PlaygroundSupport.PlaygroundPage.current.liveView = skView
//#-end-hidden-code
