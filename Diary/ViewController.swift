//
//  ViewController.swift
//  Diary
//
//  Created by 副山俊輔 on 2021/08/26.
//

import UIKit
import CoreData

struct Diarycontent {
    let diary: String
    let day: Int
    let date: String
    let year: String
}


class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // reference to managed object context
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    // Data for the table
    var items:[DiaryItem]?
    
    // 行を追加した時の通知に必要
    @IBOutlet weak var tableView: UITableView!
    
    // インスタンスを生成
    let addView = AddViewController()
    var diaryContent = [[Diarycontent]]()
    var sections = [Date]()
    
    // 編集画面(EditViewController)に値を渡すための変数
    var diaryContentText = ""
    var diaryContentDay = ""
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.dataSource = self
        tableView.delegate = self
        // 値がないセルを非表示
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = UIColor(hex: "eaf8fe")
        // CoreDataからデータを取得
        fetchDiaryItem()
        
        
    }
    
    func fetchDiaryItem() {
        
        // CoreDataからデータをfetchしてtableviewに表示
        do{
            self.items = try context.fetch(DiaryItem.fetchRequest())
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        catch {
            
        }
        
    }
    
    // section数を指定
    func numberOfSections(in tableView: UITableView) -> Int {
        sections.count
    }
    // sectionに表示する形式を指定
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return DateUtils.stringFromDate(date: sections[section], format: "yyyy年M月")
    }
    
    // セルの高さを指定するメソッド
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.estimatedRowHeight
    }
    
    // セルの個数を指定するデリゲートメソッド
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return diaryContent[section].count
    }
    
    // セルに値を設定するデータソースメソッド
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // セルを取得する(cellIDの取得）
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        
        // セルに表示する値を設定する
        let textLabel = cell.contentView.viewWithTag(1) as! UILabel
        textLabel.text = diaryContent[indexPath.section][indexPath.row].diary
        let dayLabel = cell.contentView.viewWithTag(2) as! UILabel
        dayLabel.text = String(diaryContent[indexPath.section][indexPath.row].day)
        let dateLabel = cell.contentView.viewWithTag(3) as! UILabel
        dateLabel.text = diaryContent[indexPath.section][indexPath.row].date
        if dateLabel.text == "土曜日" {
            dayLabel.textColor = .blue
            dateLabel.textColor = .blue
        }
        else if dateLabel.text == "日曜日" {
            dayLabel.textColor = .red
            dateLabel.textColor = .red
        } else {
            dayLabel.textColor = .black
            dateLabel.textColor = .black
        }
        return cell
    }
    
    // 保存ボタンが押された時の処理
    @IBAction func returnToMe(segue:UIStoryboardSegue){
        if segue.identifier == "return"{
            
            let addItemVC = segue.source as! AddViewController
            
            if addItemVC.textView.text == ""{
                self.contentErrAlert()
            }else{
                
                if !sections.contains(addItemVC.yearmonth){
                    diaryContent.append([])
                    sections.append(addItemVC.yearmonth)
                    
                    let index = sections.indices.sorted{ sections[$0] > sections[$1]}
                    
                    sections = index.map{ sections[$0] }
                    let sectionNumber = sections.firstIndex(of: addItemVC.yearmonth)!
                    diaryContent = index.map{ diaryContent[$0]}
                    diaryContent[sectionNumber].append(Diarycontent(diary: addItemVC.textView.text, day: addItemVC.day, date: addItemVC.date, year: addItemVC.year))
                    
                }else{
                    
                    let sectionNumber = sections.firstIndex(of: addItemVC.yearmonth)!
                    
                    diaryContent[sectionNumber].append(Diarycontent(diary: addItemVC.textView.text, day: addItemVC.day, date: addItemVC.date, year: addItemVC.year))
                    let index = diaryContent[sectionNumber].indices.sorted{diaryContent[sectionNumber][$0].day > diaryContent[sectionNumber][$1].day}
                    for i in 0 ..< diaryContent[sectionNumber].count{
                        print(diaryContent[sectionNumber][i].day)
                    }
                    diaryContent[sectionNumber] = index.map{ diaryContent[sectionNumber][$0]}
                }
                
                
                
                tableView.reloadData()
            }
        }
    }
    
    
    
    
    
    // セルがタップされた時の処理
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // セルの選択を解除
        tableView.deselectRow(at: indexPath, animated: true)
        print("\(indexPath.row)番目の行が選択されました")
        // 日記の内容をEditVeiwControllerに渡す変数
        diaryContentText = diaryContent[indexPath.section][indexPath.row].diary
        // 日記の日付をEditVeiwControllerに渡す変数(要修正！！！！今は無理矢理にしてる）
        diaryContentDay = String(diaryContent[indexPath.section][indexPath.row].year)+"年"+String(diaryContent[indexPath.section][indexPath.row].day)+"日 "+diaryContent[indexPath.section][indexPath.row].date
        
        
        
        
        // 画面遷移
        performSegue(withIdentifier: "EditView", sender: self)
    }
    // EditViewControllerに遷移する際の処理
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "EditView" {
            let destination = segue.destination as! EditViewController
            destination.contentText = diaryContentText
            destination.dayLabel = diaryContentDay
        }
    }
    
    // 内容未入力時のエラー処理
    func contentErrAlert() {
        let alert: UIAlertController = UIAlertController(title: "内容を入力してください", message: "", preferredStyle:  UIAlertController.Style.alert)
        present(alert, animated: true, completion: nil)
    }
    
    
    // 日記を削除する処理
    @IBAction func deleteTableViewCell(segue: UIStoryboardSegue) {
        // 日記内容の更新(2022)
        let edit = segue.source as! EditViewController
        diaryContentText = edit.ContentTextView.text
        print(diaryContentText)
        tableView.reloadData()
    }
    
    
}

// データの型を変換するクラス
class DateUtils {
    class func dateFromString(string: String, format: String) -> Date {
        let formatter: DateFormatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .gregorian)
        formatter.dateFormat = format
        return formatter.date(from: string)!
    }
    
    class func stringFromDate(date: Date, format: String) -> String {
        let formatter: DateFormatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .gregorian)
        formatter.dateFormat = format
        return formatter.string(from: date)
    }
}



