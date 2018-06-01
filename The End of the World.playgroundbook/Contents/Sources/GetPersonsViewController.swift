//
//  GameViewController.swift
//  WWDC18
//
//  Created by Lucas Ferraço on 24/03/18.
//  Copyright © 2018 Lucas Ferraço. All rights reserved.
//

import UIKit
import ARKit
import SpriteKit
import PlaygroundSupport

public class GetPersonsViewController: UIViewController, PlaygroundLiveViewSafeAreaContainer {
	
	//MARK: Variables
	
	private var sceneView: ARSCNView!
	private var radarNode : SKShapeNode!
	
	private var timer: CountdownTimer!
	private var timerLabel: TimerLabel!
	
	private var slotViews: [SlotView]!
	fileprivate var slotsObjs: [Person?]! = Array(repeating: nil, count: 5)
	fileprivate var totalSelectedChars: Int = 0
	
	fileprivate var personNodes: [PersonNode] = []
	fileprivate var personas = Personas.all()
	
	public var manager = GetPersonsManager(mode: .easy)
	
	//MARK: View Controller Lifecycle
	
	override public func loadView() {
		self.view = UIView(frame: UIScreen.main.bounds)
	}
	
	override public func viewDidLoad() {
		super.viewDidLoad()
		
		setupScene()
		self.timer = CountdownTimer(totalTime: self.manager.totalQuestTime, delegate: self)
	}
	
