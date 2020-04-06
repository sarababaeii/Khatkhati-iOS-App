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
    
    func determiningNextPage(username: String) {
        if GameConstants.username! == username {
            showNextPage("DrawingViewController")
        } else {
            showNextPage("GuessingViewController")
        }
    }
    
    func showNextPage(_ identifier: String) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: identifier) as UIViewController
        controller.modalPresentationStyle = .fullScreen
        controller.modalTransitionStyle = .coverVertical
        present(controller, animated: true, completion: nil)
    }
    
    //MARK: UI Handling
    func setLoadingBackgroundGif() {
        loadingBackgroundImage.loadGif(asset: "loading")
    }
    
//    var counter = 3
//
//    func on() {
//        Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
//    }
//
//    @objc func updateCounter() {
//        if counter > 0 {
//            counter -= 1
//        }
//
//        if counter == 0 {
//            showNextPage()
//        }
//    }
    
    func configure() {
        setLoadingBackgroundGif()

//        on()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        configure()
        SocketIOManager.sharedInstance.shareStatus()
    }
}
