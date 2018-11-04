//
//  ViewController.swift
//  calorieManegeApp
//
//  Created by 篠原立樹 on 2018/11/01.
//  Copyright © 2018 Ostrich. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate {
    
    //userDfaultsのインスタンスを取得
    let userDefaults = UserDefaults.standard
    var sum: UInt16 = 0
    var progress : Float = 0;
    let dispatchTime = DispatchTime.now() + 10
    
    
    
    @IBOutlet weak var calorieLabel: UILabel!
    @IBOutlet weak var resetButton: UIBarButtonItem!
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var goalButton: UIButton!
    
    
    //CalorieViewControllerlからsegueを巻き戻したときの処理
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
        
        if  sum == 0 {
            self.resetButton.isEnabled = false
        } else {
            self.resetButton.isEnabled = true
        }
        

    }
    
    //GoalCalorieViewControllerからsegueを巻き戻したときの処理
    @IBAction func unwindTotop2(sender: UIStoryboardSegue) {
        
        let goalCalorie = userDefaults.string(forKey: "goal_value")
        self.goalButton.setTitle(goalCalorie, for: .normal)
        
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
            //resetButtonを無効に
            self.resetButton.isEnabled = false
            //残りのカロリーリセット
            self.progress = 1.0
            //バーの色を緑に
            self.progressBar.progressTintColor = UIColor(red: 127/255, green: 255/255, blue: 191/255, alpha: 1)
            //progressBar更新
            self.progressBar.setProgress( self.progress , animated: true)
            self.calorieLabel.textColor = UIColor.black
            

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
        
        //デフォルト値を指定
        userDefaults.register(defaults: ["calorie_value" : 0])
        userDefaults.register(defaults: ["goal_value" : 2250])
        
        //calorieLabelにuserDefaultsを表示
        calorieLabel.text = userDefaults.string(forKey: "calorie_value")
        
        //progressBarの大きさ設定
        progressBar.transform = CGAffineTransform(scaleX: 1.5, y: 10)
        
        //userDefaultsをsumに読み込み
        sum = UInt16(userDefaults.integer(forKey: "calorie_value"))
        
        //resetbuttonの設定
        if sum == 0 {
            self.resetButton.isEnabled = false
        } else {
            self.resetButton.isEnabled = true
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let goalCalorie = userDefaults.integer(forKey: "goal_value")
        
        //残りのカロリー（%）を計算
        progress = 1 - (Float(sum) / Float(goalCalorie))
        let goalCalorieTitle = userDefaults.string(forKey: "goal_value")
        self.goalButton.setTitle(goalCalorieTitle, for: .normal)
        //progressによってバーの色変更
        if progress >= 0.5 {
            progressBar.progressTintColor = UIColor(red: 127/255, green: 255/255, blue: 191/255, alpha: 1)
        } else if progress >= 0.25 {
            progressBar.progressTintColor = UIColor(red: 255/255, green: 191/255, blue: 127/255, alpha: 1)
        } else if progress < 0.25 {
            progressBar.progressTintColor = UIColor(red: 255/255, green: 127/255, blue: 127/255, alpha: 1)
        }
        //文字色を変更する
        if sum >= 2000 {
            calorieLabel.textColor = UIColor(red: 255/255, green: 127/255, blue: 127/255, alpha: 1)
        }
        //progressBar更新
        self.progressBar.setProgress( self.progress , animated: true)
    }
    
}

