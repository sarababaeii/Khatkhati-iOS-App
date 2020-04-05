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
    
    var counter = 3
    
    func setLoadingBackgroundGif() {
        loadingBackgroundImage.loadGif(asset: "loading")
    }
    
    func on() {
        Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
    }
    
    @objc func updateCounter() {
        if counter > 0 {
            counter -= 1
        }
        
        if counter == 0 {
            showNextPage()
        }
    }
    
    func showNextPage() {
        
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let controller = storyboard.instantiateViewController(withIdentifier: "DrawingViewController")
//        self.present(controller, animated: true, completion: nil)

        // Safe Present
        if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DrawingViewController") as? DrawingViewController
        {
            present(vc, animated: true, completion: nil)
        }
//
        
        
//        let VC = self.storyboard?.instantiateViewController(withIdentifier: "DrawingViewController") as! DrawingViewController
//        
//        self.present(VC, animated: true, completion: nil)
        
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        if #available(iOS 13.0, *) {
//            let secondVC = storyboard.instantiateViewController(identifier: "DrawingViewController")
//
//            show(secondVC, sender: self)
//        } else {
//            // Fallback on earlier versions
//            print("NASHOD")
//        }

        
        
//        let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "DrawingViewController") as! DrawingViewController
//        present(nextViewController, animated: true, completion: nil)

        
//        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
//        let nextViewController  = storyBoard.instantiateViewController(withIdentifier: "DrawingViewController") as! DrawingViewController
//        self.present(nextViewController, animated: true, completion: nil)
    }
    
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
