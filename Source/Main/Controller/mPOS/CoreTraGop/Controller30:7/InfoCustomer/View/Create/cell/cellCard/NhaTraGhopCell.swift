    //
    //  NhaTraGhopCell.swift
    //  QuickCode
    //
    //  Created by Sang Trương on 25/07/2022.
    //

import UIKit

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

            // Configure the view for the selected state
    }
    func bindCell(imageString:String,tenNhaTraGop:String,history:String,item:InsHouses) {
        contentView.backgroundColor = .clear
        viewMain.layer.cornerRadius = 20
        viewMain.layer.masksToBounds = true
        imageNhaTraGop.image = UIImage(named: imageString )
        tenNhaTraGopLbl.text = item.name ?? ""
        lichSuTraGopLbl.text = item.message ?? ""
        lichSuTraGopLbl.textColor = UIColor(hexString: item.messageColor ?? "")

    }
}

