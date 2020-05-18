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

    static var parentStoryboardID: String?
    
    @IBOutlet weak var loadingBackgroundImage: UIImageView!
    
    @IBAction func back(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: LoadingViewController.parentStoryboardID!) as UIViewController
        controller.modalPresentationStyle = .fullScreen
        controller.modalTransitionStyle = .flipHorizontal
        present(controller, animated: true, completion: nil)
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
