//
//  ScoreBlockView.swift
//  Game2048
//
//  Created by Елена on 11.07.2023.
//

import UIKit
import SnapKit

class ScoreBlockView: UIView {
	private let title: String
	private(set) var score: Int

	private lazy var titleBlockLabel: UILabel = {
		let view = UILabel()
		view.text = title
		view.textColor = .white
		view.textAlignment = .center
		view.font = UIFont.systemFont(ofSize: 20, weight: .bold)

		return view
	}()

	private lazy var scoreBlockLabel: UILabel = {
		let view = UILabel()
		view.text = "\(score)"
		view.textColor = .white
		view.textAlignment = .center
		view.font = UIFont.systemFont(ofSize: 15, weight: .bold)
		
		return view
	}()
	
	init(title: String, score: Int) {
		self.title = title
		self.score = score
		
		super.init(frame: .zero)
		
		setup()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func addScore(_ score: Int) {
		let oldScore = Int(scoreBlockLabel.text ?? "0") ?? 0
		
		scoreBlockLabel.text = String(score + oldScore)
		self.score += score
	}
	
	func setScore(_ score: Int) {
		scoreBlockLabel.text = "\(score)"
		self.score = score
	}
}

private extension ScoreBlockView {
	func setup() {
		configureUI()
		configureConstraints()
	}
	
	func configureUI() {
		backgroundColor = .gray
		addSubview(titleBlockLabel)
		addSubview(scoreBlockLabel)
	}
	
	func configureConstraints() {
		titleBlockLabel.snp.makeConstraints { make in
			make.top.equalToSuperview()
			make.horizontalEdges.equalToSuperview().inset(5)
		}
		
		scoreBlockLabel.snp.makeConstraints { make in
			make.top.equalTo(titleBlockLabel.snp.bottom).offset(5)
			make.horizontalEdges.equalToSuperview().inset(2)
			make.bottom.equalToSuperview()
		}
	}
}
