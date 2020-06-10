//
//  EndViewController.swift
//  Boomche
//
//  Created by Sara Babaei on 4/19/20.
//  Copyright © 2020 Sara Babaei. All rights reserved.
//

import Foundation
import UIKit

class EndGameViewController: UIViewController {
 
    @IBOutlet weak var scoresTableView: UITableView!
    @IBOutlet weak var homeButton: UIButton!
    @IBOutlet weak var againButton: UIButton!
    
    //MARK: Button Actions
    @IBAction func playAgainAction(_ sender: Any) {
        print("poooooooof0 \(Game.sharedInstance.round.scoreboardTableViewDelegates as Any)")
//        Game.sharedInstance.playAgain()
        SocketIOManager.sharedInstance.requestPlayAgain()
    }
    
    @IBAction func homeAction(_ sender: Any) {
        Game.sharedInstance.gameFinished()
        self.showNextPage(identifier: "HomeViewController")
    }
    
    //MARK: Initializing
    func initializeVariables() {
        Game.sharedInstance.round.scoreboardTableViewDelegates = ScoreboardTableViewDelegates(scoreboardTableView: scoresTableView, isEndGame: true)
        scoresTableView.delegate = Game.sharedInstance.round.scoreboardTableViewDelegates
        scoresTableView.dataSource = Game.sharedInstance.round.scoreboardTableViewDelegates
    }
    
    func configure() {
        initializeVariables()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
     
        configure()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.setGradientSizes()
    }
}
