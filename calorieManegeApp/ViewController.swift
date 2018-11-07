//
//  ViewController.swift
//  calorieManegeApp
//
//  Created by 篠原立樹 on 2018/11/01.
//  Copyright © 2018 Ostrich. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return calorieArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell : UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.textColor = UIColor.lightGray
        cell.detailTextLabel?.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        cell.layer.cornerRadius = 10
        cell.layer.masksToBounds = true
        cell.textLabel!.text = timeArray[indexPath.row]
        cell.detailTextLabel!.text = calorieArray[indexPath.row]
        
        

        return cell
    }
    
    
    
    
    
    
    //userDfaultsのインスタンスを取得
    let userDefaults = UserDefaults.standard
    var sum: UInt16 = 0
    var progress : Float = 0;
    let dispatchTime = DispatchTime.now() + 10
    var timeArray = [String]()
    var calorieArray = [String]()
    
    
    @IBOutlet weak var calorieLabel: UILabel!
    @IBOutlet weak var resetButton: UIBarButtonItem!
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var goalButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
//    @IBOutlet weak var cellView: UIView!
//    @IBOutlet weak var titleLabel: UILabel!
//    @IBOutlet weak var detailLabel: UILabel!
    
    
    
    
    //CalorieViewControllerlからsegueを巻き戻したときの処理
    @IBAction func unwindTotop(sender: UIStoryboardSegue) {
        //遷移元の画面を取得するためにCalorieViewControllerで型キャスト。getCalorieにCalorieViewCfontrollerのgetCalorieを代入
        guard let sourceVC = sender.source as? CalorieViewController, let getCalorie = sourceVC.getCalorie else {//汚い
            return
        }
        //遷移元の画面を取得するためにCalorieViewControllerで型キャスト。timeにCalorieViewCfontrollerのtimeを代入
        guard let sourceVC2 = sender.source as? CalorieViewController, let time = sourceVC2.time else {//汚い
            return
        }
        //userDefaultsをsumに読み込み
        sum = UInt16(userDefaults.integer(forKey: "calorie_value"))
        //sumにgetcalorieを足す
        sum = sum + getCalorie
        //userDefaultsに新しいsumを保存
        userDefaults.set(sum, forKey: "calorie_value")
        //textColorを設定
        calorieLabel.textColor = UIColor.white
        //calorieLabelにuserDefaultsを表示
        calorieLabel.text = userDefaults.string(forKey: "calorie_value")
        
        //resetButtonの切り替え
        if  sum == 0 {
            self.resetButton.isEnabled = false
        } else {
            self.resetButton.isEnabled = true
        }
        
        //kcalをつける
        let calorieLog = "\(String(getCalorie))kcal"
        //calorieArrayにcalorieLogを追加
        calorieArray.append(calorieLog)
        //userDefaultsにcalorieArrayを保存
        userDefaults.set(calorieArray, forKey: "calorieArray_value")
        //timeArrayにtimeを追加
        timeArray.append(time)
        //userDefaultsにtimeArrayを保存
        userDefaults.set(timeArray, forKey: "timeArray_value")
        //tableViewを更新
        self.tableView.reloadData()

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
            //textColorを設定
            self.calorieLabel.textColor = UIColor.white
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
            
            //それぞれの配列をリセット
            self.calorieArray = []
            self.timeArray = []
            //それぞれの配列をuserDefaultsに保存
            self.userDefaults.set(self.calorieArray, forKey: "calorieArray_value")
            self.userDefaults.set(self.timeArray, forKey: "timeArray_value")
            //tableViewを更新
            self.tableView.reloadData()

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
        
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        
        //calorieArrayがからじゃなかったら
        if self.userDefaults.object(forKey: "calorieArray_value") != nil {
            self.timeArray = self.userDefaults.stringArray(forKey: "timeArray_value")!
            self.calorieArray = self.userDefaults.stringArray(forKey: "calorieArray_value")!
        }
        
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
            progressBar.progressTintColor = UIColor(red: 255/255, green: 255/255, blue: 127/255, alpha: 1)
        } else if progress < 0.25 {
            progressBar.progressTintColor = UIColor(red: 255/255, green: 127/255, blue: 127/255, alpha: 1)
        }
        //文字色を変更する
        if sum >= goalCalorie {
            calorieLabel.textColor = UIColor(red: 255/255, green: 127/255, blue: 127/255, alpha: 1)
        }
        //progressBar更新
        self.progressBar.setProgress( self.progress , animated: true)
    }
    
    // Override to support editing the table view.
//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//            // Delete the row from the data source
//            self.timeArray.remove(at: indexPath.row)
//            self.calorieArray.remove(at: indexPath.row)
//            userDefaults.set(timeArray, forKey: "time_value")
//            userDefaults.set(calorieArray, forKey: "calorie_value")
//            sum = sum - (UInt16(calorieArray[indexPath.row]) ?? 0)
//            //userDefaultsに新しいsumを保存
//            userDefaults.set(sum, forKey: "calorie_value")
//            //calorieLabelにuserDefaultsを表示
//            calorieLabel.text = userDefaults.string(forKey: "calorie_value")
//            tableView.deleteRows(at: [indexPath], with: .fade)
//        }
//    }
    
}

