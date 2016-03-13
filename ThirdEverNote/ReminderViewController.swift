//
//  ReminderViewController.swift
//  ThirdEverNote
//
//  Created by makka misako on 2016/02/23.
//  Copyright © 2016年 makka misako. All rights reserved.
//

import UIKit

class ReminderViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var table: UITableView!
    @IBOutlet var reminderTextField: UITextField!
    
    //    let white = UIImage(named: "白丸.png")
    //    let check = UIImage(named: "check.png")
    
    var remindArray = [String]()
    var remindimageArray = [String]()
    
    //userdefaults(倉庫)にアクセス
    let saveData: NSUserDefaults = NSUserDefaults.standardUserDefaults()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //tableviewのdatasourcemesodはviewcontrollerクラスに書く設定
        table.dataSource = self
        
        //UITableViewが持っているDelegatmesodの処理の委託先をViewController.swiftにする
        table.delegate = self
        
        // Do any additional setup after loading the view.
        
        remindArray = ["現国", "数学", "公民", "物理"]
        
        //navigationvar にeditボタンをつける
        navigationItem.leftBarButtonItem = editButtonItem()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //editが押された時の処理
    override func setEditing(editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        table.editing = editing
    }
    
    //cellの数を設定
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return remindArray.count
        //これからReminderArrayを作ったら　ReminderArray.count か　それ+1
    }
    
    //ID付きのcellを取得してそれに付属しているlabelとかimageとか
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        cell.textLabel!.text = remindArray[indexPath.row]
        cell.imageView!.image = UIImage(named: "矢印.png")
        cell.imageView!.frame.size = CGSize(width: 10,height: 10)
        //cell.textLabel!.text = "aaaaaaaaa"
        //cell.imageView!.image = UIImage(named: "白丸  .png")
        return cell
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)  {
        NSLog("%@が選択された", remindArray[indexPath.row])
        
        if table.cellForRowAtIndexPath(indexPath)?.imageView!.image == UIImage(named: "矢印.png"){
            table.cellForRowAtIndexPath(indexPath)?.imageView!.image = UIImage(named:"check.png")
        }
        else{
            table.cellForRowAtIndexPath(indexPath)?.imageView!.image = UIImage(named:"矢印.png")
        }
        
        
        //var cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        /* cell.imageView!.image = UIImage(named: "check.png")
        if cell.selected {
        cell.imageView!.image = UIImage(named: "check.png")
        NSLog("\(cell.highlighted)")
        }
        
        //cell.highlighted = false
        cell.backgroundColor = UIColor.whiteColor()*/
        
    }
    
    //削除可能なcellのindexpath取得(今は全て)
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    //削除された時の実装
    func tableView(table: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        // 先にデータを更新する
        remindArray.removeAtIndex(indexPath.row)
        
        // それからテーブルの更新
        table.deleteRowsAtIndexPaths([NSIndexPath(forRow: indexPath.row, inSection: 0)],
            withRowAnimation: UITableViewRowAnimation.Fade)
    }
    
    //cellの並べ替え
    func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func tableView(table: UITableView, moveRowAtIndexPath sourceIndexPath: NSIndexPath, toIndexPath destinationIndexPath: NSIndexPath) {
        let targetTitle = remindArray[sourceIndexPath.row]
        if let index = remindArray.indexOf(targetTitle) {
            remindArray.removeAtIndex(index)
            remindArray.insert(targetTitle, atIndex: destinationIndexPath.row)
        }
    }
    
    //編集中以外にcellを左スワイプできない
    func tableView(table: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCellEditingStyle {
        if table.editing {
            return UITableViewCellEditingStyle.Delete
        } else {
            return UITableViewCellEditingStyle.None
        }
        
        //編集中にもcellを選択できる
        table.allowsSelectionDuringEditing = true
        table.cellForRowAtIndexPath(indexPath)?.textInputMode
    }
    
    
    
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
    
}
