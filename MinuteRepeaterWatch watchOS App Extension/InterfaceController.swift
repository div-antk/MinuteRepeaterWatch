//
//  InterfaceController.swift
//  MinuteRepeaterWatch watchOS App Extension
//
//  Created by Takuya Ando on 2021/02/23.
//

import WatchKit
import Foundation
import AVFoundation

class InterfaceController: WKInterfaceController {

    @IBOutlet var skInterface: WKInterfaceSKScene!
    
    // ゴング音
    private var highGongPlayer:AVAudioPlayer?
    private var lowGongPlayer:AVAudioPlayer?

    // 再生中かどうか
    private var isPlaying = false
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        let scene = GameScene.newGameScene()
        
        // Present the scene
        self.skInterface.presentScene(scene)
        
        // Use a preferredFramesPerSecond that will maintain consistent frame rate
        self.skInterface.preferredFramesPerSecond = 30
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

    // 再生ボタン
    @IBAction func startButton() {
        if isPlaying { return }
        isPlaying = true
        
        repeater()
    }
    
    // リピーター機能
    func repeater() {
        
        DispatchQueue.global().async {
            
            let now = Date()
            let time = Calendar.current.dateComponents([.hour, .minute], from: now)
            
            // hour を12時間で丸める
            let hour = time.hour! % 12
            let quarter = time.minute! / 15
            let minute = time.minute! % 15
            
            self.first(hour: hour)
            self.second(quarter: quarter)
            self.third(minute: minute)
            
//             第一ゴング
//            for _ in 0 ..< hour {
//                print("dong")
//                self.lowGong()
//                // 0.5秒待つ
//                Thread.sleep(forTimeInterval: 0.5)
//            }
            
//            // 第二ゴングが鳴る場合遅延処理
//            if quarter > 0 {
//                Thread.sleep(forTimeInterval: 0.7)
//            }
//
//            // 第二ゴング
//            for _ in 0 ..< quarter {
//                print("ding-dong")
//                self.highGong()
//                // 0.4秒待つ
//                Thread.sleep(forTimeInterval: 0.4)
//                self.lowGong()
//
//                // 0.5秒待つ
//                Thread.sleep(forTimeInterval: 0.5)
//            }
            
//            // 第三ゴングが鳴る場合遅延処理
//            if minute > 0 {
//                Thread.sleep(forTimeInterval: 0.7)
//            }
//
//            // 第三ゴング
//            for _ in 0 ..< minute {
//                print("ding")
//                self.highGong()
//
//                // 0.5秒待つ
//                Thread.sleep(forTimeInterval: 0.5)
//            }
            self.isPlaying = false
        }
    }
    
    private func first(hour: Int) {
        // 第一ゴング
        for _ in 0 ..< hour {
            print("dong")
            self.lowGong()
            // 0.5秒待つ
            Thread.sleep(forTimeInterval: 0.5)
        }
    }
    
    private func second(quarter: Int) {
        // 第二ゴングが鳴る場合遅延処理
        if quarter > 0 {
            Thread.sleep(forTimeInterval: 0.7)
        }
        
        // 第二ゴング
        for _ in 0 ..< quarter {
            print("ding-dong")
            self.highGong()
            // 0.4秒待つ
            Thread.sleep(forTimeInterval: 0.4)
            self.lowGong()
            
            // 0.5秒待つ
            Thread.sleep(forTimeInterval: 0.5)
        }
    }
    
    private func third(minute: Int) {
        // 第三ゴングが鳴る場合遅延処理
        if minute > 0 {
            Thread.sleep(forTimeInterval: 0.7)
        }
        
        // 第三ゴング
        for _ in 0 ..< minute {
            print("ding")
            self.highGong()
            
            // 0.5秒待つ
            Thread.sleep(forTimeInterval: 0.5)
        }
    }
    
    // 低音
    func lowGong() {
        
        let lowGong = Bundle.main.url(forResource: "low", withExtension: "wav")
        
        do {
            lowGongPlayer = try AVAudioPlayer(contentsOf: lowGong!)
            lowGongPlayer?.play()
        } catch {
            print("error")
        }
    }
    
    // 高音
    func highGong() {
        
        let highGong = Bundle.main.url(forResource: "high", withExtension: "wav")
        do {
            highGongPlayer = try AVAudioPlayer(contentsOf: highGong!)
            highGongPlayer?.play()
        } catch {
            print("error")
        }
    }
}
