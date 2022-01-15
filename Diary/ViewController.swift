//
//  ViewController.swift
//  Diary
//
//  Created by 副山俊輔 on 2021/08/26.
//

import UIKit

struct Diarycontent {
    let diary: String
    let day: Int
    let date: String
}


class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // 行を追加した時の通知に必要
    @IBOutlet weak var tableView: UITableView!
    var addView = addViewController()
    var diaryContent = [[Diarycontent]]()
    
    var sections = [Date]()
    var userDefaults = UserDefaults.standard
    
    
    // 編集画面(EditViewController)に値を渡すための変数
    var diaryContentText = String()
    var diaryContentDay = String()

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // 値がないセルを非表示
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = UIColor(hex: "eaf8fe")
        
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        sections.count
    }
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
            let addItemVC = segue.source as! addViewController
            
            if addItemVC.textView.text == ""{
                self.contentErrAlert()
            }else{
                
                if !sections.contains(addItemVC.yearmonth){
                    diaryContent.append([])
                    sections.append(addItemVC.yearmonth)
                    
                    let index = sections.indices.sorted{ sections[$0] > sections[$1]}
                    
                    sections = index.map{ sections[$0] }
                   
                    print(sections)
                    let sectionNumber = sections.firstIndex(of: addItemVC.yearmonth)!
                    
                    print(sectionNumber)
                    diaryContent = index.map{ diaryContent[$0]}
                    diaryContent[sectionNumber].append(Diarycontent(diary: addItemVC.textView.text, day: addItemVC.day, date: addItemVC.date))
                    
                    
                }else{
                    
                    let sectionNumber = sections.firstIndex(of: addItemVC.yearmonth)!
                 
                    diaryContent[sectionNumber].append(Diarycontent(diary: addItemVC.textView.text, day: addItemVC.day, date: addItemVC.date))
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
        diaryContentText = diaryContent[indexPath.section][indexPath.row].diary
        diaryContentDay = String(diaryContent[indexPath.section][indexPath.row].day)+"日 "+diaryContent[indexPath.section][indexPath.row].date
        
        // 画面遷移
        performSegue(withIdentifier: "EditView", sender: self)
    }
    //遷移する際の処理
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

    }
    
    
    
}


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



