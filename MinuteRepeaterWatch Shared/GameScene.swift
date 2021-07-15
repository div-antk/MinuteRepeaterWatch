//
//  GameScene.swift
//  MinuteRepeaterWatch Shared
//
//  Created by Takuya Ando on 2021/02/23.
//

import SpriteKit

class GameScene: SKScene {
    
    // 時計の針
    var hourHand:SKSpriteNode = SKSpriteNode()
    var minuteHand:SKSpriteNode = SKSpriteNode()
    var secondHand:SKSpriteNode = SKSpriteNode()
    
    var square:SKSpriteNode = SKSpriteNode()

    
    fileprivate var label : SKLabelNode?
//    fileprivate var spinnyNode : SKShapeNode?
    
    class func newGameScene() -> GameScene {
        // Load 'GameScene.sks' as an SKScene.
        guard let scene = SKScene(fileNamed: "GameScene") as? GameScene else {
            print("Failed to load GameScene.sks")
            abort()
        }
        
        // Set the scale mode to scale to fit the window
        scene.scaleMode = .aspectFill
        
        return scene
    }
    
    func setUpScene() {
        // Get label node from scene and store it for use later
        self.label = self.childNode(withName: "//helloLabel") as? SKLabelNode
        if let label = self.label {
            label.alpha = 0.0
            label.run(SKAction.fadeIn(withDuration: 2.0))
        }
        
        // Create shape node to use during mouse interaction
        // let w = (self.size.width + self.size.height) * 0.05
        // self.spinnyNode = SKShapeNode.init(rectOf: CGSize.init(width: w, height: w), cornerRadius: w * 0.3)
        
//        if let spinnyNode = self.spinnyNode {
//            spinnyNode.lineWidth = 4.0
//            spinnyNode.run(SKAction.repeatForever(SKAction.rotate(byAngle: CGFloat(Double.pi), duration: 1)))
//            spinnyNode.run(SKAction.sequence([SKAction.wait(forDuration: 0.5),
//                                              SKAction.fadeOut(withDuration: 0.5),
//                                              SKAction.removeFromParent()]))
//
//            #if os(watchOS)
//                // For watch we just periodically create one of these and let it spin
//                // For other platforms we let user touch/mouse events create these
//                spinnyNode.position = CGPoint(x: 0.0, y: 0.0)
//                // spinnyNode.strokeColor = SKColor.red
//                self.run(SKAction.repeatForever(SKAction.sequence([SKAction.wait(forDuration: 2.0),
//                                                                   SKAction.run({
//                                                                       let n = spinnyNode.copy() as! SKShapeNode
//                                                                       self.addChild(n)
//                                                                   })])))
//            #endif
//        }
    }
    
    #if os(watchOS)
    override func sceneDidLoad() {
        
        // 時針
        if let hrHand:SKSpriteNode = self.childNode(withName: "HourHand") as? SKSpriteNode {
            hourHand = hrHand
        }
        
        // 分針
        if let minHand:SKSpriteNode = self.childNode(withName: "MinuteHand") as? SKSpriteNode {
            minuteHand = minHand
        }
        
        // 秒針
        if let secHand:SKSpriteNode = self.childNode(withName: "SecondHand") as? SKSpriteNode {
            secondHand = secHand
        }
        
        self.setUpScene()
    }
    #else
    override func didMove(to view: SKView) {
        self.setUpScene()
    }
    #endif

//    func makeSpinny(at pos: CGPoint, color: SKColor) {
//        if let spinny = self.spinnyNode?.copy() as! SKShapeNode? {
//            spinny.position = pos
//            // spinny.strokeColor = color
//            self.addChild(spinny)
//        }
//    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        let date = Date()
        
        // 時刻の取得
        let calender = Calendar.current
        let hour = CGFloat(calender.component(.hour, from: date))
        let minutes = CGFloat(calender.component(.minute, from: date))
        let seconds = CGFloat(calender.component(.second, from: date))
        
        // 針の動く設定
        hourHand.zRotation = -1 * deg2rad(hour * 30 + minutes/2)
        minuteHand.zRotation = -1 * deg2rad(minutes * 6)
        secondHand.zRotation = -1 * deg2rad(seconds * 6)
    }
    
    // 度からラジアン
    func deg2rad(_ number: CGFloat) -> CGFloat {
        return number * .pi / 180
    }
}

#if os(iOS) || os(tvOS)
// Touch-based event handling
//extension GameScene {
//
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        if let label = self.label {
//            label.run(SKAction.init(named: "Pulse")!, withKey: "fadeInOut")
//        }
//
//        for t in touches {
//            self.makeSpinny(at: t.location(in: self), color: SKColor.green)
//        }
//    }
//
//    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
//        for t in touches {
//            self.makeSpinny(at: t.location(in: self), color: SKColor.blue)
//        }
//    }
//
//    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
//        for t in touches {
//            self.makeSpinny(at: t.location(in: self), color: SKColor.red)
//        }
//    }
//
//    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
//        for t in touches {
//            self.makeSpinny(at: t.location(in: self), color: SKColor.red)
//        }
//    }
//
//
//}
#endif

#if os(OSX)
// Mouse-based event handling
extension GameScene {

    override func mouseDown(with event: NSEvent) {
        if let label = self.label {
            label.run(SKAction.init(named: "Pulse")!, withKey: "fadeInOut")
        }
        self.makeSpinny(at: event.location(in: self), color: SKColor.green)
    }
    
    override func mouseDragged(with event: NSEvent) {
        self.makeSpinny(at: event.location(in: self), color: SKColor.blue)
    }
    
    override func mouseUp(with event: NSEvent) {
        self.makeSpinny(at: event.location(in: self), color: SKColor.red)
    }

}
#endif

//func setupButton() {
//
//    let Rect = CGRect(x: 0, y: 0, width: 40, height: 40)
//    let citcle = UIBezierPath(ovalIn: Rect)
//}
