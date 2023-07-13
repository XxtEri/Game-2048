//
//  GameScreenView.swift
//  Game2048
//
//  Created by Елена on 11.07.2023.
//

import RswiftResources

import UIKit
import SnapKit

class GameScreenView: UIView {
	// MARK: - Handlers
	var onSwipeUp: (() -> Void)?
	var onSwipeDown: (() -> Void)?
	var onSwipeLeft: (() -> Void)?
	var onSwipeRight: (() -> Void)?
	var updateScore: ((Int) -> Void)?
	
	private enum Metrics {
		static let gameGieldHorizontalInset: CGFloat = 10
	}
	
	private let gameFieldWidth: CGFloat
	private let gameFieldHeight: CGFloat
	
	// MARK: - Views
	lazy var gameField = GameFieldView(fieldWidth: gameFieldWidth, fieldHeight: gameFieldHeight)
	
	private lazy var titleGameLabel: UILabel = {
		let view = UILabel()
		view.text = "2048"
		view.textColor = R.color.text()
		view.textAlignment = .center
		view.font = UIFont.systemFont(ofSize: 40, weight: .bold)
		
		return view
	}()
	
	private lazy var gameScoreInformationStack: UIStackView = {
		let view = UIStackView()
		view.axis = .horizontal
		view.spacing = 20
		
		return view
	}()
	
	private lazy var scoreInformationLabel = ScoreBlockView(title: "SCORE", score: 0)
	private lazy var bestScoreInformationLabel = ScoreBlockView(title: "BEST SCORE", score: 0)
	
	private lazy var buttonsStack: UIStackView = {
		let view = UIStackView()
		view.axis = .horizontal
		view.spacing = 20
		
		return view
	}()
	
	private lazy var goBackStepButton: UIButton = {
		let view = UIButton()
		view.setImage(R.image.backStep(), for: .normal)
		view.contentMode = .scaleAspectFit
		
		return view
	}()
	
	private lazy var restartButton: UIButton = {
		let view = UIButton()
		view.setImage(R.image.restart(), for: .normal)
		view.contentMode = .scaleAspectFit
		
		return view
	}()

	init() {
		gameFieldWidth =  UIScreen.main.bounds.width - 2 * Metrics.gameGieldHorizontalInset
		gameFieldHeight = gameFieldWidth
		
		super.init(frame: .zero)
		
		setup()
		setHandlers()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func setScore(_ score: Int) {
		scoreInformationLabel.setScore(score)
	}
	
	func setMaxScore(_ score: Int) {
		bestScoreInformationLabel.setScore(score)
	}
}

// MARK: - Setup extension
private extension GameScreenView {
	func setup() {
		configureUI()
		configureConstraints()
		configureActions()
	}
	
	func configureUI() {
		backgroundColor = R.color.gameScreenBackground()
		addSubview(titleGameLabel)
		addSubview(gameScoreInformationStack)
		addSubview(buttonsStack)
		addSubview(gameField)
		
		gameScoreInformationStack.addArrangedSubview(scoreInformationLabel)
		gameScoreInformationStack.addArrangedSubview(bestScoreInformationLabel)
		
		buttonsStack.addArrangedSubview(goBackStepButton)
		buttonsStack.addArrangedSubview(restartButton)
	}
	
	func setupStartCells() {
		
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
			make.top.greaterThanOrEqualTo(buttonsStack.snp.bottom).offset(20).priority(.high)
			make.center.equalToSuperview().inset(10).priority(.low)
			make.width.equalTo(gameFieldWidth)
			make.height.equalTo(gameFieldHeight)
		}
		
		goBackStepButton.snp.makeConstraints { make in
			make.size.equalTo(30)
		}
		
		restartButton.snp.makeConstraints { make in
			make.size.equalTo(30)
		}
	}
	
	func configureActions() {
		setupLeftSwipe()
		setupRightSwipe()
		setupUpSwipe()
		setupDownSwipe()
	}
	
	// MARK: - Actions
	@objc
	func onSwipe(_ sender: UISwipeGestureRecognizer) {
		switch sender.direction {
		case .up:
			onSwipeUp?()
		case .down:
			onSwipeDown?()
		case .left:
			onSwipeLeft?()
		case .right:
			onSwipeRight?()
		default:
			break
		}
	}
}

private extension GameScreenView {
	func setupLeftSwipe() {
		let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(onSwipe(_:)))
		leftSwipe.numberOfTouchesRequired = 1
		leftSwipe.direction = .left
		
		addGestureRecognizer(leftSwipe)
	}
	
	func setupRightSwipe() {
		let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(onSwipe(_:)))
		rightSwipe.numberOfTouchesRequired = 1
		rightSwipe.direction = .right
		
		addGestureRecognizer(rightSwipe)
	}
	
	func setupUpSwipe() {
		let upSwipe = UISwipeGestureRecognizer(target: self, action: #selector(onSwipe(_:)))
		upSwipe.numberOfTouchesRequired = 1
		upSwipe.direction = .up
		
		addGestureRecognizer(upSwipe)
	}
	
	func setupDownSwipe() {
		let downSwipe = UISwipeGestureRecognizer(target: self, action: #selector(onSwipe(_:)))
		downSwipe.numberOfTouchesRequired = 1
		downSwipe.direction = .down
		
		addGestureRecognizer(downSwipe)
	}
}

private extension GameScreenView {
	func setHandlers() {
		gameField.updateScoreHandler = { [ weak self ] score in
			self?.scoreInformationLabel.addScore(score)
			self?.updateScore?(score)
		}
	}
}
