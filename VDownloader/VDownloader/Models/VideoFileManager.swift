//
//  VideoFileManager.swift
//  VDownloader
//
//  Created by Ömer Turhan on 4.10.2017.
//  Copyright © 2017 Ömer Turhan. All rights reserved.
//

import UIKit
import Disk

class VideoFileManager: NSObject {
    static let sharedInstance = VideoFileManager()

    var videoFilesArr: [VideoFile] = []
  
    let storedJsonFileName = "VideoFilesData.json"
  
    private override init() {
        super.init()
        retrieveVideoFilesArr()
    }
    
    func addNewVideoFile(videoFile:VideoFile){
        self.videoFilesArr.append(videoFile)
        saveVideoFilesArr()
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: NSNotification.Name.RawValue("VideoDownloaded")), object: nil,userInfo:["DownloadedFileName":"\(videoFile.videoName)"])
    }
    
    func saveVideoFilesArr(){
        do {
            try Disk.save(videoFilesArr, to: .documents, as: storedJsonFileName)
            print("Saved")
        }catch let error {
            print(error.localizedDescription)
        }
       
    }
    
    func retrieveVideoFilesArr(){
        do{
            self.videoFilesArr = try Disk.retrieve(storedJsonFileName, from: .documents , as: [VideoFile].self)
            print("Retrieved")
        }catch let error {
            print(error.localizedDescription)
        }
        
    }
    
}
