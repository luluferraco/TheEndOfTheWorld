//
//  CountdownTimer.swift
//  WWDC18
//
//  Created by Lucas Ferraço on 24/03/18.
//  Copyright © 2018 Lucas Ferraço. All rights reserved.
//

import UIKit

public protocol CountdownTimerProtocol {
	func setLabelText(with text: String)
	func timeHasEnded()
}

public class CountdownTimer {
	private var delegate: CountdownTimerProtocol!
	
	private var timer: Timer!
	
	private let totalTime: Int!
	
	private(set) var remainingTime: Int!
	
	public var currentTime: Int {
		return self.totalTime - self.remainingTime
	}
	
	public init(totalTime: Int, delegate: CountdownTimerProtocol) {
		self.totalTime = totalTime
		self.remainingTime = totalTime
		self.delegate = delegate
	}
	
	private func getTimeString() -> String {
		let minutes = self.remainingTime / 60
		let seconds = self.remainingTime % 60
		
		if seconds < 10 {
			return "0" + minutes.description + ":0" + seconds.description
		}
		
		return "0" + minutes.description + ":" + seconds.description
	}
	
	public func start() {
		if self.timer != nil {
			timer.invalidate()
		}
		
		self.delegate.setLabelText(with: self.getTimeString())
		self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.updateTimer), userInfo: nil, repeats: true)
	}
	
	@objc private func updateTimer() {
		if self.remainingTime == 0 {
			self.timer.invalidate()
			self.delegate.timeHasEnded()
		} else {
			self.remainingTime = self.remainingTime - 1			
			self.delegate.setLabelText(with: self.getTimeString())
		}
	}
	
	public func pause() {
		self.timer.invalidate()
	}
}
