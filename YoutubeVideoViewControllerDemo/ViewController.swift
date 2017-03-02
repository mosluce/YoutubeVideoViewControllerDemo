//
//  ViewController.swift
//  YoutubeVideoViewControllerDemo
//
//  Created by 默司 on 2017/3/2.
//  Copyright © 2017年 默司. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var playerViewController: YoutubeLikeVideoViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let vc = VideoListViewController()
        self.addChildViewController(vc)
        self.view.addSubview(vc.view)
        
        vc.delegate = self
        vc.view.frame = UIScreen.main.bounds
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension ViewController: VideoListViewControllerDelegate {
    func videoListViewController(_ viewController: UIViewController, didSelect videoUrl: URL) {
        if playerViewController == nil {
            self.playerViewController = YoutubeLikeVideoViewController()
            self.addChildViewController(playerViewController)
            self.view.addSubview(playerViewController.view)
            
            self.playerViewController.didMove(toParentViewController: self)
            self.playerViewController.view.frame = UIScreen.main.bounds
        }
        
        self.playerViewController.play(videoUrl: videoUrl)
        self.playerViewController.toMax()
    }
}