	override public func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		
		configureScene()
		self.timer.start()
	}
	
	override public func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
		
		sceneView.session.pause()
	}
	
	//MARK: Setup
	
	private func setupScene() {
		sceneView = ARSCNView(frame: self.view.frame)
		sceneView.delegate = self
		
		sceneView.overlaySKScene = SKScene(size: sceneView.bounds.size)
		sceneView.overlaySKScene?.scaleMode = .resizeFill
		self.view.addSubview(sceneView)
		
		self.setupTimerLabel()
		self.setupSlotViews()
		self.setupRadar()
	}
	
	private func configureScene() {
		let config = ARWorldTrackingConfiguration()
		sceneView.session.run(config)
		
		let backgroundMusic = SKAction.playSoundFileNamed("MissionTheme.m4a", waitForCompletion: true)
		sceneView.overlaySKScene?.run(SKAction.repeatForever(backgroundMusic))
	}
	
	private func setupRadar() {
		let size = sceneView.bounds.size
		let padding: CGFloat = 50
		let circleRadius: CGFloat = 100
		let strokeColor = UIColor(red: 15/255, green: 69/255, blue: 0/255, alpha: 1.0)
		let fillColor = UIColor(red: 54/255, green: 92/255, blue: 5/255, alpha: 0.5)
		
		radarNode = SKShapeNode(circleOfRadius: circleRadius)
		radarNode.position = CGPoint(x: (size.width - circleRadius) - padding, y: 10 + circleRadius + padding)
		radarNode.strokeColor = strokeColor
		radarNode.glowWidth = 3
		radarNode.fillColor = fillColor
		radarNode.zPosition = 0
		sceneView.overlaySKScene?.addChild(radarNode)
		
		let concentricCircleRadius = circleRadius/3
		for i in (1...3) {
			let ringNode = SKShapeNode(circleOfRadius: CGFloat(i) * concentricCircleRadius)
			ringNode.strokeColor = strokeColor
			ringNode.glowWidth = 0.8
			ringNode.name = "Ring"
			ringNode.position = radarNode.position
			ringNode.zPosition = 1
			sceneView.overlaySKScene?.addChild(ringNode)
		}
		
		for _ in 0..<self.personas.count {
			let blip = SKShapeNode(circleOfRadius: 5)
			blip.fillColor = .white
			blip.strokeColor = .clear
			blip.alpha = 0
			blip.zPosition = 2
			radarNode.addChild(blip)
		}
	}
	
	private func setupTimerLabel() {
		self.timerLabel = TimerLabel(origin: CGPoint(x: self.view.frame.width/2, y: 70 + self.view.safeAreaInsets.top))
		self.view.addSubview(self.timerLabel)
		
		NSLayoutConstraint.activate([
			self.timerLabel.topAnchor.constraint(equalTo: liveViewSafeAreaGuide.topAnchor, constant: 70)
			])
	}
	
	private func setupSlotViews() {
		self.slotViews = []
		
		let slotsWidth: CGFloat = 60
		let slotsHeight: CGFloat = 70
		let yPadding: CGFloat = 15
		let slotsX: CGFloat = 50
		var slotsY: CGFloat = self.view.frame.midY - 2.5 * (slotsHeight + yPadding)
		
		for i in 0..<5 {
			let slotView = SlotView(frame: CGRect(x: slotsX, y: slotsY, width: slotsWidth, height: slotsHeight), delegate: self)
			slotView.tag = i
			self.slotViews.append(slotView)
			self.view.addSubview(slotView)
			
			NSLayoutConstraint.activate([
				slotView.leftAnchor.constraint(equalTo: liveViewSafeAreaGuide.leftAnchor, constant: 50)
				])
			
			slotsY += slotsHeight + yPadding
		}
	}
	
	//MARK: Finish game
	
	private func showFinish() {
		let size = sceneView.bounds.size
		
		let timesUpLabel = SKLabelNode(text: "TIME'S UP!")
		timesUpLabel.position = CGPoint(x: size.width/2, y: size.height/2)
		timesUpLabel.fontSize = 50
		timesUpLabel.fontName = UIFont.boldSystemFont(ofSize: 50).fontName
		timesUpLabel.fontColor = .white
		
		let goToNextPageLabel = SKLabelNode(text: "Go to the next page to see your results.")
		goToNextPageLabel.position = CGPoint(x: timesUpLabel.position.x, y: timesUpLabel.position.y - timesUpLabel.frame.size.height - 25)
		goToNextPageLabel.fontSize = 35
		goToNextPageLabel.fontName = UIFont.boldSystemFont(ofSize: 35).fontName
		goToNextPageLabel.fontColor = .black
		
		let blinkActions = [SKAction.colorize(with: .red, colorBlendFactor: 1, duration: 0.5),
							SKAction.colorize(with: .black, colorBlendFactor: 1, duration: 0.5)]
		let sequence = SKAction.sequence(blinkActions)
		let run4ever = SKAction.repeatForever(sequence)
		timesUpLabel.run(run4ever)
		
		let background = SKShapeNode(rectOf: CGSize(width: max(timesUpLabel.frame.size.width, goToNextPageLabel.frame.size.width) + 20,
													height: timesUpLabel.frame.size.height + goToNextPageLabel.frame.size.height + 100),
									 cornerRadius: 5)
		background.position = CGPoint(x: size.width/2, y: size.height/2)
		background.fillColor = .white
		background.strokeColor = .black
		background.glowWidth = 2
		
		self.sceneView.overlaySKScene?.addChild(background)
		self.sceneView.overlaySKScene?.addChild(timesUpLabel)
		self.sceneView.overlaySKScene?.addChild(goToNextPageLabel)
		
		let selectedTeam = self.slotsObjs.filter { (person) -> Bool in
			return person != nil
		} as! [Person]
		
		KeyValueStore.sharedInstance.saveCharacters(selectedTeam)
		
		self.view.isUserInteractionEnabled = false
		self.sceneView.session.pause()
	}
	
	// MARK: Get person
	
	private func spawnPersona(_ person: Person) {
		let pov = sceneView.pointOfView!
		let y = Float(0)
		
		//Random X and Z value around the circle
		var worldPosition = SCNVector3()
		
		let xRad = ((Float(arc4random_uniform(361)) - 180)/180) * Float.pi
		let zRad = ((Float(arc4random_uniform(361)) - 180)/180) * Float.pi
		let length = Float(arc4random_uniform(1) + 2) * -0.5
		let x = length * sin(xRad)
		let z = length * cos(zRad)
		let position = SCNVector3Make(x, y, z)
		worldPosition = pov.convertPosition(position, to: nil)
		let personNode = PersonNode(model: person, position: worldPosition, cameraPosition: pov.position)
		
		self.personNodes.append(personNode)
		self.sceneView.scene.rootNode.addChildNode(personNode.node)
	}
	
	fileprivate func updateSlots(withNew person: Person) -> Bool {
		if self.totalSelectedChars == 5 {
			return false
		}
		
		self.slotsObjs[self.totalSelectedChars] = person
		self.totalSelectedChars += 1
		self.presentSelectedCharactres()
		
		return true
	}
	
	fileprivate func presentSelectedCharactres() {
		for i in 0..<5 {
			DispatchQueue.main.async {
				self.slotViews[i].setCharacterImageWith(person: self.slotsObjs[i])
			}
		}
	}
}

