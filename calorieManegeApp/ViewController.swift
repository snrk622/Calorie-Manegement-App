//
//  ViewController.swift
//  calorieManegeApp
//
//  Created by 篠原立樹 on 2018/11/01.
//  Copyright © 2018 Ostrich. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var calorieLabel: UILabel!
    
    //segueを巻き戻したときの処理
    @IBAction func unwindTotop(sender: UIStoryboardSegue) {
        guard let sourceVC = sender.source as? CalorieViewController, let getCalorie = sourceVC.getCalorie else {
            return
        }
        
        self.calorieLabel.text = getCalorie
    }
    
    //userDfaultsのインスタンスを取得
    let userDefaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
}

