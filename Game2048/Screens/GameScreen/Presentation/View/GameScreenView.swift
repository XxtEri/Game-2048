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
	var restartButtonTappedHandler: (() -> Void)?
	
	private enum Metrics {
		static let gameGieldHorizontalInset: CGFloat = 10
	}
	
	private let gameFieldWidth: CGFloat
	private let gameFieldHeight: CGFloat
	
	// MARK: - Views
	lazy var gameField = GameFieldView(fieldWidth: gameFieldWidth, fieldHeight: gameFieldHeight)
	
	private lazy var titleGameLabel: UILabel = {
		let view = UILabel()
		view.text = R.string.gameScreen.title_game()
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
	
	private lazy var scoreInformationLabel = ScoreBlockView(title: R.string.gameScreen.title_score_block())
	private lazy var bestScoreInformationLabel = ScoreBlockView(title: R.string.gameScreen.title_max_score_block())
	
	private lazy var buttonsStack: UIStackView = {
		let view = UIStackView()
		view.axis = .horizontal
		view.spacing = 20
		
		return view
	}()
	
//	private lazy var goBackStepButton: UIButton = {
//		let view = UIButton()
//		view.setImage(R.image.backStep(), for: .normal)
//		view.contentMode = .scaleAspectFit
//
//		return view
//	}()
	
	private lazy var restartButton: UIButton = {
		let view = UIButton()
		view.setImage(R.image.restart(), for: .normal)
		view.contentMode = .scaleAspectFit
		
		return view
	}()
	
	private lazy var nonActiveBackgroundView: UIView = {
		let view = UIView()
		view.backgroundColor = .gray.withAlphaComponent(0.3)
		
		return view
	}()
	
	private lazy var gameEndLabel: UILabel = {
		let view = UILabel()
		view.textColor = R.color.text()
		view.textAlignment = .center
		view.font = UIFont.systemFont(ofSize: 40, weight: .bold)
		
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
	
	func showGameEnd(message: String) {
		gameEndLabel.text = message
		
		gameField.addSubview(nonActiveBackgroundView)
		nonActiveBackgroundView.addSubview(gameEndLabel)
		
		nonActiveBackgroundView.snp.makeConstraints { make in
			make.edges.equalToSuperview()
		}
		
		gameEndLabel.snp.makeConstraints { make in
			make.center.equalToSuperview()
		}
		
		removeSwipeGectureRecognizers()
	}
	
	func restorePlay() {
		gameEndLabel.removeFromSuperview()
		nonActiveBackgroundView.removeFromSuperview()
		
		
		gameField.swipeDelegate?.configureSwipes()
	}
}

extension GameScreenView: SwipeDelegate {
	func configureSwipes() {
		setupLeftSwipe()
		setupRightSwipe()
		setupUpSwipe()
		setupDownSwipe()
	}
}

// MARK: - Setup extension
private extension GameScreenView {
	func setup() {
		configureUI()
		configureConstraints()
		configureActions()
		
		gameField.setSwipeDelegate(self)
	}
	
	func configureUI() {
		backgroundColor = R.color.gameScreenBackground()
		addSubview(titleGameLabel)
		addSubview(gameScoreInformationStack)
		addSubview(buttonsStack)
		addSubview(gameField)
		
		gameScoreInformationStack.addArrangedSubview(scoreInformationLabel)
		gameScoreInformationStack.addArrangedSubview(bestScoreInformationLabel)
		
		//buttonsStack.addArrangedSubview(goBackStepButton)
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
			make.top.greaterThanOrEqualTo(buttonsStack.snp.bottom).offset(20).priority(.high)
			make.center.equalToSuperview().inset(10).priority(.low)
			make.width.equalTo(gameFieldWidth)
			make.height.equalTo(gameFieldHeight)
		}
		
//		goBackStepButton.snp.makeConstraints { make in
//			make.size.equalTo(30)
//		}
		
		restartButton.snp.makeConstraints { make in
			make.size.equalTo(30)
		}
	}
	
	func configureActions() {
		configureSwipes()
		restartButton.addTarget(self, action: #selector(restartButtonTapped(_:)), for: .touchUpInside)
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
	
	@objc
	func restartButtonTapped(_ sender: UIButton) {
		restartButtonTappedHandler?()
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
	
	func removeSwipeGectureRecognizers() {
		gestureRecognizers?.forEach({ gestureRecognizer in
			if let swipe = gestureRecognizer as? UISwipeGestureRecognizer {
				removeGestureRecognizer(swipe)
			}
		})
	}
}

private extension GameScreenView {
	func setHandlers() {
		gameField.updateScoreHandler = { [ weak self ] score in
			self?.scoreInformationLabel.addScore(score / 2)
			self?.updateScore?(self?.scoreInformationLabel.score ?? 0)
		}
	}
}
