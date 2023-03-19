//
//  DetailInfoPointForCreateStudentCell.swift
//  fptshop
//
//  Created by KhanhNguyen on 8/26/20.
//  Copyright © 2020 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

class DetailInfoPointForCreateStudentCell: BaseTableCell {

    var cellHeight: CGFloat = 0
    
    var lbSBDValue: UILabel!
    override func setupCell() {
        super.setupCell()
        
    }
    
    func setupViews(_ item: StudentBTSInfo) {
        let lbSBD = UILabel(frame: CGRect(x: 8, y: 8, width: 120, height: Common.Size(s:20)))
        lbSBD.text = "Số báo danh: "
        lbSBD.textColor = UIColor.darkGray
        lbSBD.font = UIFont.systemFont(ofSize: 14)
        contentView.addSubview(lbSBD)
        //
        lbSBDValue = UILabel(frame: CGRect(x: lbSBD.frame.origin.x + lbSBD.frame.width, y: lbSBD.frame.origin.y, width: 200, height: Common.Size(s:20)))
        lbSBDValue.text = "\(item.SoBaoDanh)"
        lbSBDValue.textColor = UIColor.black
        lbSBDValue.font = UIFont.systemFont(ofSize: 14)
        contentView.addSubview(lbSBDValue)
        
        let pointView = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 120))
        contentView.addSubview(pointView)
        pointView.myCustomAnchor(top: lbSBD.bottomAnchor, leading: lbSBD.leadingAnchor, trailing: self.contentView.trailingAnchor, bottom: nil, centerX: nil, centerY: nil, width: nil, height: nil, topConstant: -4, leadingConstant: 0, trailingConstant: 8, bottomConstant: 0, centerXConstant: 0, centerYConstant: 0, widthConstant: 0, heightConstant: 0)
        
        let lbDiemTrungBinh = UILabel(frame: CGRect(x: 0, y: 0, width: 120, height: 20))
        lbDiemTrungBinh.textColor = UIColor.darkGray
        lbDiemTrungBinh.font = UIFont.systemFont(ofSize: 14)
        contentView.addSubview(lbDiemTrungBinh)
        lbDiemTrungBinh.myCustomAnchor(top: pointView.bottomAnchor, leading: pointView.leadingAnchor, trailing: nil, bottom: contentView.bottomAnchor, centerX: nil, centerY: nil, width: nil, height: nil, topConstant: 4, leadingConstant: 0, trailingConstant: 0, bottomConstant: 8, centerXConstant: 0, centerYConstant: 0, widthConstant: 0, heightConstant: 0)
        lbDiemTrungBinh.text = "Điểm trung bình: \(item.DiemTrungBinh)"

        
        //
        var xPoint: CGFloat = 0
        var yPoint: CGFloat = 0
        if item.DiemTungMon.count > 0 {
            for i in 1...(item.DiemTungMon.count) {
                let item = item.DiemTungMon[i - 1]
                
                if i % 2 != 0 {//trai
                    let n:Int = i/2
                    xPoint = Common.Size(s:8)
                    yPoint = Common.Size(s:15) * CGFloat(n + 1)
                    
                } else {
                    xPoint = pointView.frame.width/2 + Common.Size(s:7)
                    yPoint = Common.Size(s:15) * CGFloat(i/2)
                }
                
                let lbSubjectName = UILabel(frame: CGRect(x: xPoint, y: yPoint, width: pointView.frame.width/2 - Common.Size(s:5), height: Common.Size(s:20)))
                lbSubjectName.text = "\(item.TenMH):  \(item.Diem)"
                lbSubjectName.textColor = UIColor.black
                lbSubjectName.font = UIFont.systemFont(ofSize: 13)
                pointView.addSubview(lbSubjectName)
            }
        }
        let pointViewHeight:CGFloat = ((CGFloat((item.DiemTungMon.count)/2) + 1) * Common.Size(s:20)) + Common.Size(s:20)
        //        pointView.frame = CGRect(x: pointView.frame.origin.x, y: pointView.frame.origin.y, width: pointView.frame.width, height: pointViewHeight)
        cellHeight = pointViewHeight + lbSBD.frame.height + lbDiemTrungBinh.frame.height + Common.Size(s: 5)
        
    }
}
