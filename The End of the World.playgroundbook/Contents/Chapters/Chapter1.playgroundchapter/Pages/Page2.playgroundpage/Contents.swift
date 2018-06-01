//#-hidden-code
//
//  Contents.swift
//
//  Copyright © 2018 Lucas Ferraço. All rights reserved.
//
//#-end-hidden-code
/*:
# Gather the saviros
 On his last paper "A Smooth Exit from Eternal Inflation", Hawking found out a solution that will save us: the existence of other universes.
 There are lot of new planets, which are now ready to be populated.
 To build our new world, you will select 5 people to embark on Hawking’s rocket and go to a new planet with you!

Instructions:
1. Pick the difficulty;
2. Find a large room (about 2m x 2m);
3. Put the Live View in full screen;
4. Tap 'Run My Code';
4. Move your iPad around to find characters;
5. Walk near the characters to select and put them on your team.

### Tip:
Use the radar to see where the characters are appearing.

**But choose wisely, these are the people that will help you build our new home...**
 */
//#-hidden-code
//#-code-completion(everything, hide)
//#-code-completion(identifier, show, GameMode, easy, medium, hard, .)
//#-end-hidden-code
let gameDifficulty: GameMode = /*#-editable-code*/<#T##GameMode##GameMode#>/*#-end-editable-code*/
//#-hidden-code
import UIKit
import PlaygroundSupport

let vc = GetPersonsViewController()

if gameDifficulty != nil {
	vc.manager = GetPersonsManager(mode: gameDifficulty)
} else {
	vc.manager = GetPersonsManager(mode: .easy)
}

let page = PlaygroundPage.current
page.liveView = vc
page.needsIndefiniteExecution = true
//#-end-hidden-code
