//
//  BrowserViewController.swift
//  VDownloader
//
//  Created by Ömer Turhan on 1.10.2017.
//  Copyright © 2017 Ömer Turhan. All rights reserved.
//

import UIKit
import WebKit
import AVFoundation
import SCLAlertView
class BrowserViewController: UIViewController {

    @IBOutlet weak var browserTextField: UITextField!
    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var downloadButtonView: UIView!
    
    var alertView: SCLAlertView?
    
    var playedVideoUrlString: String = "" {
        didSet{
            if playedVideoUrlString == "" {
                hideDownloadButtonView()
            }else{
                displayDownloadButtonView()
            }
        }
    }
    
    //MARK: - View Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    func setup(){

        
        //Registration to receive url path of playing video (usage prohibited in AppStore)
         NotificationCenter.default.addObserver(self, selector: #selector(self.playerItemRunning), name: NSNotification.Name(rawValue: "AVPlayerItemBecameCurrentNotification"), object: nil)
    }
    
    func makeBrowserRequestFromString(link:String) {
        self.webView.loadRequest(URLRequest(url: URL(string: "http://\(link)")! as URL) as URLRequest)
    }
    
    @objc func playerItemRunning(notification: NSNotification){
        if let playerItem = notification.object as? AVPlayerItem {
            let asset = playerItem.asset as! AVURLAsset
            let url = asset.url
            let path = url.absoluteString
            self.playedVideoUrlString = path
        }
    }
    
    func displayDownloadButtonView(){
        UIView.animate(withDuration: 0.3) {
            self.downloadButtonView.alpha = 1
        }
    }
    
    func hideDownloadButtonView(){
        UIView.animate(withDuration: 0.3) {
            self.downloadButtonView.alpha = 0
        }
    }
    
    // Displaying alertview to get filename
    fileprivate func displayAlertView() {
        let alertApperance = SCLAlertView.SCLAppearance(
            showCloseButton : false
        )
        self.alertView = SCLAlertView(appearance:alertApperance)
        
        let textField = alertView?.addTextField("ENTER MA NAME HUMAN")
        
        alertView!.addButton("Download"){
            print("Downlaod started video name:\(String(describing: textField?.text))")
            DownloadManager.sharedInstance.downloadVideo(playedVideoUrlString: self.playedVideoUrlString,videoName: (textField?.text)!)
        }
        
        alertView!.addButton("Cancel") {
            print("Download cancelled.")
        }
        
        alertView!.showInfo("Download", subTitle: "Please enter video name:")
    }
    
    //MARK: - IBAction Funcs
    
    @IBAction func goButtonClicked(_ sender: Any) {
        let link = self.browserTextField.text!
        self.makeBrowserRequestFromString(link: link)
        self.browserTextField.resignFirstResponder()
    }
    
    @IBAction func downloadButtonClicked(_ sender: Any) {
        displayAlertView()
    }
    
}

extension BrowserViewController: UIWebViewDelegate{
    func webViewDidFinishLoad(_ webView: UIWebView) {
        self.playedVideoUrlString = ""
    }
}

extension BrowserViewController: UITextFieldDelegate{
    func textFieldDidEndEditing(_ textField: UITextField) {
        let link = textField.text!
        self.makeBrowserRequestFromString(link: link)
        textField.resignFirstResponder()
    }
}
