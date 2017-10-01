//
//  BrowserViewController.swift
//  VDownloader
//
//  Created by Ömer Turhan on 1.10.2017.
//  Copyright © 2017 Ömer Turhan. All rights reserved.
//

import UIKit

class BrowserViewController: UIViewController {

    var browserViewModel: BrowserViewModel?
    
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
        self.browserViewModel = BrowserViewModel()
    }
   

}
