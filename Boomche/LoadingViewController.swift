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
    
    //MARK: Socket Management
    //It would be more clear if it was implemented in SocketIOManager class
    func addSocketHandler() {
        SocketIOManager.sharedInstance.socket?.on("start_game") { data, ack in
            print("^^^^^RECEIVING WORDS^^^^^^")
            
            let temp = data[0] as! [String : Any]
                    
            ChoosingWordViewController.words = temp["words"] as? [String]
            self.determiningNextPage(username: temp["username"] as! String)
                    
//            if let username = GameConstants.username,
//                username == temp["username"] as! String {
//                    self.words = temp["words"] as! [String]
//            }
        }
    }
    
    func determiningNextPage(username: String) {
        if GameConstants.username == username {
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
        loadingBackgroundImage.loadGif(asset: "LoadingGif")
    }
    
    var counter = 3

    func on() {
        Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
    }

    @objc func updateCounter() {
        if counter > 0 {
            counter -= 1
        }

        if counter == 0 {
//            SocketIOManager.sharedInstance.startGame(roomID: GameConstants.roomID!)
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let controller = storyboard.instantiateViewController(withIdentifier: "GuessingViewController") as UIViewController
//            let controller = storyboard.instantiateViewController(withIdentifier: "DrawingViewController") as UIViewController
            controller.modalPresentationStyle = .fullScreen
            controller.modalTransitionStyle = .coverVertical
            present(controller, animated: true, completion: nil)
        }
    }
    
    func configure() {
        setLoadingBackgroundGif()

//        addSocketHandler()
        
        on()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        configure()
        SocketIOManager.sharedInstance.shareStatus()
    }
}
