//
//  Downloader.swift
//  VDownloader
//
//  Created by Ömer Turhan on 4.10.2017.
//  Copyright © 2017 Ömer Turhan. All rights reserved.
//

import UIKit

protocol DownloaderDelegate {
    func videoDownloaded(downloader:Downloader, storePathForVideo:URL)
    func videoDownloadFailed(downloader:Downloader)
}
protocol DownloaderProgressUpdateDelegate {
    func updateDownloadedPercentage(percentage:Float)
}
class Downloader: NSObject {
    
    var playedVideoUrlString: String
    var videoName: String
    
    var downloaderDelegate: DownloaderDelegate?
    var downloaderProgressUpdateDelegate: DownloaderProgressUpdateDelegate?
    
    init(playedVideoUrlString: String, videoName:String, delegate:DownloaderDelegate) {
        self.playedVideoUrlString = playedVideoUrlString
        self.videoName = videoName
        self.downloaderDelegate = delegate
    }
    
    func startDownload(){
        guard let videoURL = URL(string: playedVideoUrlString) else { return }
        
        guard let documentsDirectoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        // check if the file already exist at the destination folder if you don't want to download it twice
        if !FileManager.default.fileExists(atPath: documentsDirectoryURL.appendingPathComponent(videoURL.lastPathComponent).path) {
            let config = URLSessionConfiguration.default
            let session = URLSession(configuration: config, delegate: self, delegateQueue: OperationQueue.main)
            // set up your download task
            let task = session.downloadTask(with: videoURL)
            task.resume()
        } else {
            print("File already exists at destination url")
        }
    }
}

extension Downloader : URLSessionDelegate, URLSessionDownloadDelegate {
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        print("Downloaded")
        guard let documentsDirectoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        let destinationURL = documentsDirectoryURL.appendingPathComponent("\(videoName).mp4") // Video might not be mp4, find a better way.
        do{
            try FileManager.default.moveItem(at: location, to: destinationURL)
            print("Documents Directory URL \(documentsDirectoryURL)")
            print("Location \(location)")
            print("DestinationUrl: \(destinationURL)")
            self.downloaderDelegate?.videoDownloaded(downloader: self, storePathForVideo: destinationURL)
        }catch{
            print("error")
            self.downloaderDelegate?.videoDownloadFailed(downloader: self)
        }
        
    }
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
        let percentage = Float(totalBytesWritten) / Float(totalBytesExpectedToWrite)
        self.downloaderProgressUpdateDelegate?.updateDownloadedPercentage(percentage: percentage)
        print("Downloaded: %\(percentage*100)")
    }
}

