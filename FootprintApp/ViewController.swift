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

    //MARK:画面パーツ関係
    
    @IBOutlet weak var footprintTableView: UITableView!
    
    @IBAction func statusButton(_ sender: Any) {
        //performSegue(withIdentifier: "showAddFootprintViewController", sender: nil)
        if let addFootprintViewController = addFootprintViewController {
            present(addFootprintViewController, animated: true, completion: nil)
        }
    }
    
    @IBOutlet weak var statusButton: UIButton!
    
    
    
    
    //画面遷移先のインスタンスを保持
    var addFootprintViewController:AddFootprintViewController?
    
    //画面初期処理
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        if let dataController = appDelegate.dataController {
            let footprintsfetch = dataController.fetchFootprints()
            for footprint in footprintsfetch{
                self.footprints.append(footprint)
            }
        }
        addFootprintViewController = storyboard?.instantiateViewController(withIdentifier: "showAddFootprintViewController") as? AddFootprintViewController
        if let addFootprintViewController = self.addFootprintViewController{
            addFootprintViewController.viewController = self
        }
    }
    
    // MARK: Table View関係
    
    //TableViewのいろいろ
    var footprints: Array<Footprints> = []
    //表示数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return footprints.count
    }
    //表示内容
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // セルを取得する
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "SampleCell", for: indexPath)
        
        // セルに表示する値を設定する
        cell.textLabel!.text = footprints[indexPath.row].title
        
        return cell
    }
    
    var selectedfootprint:Footprints?
    //セルを押した時の処理
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 8. SecondViewControllerに渡す文字列をセット
        selectedfootprint = footprints[indexPath.row]

        // 8. SecondViewControllerへ遷移するSegueを呼び出す
        performSegue(withIdentifier: "showShowFootprintViewController", sender: nil)
    }
    
    //Segueによる画面遷移
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "showShowFootprintViewController") {
            let secondVC: ShowFootprintViewController = segue.destination as! ShowFootprintViewController

            // 11. SecondViewControllerのtextに選択した文字列を設定する
            secondVC.selectedfootprint = selectedfootprint
        }else if(segue.identifier == "showAddFootprintViewController"){
            //let secondVC: ConfirmationViewController = segue.destination as! ConfirmationViewController
        }
    }
}

