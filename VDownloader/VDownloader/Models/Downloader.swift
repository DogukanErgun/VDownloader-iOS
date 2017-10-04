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

class Downloader: NSObject {
    
    var playedVideoUrlString: String
    var videoName: String
    
    var delegate: DownloaderDelegate?
    
    init(playedVideoUrlString: String, videoName:String, delegate:DownloaderDelegate) {
        self.playedVideoUrlString = playedVideoUrlString
        self.videoName = videoName
        self.delegate = delegate
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
        let destinationURL = documentsDirectoryURL.appendingPathComponent("\(videoName).mp4")
        do{
            try FileManager.default.moveItem(at: location, to: destinationURL)
            print("Location \(location)")
            print("DestinationUrl: \(destinationURL)")
            self.delegate?.videoDownloaded(downloader: self, storePathForVideo: destinationURL)
        }catch{
            print("error")
            self.delegate?.videoDownloadFailed(downloader: self)
        }
        
    }
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
        let percentage = Float(totalBytesWritten) / Float(totalBytesExpectedToWrite)
        print("Downloaded: %\(percentage*100)")
    }
}

