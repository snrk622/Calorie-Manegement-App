//
//  GoalCalorieViewController.swift
//  calorieManegeApp
//
//  Created by 篠原立樹 on 2018/11/03.
//  Copyright © 2018 Ostrich. All rights reserved.
//

import UIKit

class GoalCalorieViewController: UIViewController {
    
    let userDefaults = UserDefaults.standard
    
    var goalCalorie : UInt16 = 2650
    
    @IBOutlet weak var sexSegmentedControl: UISegmentedControl!
    @IBOutlet weak var ageSegmentedControl: UISegmentedControl!
    @IBOutlet weak var activityLevelSegmantedControl: UISegmentedControl!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    

    @IBAction func cancel(_ sender: Any) {
        //このモーダルを閉じる
        self.dismiss(animated: true, completion: nil)
    }
    
    
    //segueが巻き戻るときの処理
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let button = sender as? UIBarButtonItem, button === self.saveButton else {
            return
        }
        
        if sexSegmentedControl.selectedSegmentIndex == 0 {
            if ageSegmentedControl.selectedSegmentIndex == 0 {
                if activityLevelSegmantedControl.selectedSegmentIndex == 0 {
                    goalCalorie = 2250
                } else if activityLevelSegmantedControl.selectedSegmentIndex == 1 {
                    goalCalorie = 2650
                } else if activityLevelSegmantedControl.selectedSegmentIndex == 2 {
                    goalCalorie = 3000
                }
            } else if ageSegmentedControl.selectedSegmentIndex == 1 {
                if activityLevelSegmantedControl.selectedSegmentIndex == 0 {
                    goalCalorie = 2300
                } else if activityLevelSegmantedControl.selectedSegmentIndex == 1 {
                    goalCalorie = 2650
                } else if activityLevelSegmantedControl.selectedSegmentIndex == 2 {
                    goalCalorie = 3050
                }
            } else if ageSegmentedControl.selectedSegmentIndex == 2 {
                if activityLevelSegmantedControl.selectedSegmentIndex == 0 {
                    goalCalorie = 2100
                } else if activityLevelSegmantedControl.selectedSegmentIndex == 1 {
                    goalCalorie = 2450
                } else if activityLevelSegmantedControl.selectedSegmentIndex == 2 {
                    goalCalorie = 2800
                }
            } else if ageSegmentedControl.selectedSegmentIndex == 3 {
                if activityLevelSegmantedControl.selectedSegmentIndex == 0 {
                    goalCalorie = 1850
                } else if activityLevelSegmantedControl.selectedSegmentIndex == 1 {
                    goalCalorie = 2200
                } else if activityLevelSegmantedControl.selectedSegmentIndex == 2 {
                    goalCalorie = 2500
                }
            }
        } else if sexSegmentedControl.selectedSegmentIndex == 1{
            if ageSegmentedControl.selectedSegmentIndex == 0 {
                if activityLevelSegmantedControl.selectedSegmentIndex == 0 {
                    goalCalorie = 1700
                } else if activityLevelSegmantedControl.selectedSegmentIndex == 1 {
                    goalCalorie = 1950
                } else if activityLevelSegmantedControl.selectedSegmentIndex == 2 {
                    goalCalorie = 2250
                }
            } else if ageSegmentedControl.selectedSegmentIndex == 1 {
                if activityLevelSegmantedControl.selectedSegmentIndex == 0 {
                    goalCalorie = 1750
                } else if activityLevelSegmantedControl.selectedSegmentIndex == 1 {
                    goalCalorie = 2000
                } else if activityLevelSegmantedControl.selectedSegmentIndex == 2 {
                    goalCalorie = 2300
                }
            } else if ageSegmentedControl.selectedSegmentIndex == 2 {
                if activityLevelSegmantedControl.selectedSegmentIndex == 0 {
                    goalCalorie = 1650
                } else if activityLevelSegmantedControl.selectedSegmentIndex == 1 {
                    goalCalorie = 1950
                } else if activityLevelSegmantedControl.selectedSegmentIndex == 2 {
                    goalCalorie = 2200
                }
            } else if ageSegmentedControl.selectedSegmentIndex == 3 {
                if activityLevelSegmantedControl.selectedSegmentIndex == 0 {
                    goalCalorie = 1450
                } else if activityLevelSegmantedControl.selectedSegmentIndex == 1 {
                    goalCalorie = 1700
                } else if activityLevelSegmantedControl.selectedSegmentIndex == 2 {
                    goalCalorie = 2000
                }
            }
            
        }
        
        userDefaults.set(goalCalorie, forKey: "goal_value")
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
