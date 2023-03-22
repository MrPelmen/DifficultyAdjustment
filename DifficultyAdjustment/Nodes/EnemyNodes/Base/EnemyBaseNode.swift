//
//  EnemyNode.swift
//  DifficultyAdjustment
//
//  Created by Andriiko on 16.03.2023.
//

import SpriteKit

class EnemyBaseNode: SKSpriteNode {
    var moveDirection: CGVector
    var moveSpeed: CGFloat
    var damageOnHit: CGFloat
    var shootFrequency: TimeInterval
    weak var healthDelegate: HealthDelegate?
    
    private var lastShotTime: TimeInterval = 0.0
    
    init(
        texture: SKTexture,
        healthDelegate: HealthDelegate?,
        moveSpeed: CGFloat = 5.0,
        moveDirection: CGVector = CGVector(dx: 1, dy: 0),
        shootDirection: CGVector = CGVector(dx: 0, dy: 1),
        shootFrequency: TimeInterval = 2.0,
        damageOnHit: CGFloat = 0.1,
        lastShotTime: TimeInterval = 0.0
    ) {
        self.moveSpeed = moveSpeed
        self.moveDirection = moveDirection
        self.shootFrequency = shootFrequency
        self.lastShotTime = lastShotTime
        self.damageOnHit = damageOnHit
        
        super.init(texture: texture, color: .clear, size: texture.size())
        
        zRotation = atan2(moveDirection.dy, moveDirection.dx) - CGFloat.pi/2
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func update() {
        let dx = moveDirection.dx * moveSpeed
        let dy = moveDirection.dy * moveSpeed
        position = CGPoint(x: position.x + dx, y: position.y + dy)

        shoot()
    }
    
    func shoot() {
        let currentTime = CACurrentMediaTime()
        if currentTime - lastShotTime < shootFrequency {
            return
        }
        
        lastShotTime = currentTime
        
        let bullet = Bullet(owner: .enemy, color: .red, size: .init(width: 5, height: 5))
        bullet.fire(from: position, in: zRotation)
        
        parent?.addChild(bullet)
    }
}

extension EnemyBaseNode: ColliderProtocol {
    func collide(with other: SKPhysicsBody, in scene: SKScene) {
        
    }
}