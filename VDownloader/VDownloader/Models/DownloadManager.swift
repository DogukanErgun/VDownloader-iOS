//
//  DownloadManager.swift
//  VDownloader
//
//  Created by Ömer Turhan on 4.10.2017.
//  Copyright © 2017 Ömer Turhan. All rights reserved.
//

import UIKit

class DownloadManager: NSObject {
    static let sharedInstance = DownloadManager()
    
    var downloaderArr: [Downloader] = []
    private override init() {} //This prevents others from using the default '()' initializer for this class.
    
    func downloadVideo(playedVideoUrlString: String, videoName:String){
        let downloader = Downloader(playedVideoUrlString: playedVideoUrlString, videoName: videoName, delegate: self)
        downloader.startDownload()
        downloaderArr.append(downloader)
    }
    
}

extension DownloadManager: DownloaderDelegate {
    func videoDownloaded(downloader:Downloader, storePathForVideo:URL) {
        
        let videoFile = VideoFile(videoName: downloader.videoName, storePathForVideo: storePathForVideo)
        VideoFileManager.sharedInstance.addNewVideoFile(videoFile: videoFile)
        
        if let downloaderIndex = self.downloaderArr.index(of: downloader) {
              self.downloaderArr.remove(at: downloaderIndex)
        }

    }
    
    func videoDownloadFailed(downloader:Downloader) {
        
    }
}
