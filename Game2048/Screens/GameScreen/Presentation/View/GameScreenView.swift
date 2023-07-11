//
//  GameScreenView.swift
//  Game2048
//
//  Created by Елена on 11.07.2023.
//

import UIKit
import SnapKit

class GameScreenView: UIView {
	private enum Metrics {
		static let gameGieldHorizontalInset: CGFloat = 10
	}
	
	private let gameFieldWidth: CGFloat
	private let gameFieldHeight: CGFloat
	
	// MARK: - Views
	private lazy var titleGameLabel: UILabel = {
		let view = UILabel()
		view.text = "2048"
		view.textColor = .yellow
		view.textAlignment = .center
		view.font = UIFont.systemFont(ofSize: 30, weight: .bold)
		
		return view
	}()
	
	private lazy var gameScoreInformationStack: UIStackView = {
		let view = UIStackView()
		view.axis = .horizontal
		view.spacing = 20
		
		return view
	}()
	
	private lazy var scoreInformationLabel = ScoreBlockView(title: "SCORE", score: 234)
	private lazy var bestScoreInformationLabel = ScoreBlockView(title: "BEST", score: 2048)
	
	private lazy var buttonsStack: UIStackView = {
		let view = UIStackView()
		view.axis = .horizontal
		view.spacing = 15
		
		return view
	}()
	
	private lazy var goBackStepButton: UIButton = {
		let view = UIButton()
		view.setImage(UIImage(systemName: "arrowshape.turn.up.left.fill"), for: .normal)
		
		return view
	}()
	
	private lazy var restartButton: UIButton = {
		let view = UIButton()
		view.setImage(UIImage(systemName: "arrow.triangle.2.circlepath", withConfiguration: UIImage.SymbolConfiguration(pointSize: 16, weight: .bold)), for: .normal)
		
		return view
	}()
	
	//game field
	private lazy var gameField = GameFieldView(fieldWidth: gameFieldWidth, fieldHeight: gameFieldHeight)

	init() {
		gameFieldWidth =  UIScreen.main.bounds.width - 2 * Metrics.gameGieldHorizontalInset
		gameFieldHeight = gameFieldWidth
		
		super.init(frame: .zero)
		
		setup()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

private extension GameScreenView {
	func setup() {
		configureUI()
		configureConstraints()
		configureActions()
	}
	
	func configureUI() {
		backgroundColor = .systemPink
		addSubview(titleGameLabel)
		addSubview(gameScoreInformationStack)
		addSubview(buttonsStack)
		addSubview(gameField)
		
		gameScoreInformationStack.addArrangedSubview(scoreInformationLabel)
		gameScoreInformationStack.addArrangedSubview(bestScoreInformationLabel)
		
		buttonsStack.addArrangedSubview(goBackStepButton)
		buttonsStack.addArrangedSubview(restartButton)
	}
	
	func configureConstraints() {
		titleGameLabel.snp.makeConstraints { make in
			make.top.equalTo(safeAreaLayoutGuide.snp.top).inset(15)
			make.leading.equalToSuperview().inset(10)
		}
		
		gameScoreInformationStack.snp.makeConstraints { make in
			make.trailing.equalToSuperview().inset(10)
			make.verticalEdges.equalTo(titleGameLabel.snp.verticalEdges)
			make.leading.greaterThanOrEqualTo(titleGameLabel.snp.trailing).priority(.low)
		}
		
		buttonsStack.snp.makeConstraints { make in
			make.trailing.equalTo(gameScoreInformationStack.snp.trailing)
			make.top.equalTo(gameScoreInformationStack.snp.bottom).offset(10)
		}
		
		gameField.snp.makeConstraints { make in
			make.horizontalEdges.equalToSuperview().inset(10)
			make.top.equalTo(buttonsStack.snp.bottom).offset(25)
			make.width.equalTo(gameFieldWidth)
			make.height.equalTo(gameFieldHeight)
		}
	}
	
	func configureActions() {
		
	}
}
