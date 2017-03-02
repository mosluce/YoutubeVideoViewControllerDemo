//
//  VideoListViewController.swift
//  YoutubeVideoViewControllerDemo
//
//  Created by 默司 on 2017/3/2.
//  Copyright © 2017年 默司. All rights reserved.
//

import UIKit

class VideoListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let videos: [String] = [
        "https://content.jwplatform.com/manifests/vM7nH0Kl.m3u8",
        "https://content.jwplatform.com/manifests/vM7nH0Kl.m3u8",
        "https://content.jwplatform.com/manifests/vM7nH0Kl.m3u8",
        "https://content.jwplatform.com/manifests/vM7nH0Kl.m3u8",
        "https://content.jwplatform.com/manifests/vM7nH0Kl.m3u8",
        "https://content.jwplatform.com/manifests/vM7nH0Kl.m3u8",
        "https://content.jwplatform.com/manifests/vM7nH0Kl.m3u8",
        "https://content.jwplatform.com/manifests/vM7nH0Kl.m3u8",
        "https://content.jwplatform.com/manifests/vM7nH0Kl.m3u8",
        "https://content.jwplatform.com/manifests/vM7nH0Kl.m3u8",
        "https://content.jwplatform.com/manifests/vM7nH0Kl.m3u8",
        "https://content.jwplatform.com/manifests/vM7nH0Kl.m3u8",
        "https://content.jwplatform.com/manifests/vM7nH0Kl.m3u8",
        "https://content.jwplatform.com/manifests/vM7nH0Kl.m3u8",
        "https://content.jwplatform.com/manifests/vM7nH0Kl.m3u8",
        "https://content.jwplatform.com/manifests/vM7nH0Kl.m3u8",
        "https://content.jwplatform.com/manifests/vM7nH0Kl.m3u8",
        "https://content.jwplatform.com/manifests/vM7nH0Kl.m3u8",
        "https://content.jwplatform.com/manifests/vM7nH0Kl.m3u8",
        "https://content.jwplatform.com/manifests/vM7nH0Kl.m3u8",
        "https://content.jwplatform.com/manifests/vM7nH0Kl.m3u8",
        "https://content.jwplatform.com/manifests/vM7nH0Kl.m3u8",
        "https://content.jwplatform.com/manifests/vM7nH0Kl.m3u8",
        "https://content.jwplatform.com/manifests/vM7nH0Kl.m3u8",
        "https://content.jwplatform.com/manifests/vM7nH0Kl.m3u8",
        "https://content.jwplatform.com/manifests/vM7nH0Kl.m3u8",
        "https://content.jwplatform.com/manifests/vM7nH0Kl.m3u8",
        "https://content.jwplatform.com/manifests/vM7nH0Kl.m3u8",
        "http://xapp510394368c1000199.f.l.z.lb.core-cdn.net/10096xtelebase/ios_500/.m3u8",
        "http://xapp510394368c1000199.f.l.z.lb.core-cdn.net/10096xtelebase/ios_500/.m3u8",
        "http://xapp510394368c1000199.f.l.z.lb.core-cdn.net/10096xtelebase/ios_500/.m3u8"
    ]
    
    weak var delegate: VideoListViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.tableView.register(VideoListItemCell.self, forCellReuseIdentifier: "VideoListItemCell")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension VideoListViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "VideoListItemCell") as! VideoListItemCell
        
        cell.textLabel?.text = "\(indexPath.row + 1)"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let url = URL(string: videos[indexPath.row])!
        
        self.delegate?.videoListViewController(self, didSelect: url)
    }
}

protocol VideoListViewControllerDelegate: class {
    func videoListViewController(_ viewController: UIViewController, didSelect videoUrl: URL)
}
