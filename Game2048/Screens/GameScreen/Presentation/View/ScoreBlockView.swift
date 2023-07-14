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
		view.font = UIFont.systemFont(ofSize: 20, weight: .regular)

		return view
	}()

	private lazy var scoreBlockLabel: UILabel = {
		let view = UILabel()
		view.text = "\(score)"
		view.textColor = .white
		view.textAlignment = .center
		view.font = UIFont.systemFont(ofSize: 15, weight: .regular)
		
		return view
	}()
	
	init(title: String, score: Int = 0) {
		self.title = title
		self.score = score
		
		super.init(frame: .zero)
		
		setup()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func addScore(_ score: Int) {
		self.score = self.score + score
		scoreBlockLabel.text = "\(self.score)"
	}
	
	func setScore(_ score: Int) {
		self.score = score
		scoreBlockLabel.text = "\(self.score)"
	}
}

private extension ScoreBlockView {
	func setup() {
		configureUI()
		configureConstraints()
	}
	
	func configureUI() {
		layer.cornerRadius = 5
		layer.masksToBounds = true
		backgroundColor = R.color.scoreBlockBackground()
		
		addSubview(titleBlockLabel)
		addSubview(scoreBlockLabel)
	}
	
	func configureConstraints() {
		titleBlockLabel.snp.makeConstraints { make in
			make.top.equalToSuperview().inset(2)
			make.horizontalEdges.equalToSuperview().inset(5)
		}
		
		scoreBlockLabel.snp.makeConstraints { make in
			make.top.equalTo(titleBlockLabel.snp.bottom).offset(5)
			make.horizontalEdges.equalToSuperview().inset(2)
			make.bottom.equalToSuperview().inset(2)
		}
	}
}
