//
//  BrowserViewModel.swift
//  VDownloader
//
//  Created by Ömer Turhan on 1.10.2017.
//  Copyright © 2017 Ömer Turhan. All rights reserved.
//

import UIKit

class BrowserViewModel: NSObject {
    
    func downloadVideo(playedVideoUrlString: String, videoName:String){
        DownloadManager.sharedInstance.downloadVideo(playedVideoUrlString: playedVideoUrlString,videoName: videoName)
    }
}
