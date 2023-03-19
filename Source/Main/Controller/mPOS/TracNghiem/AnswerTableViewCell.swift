//
//  AnswerTableViewCell.swift
//  MutipleChoiceTest
//
//  Created by Ngoc Bao on 11/08/2021.
//

import UIKit

class AnswerTableViewCell: UITableViewCell {
    
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var contenLbl: UILabel!
    @IBOutlet weak var explainLbl: UILabel!
    @IBOutlet weak var boundView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        boundView.layer.cornerRadius = 10
    }
    
    func bindCell(object: QuestionAnswerItem,isShowResult: Bool) {
        boundView.backgroundColor = .white
        icon.image = object.isSelected ? UIImage(named: "selected_radio_ic") : UIImage(named: "unselected_radio_ic")
        contenLbl.text = object.QuestionAnswerContent
        if isShowResult {
            boundView.alpha = 0.75
            if object.isSelected && object.IsAnswer {
                boundView.backgroundColor = UIColor(red: 164, green: 231, blue: 204)
            } else {
                if object.isSelected && !object.IsAnswer {
                    boundView.backgroundColor = UIColor(red: 232, green: 127, blue: 140)
                } else if !object.isSelected && object.IsAnswer {
                    boundView.backgroundColor = UIColor(red: 164, green: 231, blue: 204)
                }
            }
            if object.IsAnswer {
                explainLbl.isHidden = false
                explainLbl.text = "\(object.Explain)"
            } else {
                explainLbl.isHidden = true
            }
        } else {
            explainLbl.isHidden = true
            boundView.backgroundColor = .white
            boundView.alpha = 1
        }
    }
    
}
