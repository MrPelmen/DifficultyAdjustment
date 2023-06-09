//
//  GameViewController.swift
//  DifficultyAdjustment
//
//  Created by Andriiko on 13.03.2023.
//

import UIKit
import SpriteKit

final class GameViewController: UIViewController {
    @IBOutlet private var difficultyLabel: UILabel!
    @IBOutlet private var lastActionLabel: UILabel!
    @IBOutlet private var labelsStackView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let view = self.view as! SKView? else { return }
        
        let scene = GameScene(size: AppConstants.sceneSize)
        scene.scaleMode = .aspectFill
        scene.gameStateDelegate = self
        view.presentScene(scene)
        setupStackGesture()
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        .landscape
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    private func setupStackGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(toggleStack))
        tap.numberOfTapsRequired = 3
        
        view.addGestureRecognizer(tap)
    }
    
    @objc private func toggleStack() {
        labelsStackView.alpha = labelsStackView.alpha.isZero ? 1.0 : .zero
    }
    
    deinit {
        print("Deinitialized game vc")
    }
}

extension GameViewController: GameStateDelegate {
    func end(with time: TimeInterval) {
        let minutes = Int(time / 60)
        let seconds = Int(time) % 60
        
        let minutesString = String(format: "%02d", minutes)
        let secondsString = String(format: "%02d", seconds)
        
        guard let endGameVC = UIStoryboard(name: "Main", bundle: nil)
            .instantiateViewController(
                withIdentifier: String(describing: LoseController.self)
            ) as? LoseController,
              let controllers = navigationController?.viewControllers
        else { return }
        
        endGameVC.lastedTime = "\(minutesString):\(secondsString)"
        
        let newVcStack = controllers.filter { !($0 is GameViewController) } + [endGameVC]
        
        navigationController?.setViewControllers(newVcStack, animated: true)
    }
    
    func updateAction(_ difficulty: CGFloat, lastAction: CGFloat) {
        difficultyLabel.text = "Difficulty: \(difficulty.description.prefix(7))"
        lastActionLabel.text = "Last action: \(lastAction.description.prefix(7))"
    }
}
