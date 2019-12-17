//
//  ViewController.swift
//  FootprintApp
//
//  Created by 神戸悟 on 2019/12/14.
//  Copyright © 2019 SatoruKambe. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController,UITableViewDataSource, UITableViewDelegate {
    // 7. SecondViewに渡す文字列
    var selectedText: String?

    // テーブルに表示するテキスト
    let texts = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]

    //Cellの行数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return texts.count
    }
    
    //Cellのテキスト追加
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: "Cell")

        cell.textLabel?.text = texts[indexPath.row]
        return cell
    }
    //多分セルを押した時の処理だと思う
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 8. SecondViewControllerに渡す文字列をセット
        selectedText = texts[indexPath.row]

        // 8. SecondViewControllerへ遷移するSegueを呼び出す
        performSegue(withIdentifier: "showShowFootprintViewController", sender: nil)
    }
    // Segueを呼び出された時、遷移時の処理
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "showShowFootprintViewController") {
            let secondVC: ShowFootprintViewController = segue.destination as! ShowFootprintViewController

            // 11. SecondViewControllerのtextに選択した文字列を設定する
            secondVC.text = selectedText
        }
    }
    
    //AppDelegateのインスタンスを取得
    let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
    
    @IBOutlet weak var statusLabel: UILabel!
    
    @IBOutlet weak var footprintTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        footprintTableView.delegate = self
        footprintTableView.dataSource = self
    }
    
}

