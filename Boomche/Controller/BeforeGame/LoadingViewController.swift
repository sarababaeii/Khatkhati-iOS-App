//
//  LoadingViewController.swift
//  KhatKhati
//
//  Created by Sara Babaei on 3/22/20.
//  Copyright © 2020 Sara Babaei. All rights reserved.
//

import Foundation
import UIKit
import SwiftGifOrigin

class LoadingViewController: UIViewController {
    
    @IBOutlet weak var loadingBackgroundImage: UIImageView!
    
    @IBAction func back(_ sender: Any) {
        self.showNextPage(identifier: "JoinGameViewController")
    }
    
    //MARK: UI Handling
    func setLoadingBackgroundGif() {
        loadingBackgroundImage.loadGif(asset: "LoadingGif")
    }
    
    func configure() {
        setLoadingBackgroundGif()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        configure()
    }
}
