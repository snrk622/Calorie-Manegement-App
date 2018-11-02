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
    
    //resetButtonが押されたら実行
    @IBAction func resetButtonAction(_ sender: Any) {
        
        // ① UIAlertControllerクラスのインスタンスを生成
        // タイトル, メッセージ, Alertのスタイルを指定する
        // 第3引数のpreferredStyleでアラートの表示スタイルを指定する
        let alert: UIAlertController = UIAlertController(title: "今日のカロリーをリセットします", message: "本当によろしいですか？", preferredStyle:  UIAlertController.Style.actionSheet)
        
        // ② Actionの設定
        // Action初期化時にタイトル, スタイル, 押された時に実行されるハンドラを指定する
        // 第3引数のUIAlertActionStyleでボタンのスタイルを指定する
        // OKボタン
        let defaultAction: UIAlertAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler:{
            // ボタンが押された時の処理を書く（クロージャ実装）
            (action: UIAlertAction!) -> Void in
            //sumをリセット
            self.sum = 0
            //userDefaultsに新しいsumを保存
            self.userDefaults.set(self.sum, forKey: "calorie_value")
            //calorieLabelにuserDefaultsを表示
            self.calorieLabel.text = self.userDefaults.string(forKey: "calorie_value")
        })
        
        // キャンセルボタン
        let cancelAction: UIAlertAction = UIAlertAction(title: "キャンセル", style: UIAlertAction.Style.cancel, handler:{
            // ボタンが押された時の処理を書く（クロージャ実装）
            (action: UIAlertAction!) -> Void in
            return
        })
        
        // ③ UIAlertControllerにActionを追加
        alert.addAction(cancelAction)
        alert.addAction(defaultAction)
        
        // ④ Alertを表示
        present(alert, animated: true, completion: nil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //calorieLabelにuserDefaultsを表示
        calorieLabel.text = userDefaults.string(forKey: "calorie_value")
        
    }
    
}

