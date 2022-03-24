//
//  DiaryTableViewCell.swift
//  Diary
//
//  Created by 副山俊輔 on 2021/09/10.
//

import UIKit

// TableViewCellに表示する内容を設定するクラス
class DiaryTableViewCell: UITableViewCell, UITableViewDelegate {
    
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var dayLabel: UILabel!
    @IBOutlet private weak var contentLabel: UILabel!

    // cellが更新される時に実行
    override func awakeFromNib() {
        super.awakeFromNib()
        // ラベルのテキストを複数行表示
        contentLabel.numberOfLines = 0

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
