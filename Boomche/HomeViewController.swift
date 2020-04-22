//
//  ViewController.swift
//  KhatKhati
//
//  Created by Sara Babaei on 3/19/20.
//  Copyright © 2020 Sara Babaei. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var joinGameButton: CustomButton!
    @IBOutlet weak var createLobbyButton: CustomButton!
    
    
    @IBAction func createLobbyAction(_ sender: Any) {
        SocketIOManager.sharedInstance.creatLobby()
        createLobbyButton.layer.masksToBounds = true //to showing button selected
    }
    
    //MARK: Socket Management
    //It would be more clear if it was implemented in SocketIOManager class
    func addSocketHandler() {
        SocketIOManager.sharedInstance.socket?.on("get_generate_key") { data, ack in
            print("^^^^^RECEIVING ROOM_ID^^^^^^")
            
            let temp = data[0] as! [String : Any]
            GameConstants.roomID = (temp["key"] as! String)
            SocketIOManager.sharedInstance.joinGame()
            
            self.showNextPage("NewLobbyViewController")
        }
    }
    
    func showNextPage(_ identifier: String){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: identifier) as UIViewController
        controller.modalPresentationStyle = .fullScreen
        controller.modalTransitionStyle = .coverVertical
        present(controller, animated: true, completion: nil)
    }
    
    //MARK: UI Handling
    func setJoinGameButtonAttributes(){
        joinGameButton.setCornerRadius(radius: 30.5)
        joinGameButton.setShadowColor(color: Colors.yellow.componentColor!)
        joinGameButton.setBackgroundColor(color: Colors.yellow.componentColor!)
    }
    
    func setCreateLobbyButtonAttributes(){
        createLobbyButton.setCornerRadius(radius: 30.5)
        createLobbyButton.setShadowColor(color: Colors.blue.componentColor!)
        createLobbyButton.setBackgroundColor(color: Colors.blue.componentColor!)
    }
    
    func configure(){
        setJoinGameButtonAttributes()
        setCreateLobbyButtonAttributes()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        SocketIOManager.sharedInstance.establishConnection()
        
        configure()
        
        addSocketHandler()
    }
}
