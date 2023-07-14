//
//  ScoreManager.swift
//  Game2048
//
//  Created by Елена on 12.07.2023.
//

import Foundation

protocol ScoreManagerProtocol: AnyObject {
	func fetchScore() -> Int
	func fetchMaxScore() -> Int
	func saveScore(_ score: Int)
	func saveMaxScore(_ score: Int)
}

final class ScoreManager: ScoreManagerProtocol {
	private enum KeysTitle {
		static var score = "score"
		static var maxScore = "maxScore"
	}
	
	func fetchScore() -> Int {
		UserDefaults.standard.integer(forKey: KeysTitle.score)
	}
	
	func fetchMaxScore() -> Int {
		return UserDefaults.standard.integer(forKey: KeysTitle.maxScore)
	}
	
	func saveScore(_ score: Int) {
		UserDefaults.standard.setValue(score, forKey: KeysTitle.score)
	}
	
	func saveMaxScore(_ score: Int) {
		if score > fetchMaxScore() {
			UserDefaults.standard.set(score, forKey: KeysTitle.maxScore)
		}
	}
}