//MARK:- AR SceneView Delegate

extension GetPersonsViewController: ARSCNViewDelegate {
	public func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
		// Verifies if the node is close or not
		for (i, personNode) in self.personNodes.enumerated().reversed() {
			// If the person isn't in the world any more, then remove it from our persons list
			guard personNode.node.parent != nil else {
				self.personNodes.remove(at: i)
				continue
			}
			
			if let playerPosition = self.sceneView.pointOfView?.position {
				let distance = personNode.node.position.distance(vector: playerPosition)
				
				if distance <= 0.5 && self.updateSlots(withNew: personNode.model) {
					let catchSound = SKAction.playSoundFileNamed("CatchCharacter.wav", waitForCompletion: true)
					sceneView.overlaySKScene?.run(catchSound)
					
					personNode.node.removeFromParentNode()
				}
			}
		}
		
		// Draw persons on the radar as an XZ Plane
		for (i, blip) in self.radarNode.children.enumerated() {
			if i < self.personNodes.count {
				let personNode = self.personNodes[i]
				blip.alpha = 1
				let relativePosition = self.sceneView.pointOfView!.convertPosition(personNode.node.position, from: nil)
				var x = relativePosition.x * 50
				var y = relativePosition.z * -50
				if x >= 0 { x = min(x, 35) } else { x = max(x, -35)}
				if y >= 0 { y = min(y, 35) } else { y = max(y, -35)}
				blip.position = CGPoint(x: CGFloat(x), y: CGFloat(y))
			} else {
				// If there are less aliens than the max amount, hide the extra blips.
				// Note: SceneKit seemed to have a problem with dynmically adding and
				// removing blips so I removed that feature and stuck with a static maximum.
				blip.alpha = 0
			}
			
		}
	}
	
}

//MARK:- Countdown Timer Protocol

extension GetPersonsViewController: CountdownTimerProtocol {
	public func setLabelText(with text: String) {
		self.timerLabel.text = text
		
		if self.timer.remainingTime <= 10 {
			if (self.timer.remainingTime % 2) == 0 {
				self.timerLabel.textColor = .red
			} else {
				self.timerLabel.textColor = .black
			}
		}
		
		// Spawn personas
		if let personToSpawn = self.manager.personToSpawn(at: self.timer.currentTime) {
			let isPersonSpawned = self.personNodes.contains(where: { (personNode) -> Bool in
				return personNode.model == personToSpawn
			})
			
			if !isPersonSpawned {
				self.spawnPersona(personToSpawn)
			}
		}
	}
	
	public func timeHasEnded() {
		self.showFinish()
	}
}

//MARK:- Slot View Protocol

extension GetPersonsViewController: SlotViewProtocol {
	public func willRemove(person: Person, at index: Int) {
		if index >= self.slotsObjs.count {
			return
		}
		
		self.slotsObjs[index] = nil
		self.totalSelectedChars -= 1
		
		let notNilObjs: [Person] = self.slotsObjs.filter { (p) -> Bool in
			return p != nil
			} as! [Person]
		
		self.slotsObjs = Array(repeating: nil, count: 5)
		for i in 0..<notNilObjs.count {
			self.slotsObjs[i] = notNilObjs[i]
		}
		
		self.presentSelectedCharactres()
	}
}
