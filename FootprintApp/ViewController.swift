//
//  ViewController.swift
//  FootprintApp
//
//  Created by 神戸悟 on 2019/12/14.
//  Copyright © 2019 SatoruKambe. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    //AppDelegateのインスタンスを取得
    let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate

    @IBOutlet weak var footprintTableView: UITableView!
    
    @IBAction func statusButton(_ sender: Any) {
        performSegue(withIdentifier: "showAddFootprintViewController", sender: nil)
    }
    
    @IBOutlet weak var statusButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    var selectedText:String?
    //配列fruitsを設定
    let fruits = ["apple", "orange", "melon", "banana", "pineapple"]
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fruits.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // セルを取得する
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "SampleCell", for: indexPath)
        
        // セルに表示する値を設定する
        cell.textLabel!.text = fruits[indexPath.row]
        
        return cell
    }
    //セルを押した時の処理
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 8. SecondViewControllerに渡す文字列をセット
        selectedText = fruits[indexPath.row]

        // 8. SecondViewControllerへ遷移するSegueを呼び出す
        performSegue(withIdentifier: "showShowFootprintViewController", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "showShowFootprintViewController") {
            let secondVC: ShowFootprintViewController = segue.destination as! ShowFootprintViewController

            // 11. SecondViewControllerのtextに選択した文字列を設定する
            secondVC.text = selectedText
        }else if(segue.identifier == "showAddFootprintViewController"){
            //let secondVC: ConfirmationViewController = segue.destination as! ConfirmationViewController
        }
    }
    //Viewを表示した時に動く
    override func viewDidAppear(_ animated: Bool) {
     //ここに画面遷移処理を記述するときちんと走る。
        print("デバック")
    }


}

