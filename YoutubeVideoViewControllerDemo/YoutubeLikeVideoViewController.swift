//
//  YoutubeLikeVideoViewController.swift
//  YoutubeVideoViewControllerDemo
//
//  Created by 默司 on 2017/3/2.
//  Copyright © 2017年 默司. All rights reserved.
//

import UIKit
import AVFoundation

class YoutubeLikeVideoViewController: UIViewController {

    @IBOutlet weak var viewRectView: UIView!
    @IBOutlet weak var infoContainerView: UIView!
    
    var minWidth: CGFloat {
        return UIScreen.main.bounds.size.width / 4
    }
    
    var minHeight: CGFloat {
        return minWidth / 16 * 9
    }
    
    var maxOffset: CGFloat {
        return UIScreen.main.bounds.size.height - minHeight
    }
    
    var origHeight: CGFloat {
        return UIScreen.main.bounds.size.height
    }
    
    var origWidth: CGFloat {
        return UIScreen.main.bounds.size.width
    }
    
    var startPosition: CGPoint = .zero
    var startOffset: CGFloat = 0
    var currentOffset: CGFloat = 0
    
    var tap: UITapGestureRecognizer!
    
    var player: AVPlayer = AVPlayer()
    var playerLayer: AVPlayerLayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.view.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(panHandler(_:))))
        
        self.tap = UITapGestureRecognizer(target: self, action: #selector(tap(_:)))
        self.tap.isEnabled = false
        self.view.addGestureRecognizer(tap)
        
        self.playerLayer = AVPlayerLayer(player: player)
        self.playerLayer.backgroundColor = UIColor.black.cgColor
        
        self.view.layer.addSublayer(playerLayer)
        
        NotificationCenter.default.addObserver(self, selector: #selector(deviceOrientationDidChange(_:)), name: .UIDeviceOrientationDidChange, object: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.playerLayer.frame = self.viewRectView.frame
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    func deviceOrientationDidChange(_ notification: Notification) {
        self.toMax()
        
        switch UIDevice.current.orientation {
        case .landscapeLeft:
            self.playerLayer.transform = CATransform3DMakeRotation(CGFloat.pi / 2, 0, 0, 1)
            self.playerLayer.frame = UIScreen.main.bounds
            break
        case .landscapeRight:
            self.playerLayer.transform = CATransform3DMakeRotation(CGFloat.pi / -2, 0, 0, 1)
            self.playerLayer.frame = UIScreen.main.bounds
            break
        default:
            self.playerLayer.transform = CATransform3DMakeRotation(0, 0, 0, 1)
            self.playerLayer.frame = CGRect(origin: .zero, size: CGSize(width: origWidth, height: origWidth / 16 * 9))
            break
        }
    }
    
    func tap(_: UITapGestureRecognizer) {
        self.toMax()
    }
    
    func panHandler(_ gesture: UIPanGestureRecognizer) {
        switch gesture.state {
        case .began:
            self.startPosition = gesture.translation(in: self.view.superview)
            break
        case .changed:
            let position = gesture.translation(in: self.view.superview)
            
            self.currentOffset = position.y - startPosition.y
            
            let newY = startOffset + currentOffset
            var newHeight = origHeight - newY
            
            newHeight = min(newHeight, origHeight)
            newHeight = max(newHeight, minHeight)
            
            let rate = newHeight / origHeight
            
            var newWidth = origWidth * rate
            
            newWidth = min(newWidth, origWidth)
            newWidth = max(newWidth, minWidth)
            
            let newX = origWidth - newWidth
            
            self.view.frame = CGRect(origin: CGPoint(x: newX, y: newY), size: CGSize(width: newWidth, height: newHeight))
            self.infoContainerView.alpha = (newWidth - minWidth) / origWidth
            
            CATransaction.begin()
            CATransaction.setDisableActions(true)
            self.playerLayer.frame = CGRect(origin: .zero, size: CGSize(width: newWidth, height: newWidth / 16 * 9))
            CATransaction.commit()
            
            break
        case .ended:
            
            if self.currentOffset > origHeight / 3 {
                self.toMin()
            } else {
                self.toMax()
            }
            
            break
        default:
            break
        }
    }
    
    func toMin() {
        let x = origWidth - minWidth
        let y = origHeight - minHeight
        
        UIView.animate(withDuration: 0.2) { 
            self.view.frame = CGRect(x: x, y: y, width: self.minWidth, height: self.minHeight)
            self.view.layoutIfNeeded()
        }
        
        self.playerLayer.frame = self.viewRectView.frame
        self.startOffset = maxOffset
        self.tap.isEnabled = true
    }
    
    func toMax() {
        UIView.animate(withDuration: 0.2) {
            self.view.frame = CGRect(origin: .zero, size: CGSize(width: self.origWidth, height: self.origHeight))
            self.view.layoutIfNeeded()
        }
        
        self.playerLayer.frame = self.viewRectView.frame
        self.startOffset = 0
        self.tap.isEnabled = false
    }
    
    func play(videoUrl url: URL) {
        self.player.pause()
        self.player.replaceCurrentItem(with: AVPlayerItem(url: url))
        self.player.play()
    }
}
