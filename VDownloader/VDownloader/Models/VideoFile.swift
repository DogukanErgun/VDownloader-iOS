//
//  VideoFile.swift
//  VDownloader
//
//  Created by Ömer Turhan on 4.10.2017.
//  Copyright © 2017 Ömer Turhan. All rights reserved.
//

import UIKit

class VideoFile: Codable {
    var videoName: String
    var storePathForVideo: URL
    
    init(videoName:String,storePathForVideo:URL) {
        self.videoName = videoName
        self.storePathForVideo = storePathForVideo
    }
    
}
