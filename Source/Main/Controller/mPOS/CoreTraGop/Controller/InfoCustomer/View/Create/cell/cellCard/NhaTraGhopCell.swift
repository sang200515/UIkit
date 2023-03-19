    //
    //  NhaTraGhopCell.swift
    //  QuickCode
    //
    //  Created by Sang Trương on 25/07/2022.
    //

import UIKit
import Kingfisher
class NhaTraGhopCell: UITableViewCell {
    var onSelectSuccess: ((String) -> Void)?
    @IBOutlet weak var viewMain: UIView!
    @IBOutlet weak var imageNhaTraGop: UIImageView!
    @IBOutlet weak var tenNhaTraGopLbl: UILabel!
    @IBOutlet weak var lichSuTraGopLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
            // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    func bindCell(item:InsHouses) {
        contentView.backgroundColor = .clear
        viewMain.layer.cornerRadius = 8
        viewMain.layer.masksToBounds = true
        tenNhaTraGopLbl.text = item.name ?? ""
        lichSuTraGopLbl.text = item.message ?? ""
        lichSuTraGopLbl.textColor = UIColor(hexString: item.messageColor ?? "")

        let url = URL(string: "\(item.icon ?? "")")
        imageNhaTraGop.kf.setImage(with: url,
                           placeholder: UIImage(named: ""),
                           options: [.transition(.fade(1))],
                           progressBlock: nil,
                           completionHandler: nil)


    }
}

