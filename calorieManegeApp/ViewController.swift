//
//  ViewController.swift
//  calorieManegeApp
//
//  Created by 篠原立樹 on 2018/11/01.
//  Copyright © 2018 Ostrich. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //userDfaultsのインスタンスを取得
    let userDefaults = UserDefaults.standard
    var sum: UInt16 = 0
    
    @IBOutlet weak var calorieLabel: UILabel!
    
    //segueを巻き戻したときの処理
    @IBAction func unwindTotop(sender: UIStoryboardSegue) {
        guard let sourceVC = sender.source as? CalorieViewController, let getCalorie = sourceVC.getCalorie else {
            return
        }
        //userDefaultsをsumに読み込み
        sum = UInt16(userDefaults.integer(forKey: "calorie_value"))
        //sumにgetcalorieを足す
        sum = sum + getCalorie
        //userDefaultsに新しいsumを保存
        userDefaults.set(sum, forKey: "calorie_value")
        //calorieLabelにuserDefaultsを表示
        calorieLabel.text = userDefaults.string(forKey: "calorie_value")
        
    }
    
    @IBAction func resetButtonAction(_ sender: Any) {
        //sumをリセット
        sum = 0
        //userDefaultsに新しいsumを保存
        userDefaults.set(sum, forKey: "calorie_value")
        //calorieLabelにuserDefaultsを表示
        calorieLabel.text = userDefaults.string(forKey: "calorie_value")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //calorieLabelにuserDefaultsを表示
        calorieLabel.text = userDefaults.string(forKey: "calorie_value")
        
    }
    
}

