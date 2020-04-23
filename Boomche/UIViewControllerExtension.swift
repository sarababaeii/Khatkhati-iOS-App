//
//  UIViewControllerExtension.swift
//  Boomche
//
//  Created by Sara Babaei on 4/23/20.
//  Copyright © 2020 Sara Babaei. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    func showNextPage(identifier: String) {
        if identifier == "LoadingViewController" {
            LoadingViewController.parentStoryboardID = self.restorationIdentifier
        }
        
        let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: identifier) as UIViewController

        controller.modalPresentationStyle = .fullScreen
        controller.modalTransitionStyle = .coverVertical

        self.present(controller, animated: true, completion: nil)
    }
}
