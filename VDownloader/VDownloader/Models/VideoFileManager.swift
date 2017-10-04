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
    
    private override init() {
        super.init()
        retrieveVideoFilesArr()
    }
    
    func addNewVideoFile(videoFile:VideoFile){
        self.videoFilesArr.append(videoFile)
        saveVideoFilesArr()
    }
    
    func saveVideoFilesArr(){
        do {
            try Disk.save(videoFilesArr, to: .documents, as: "VideoFilesData.json")
            print("Saved")
        }catch let error {
            print(error.localizedDescription)
        }
       
    }
    
    func retrieveVideoFilesArr(){
        do{
            self.videoFilesArr = try Disk.retrieve("VideoFilesData.json", from: .documents , as: [VideoFile].self)
            print("Retrieved")
        }catch let error {
            print(error.localizedDescription)
        }
        
    }
    
}
