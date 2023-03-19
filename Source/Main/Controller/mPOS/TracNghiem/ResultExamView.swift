//
//  ResultExamView.swift
//  fptshop
//
//  Created by Ngoc Bao on 12/08/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

class ResultExamView: UIView {
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var percentView: UIView!
    @IBOutlet weak var blueWidth: NSLayoutConstraint!
    @IBOutlet weak var employNameLbl: UILabel!
    @IBOutlet weak var employResult: UILabel!
    @IBOutlet weak var percentLabel: UILabel!
    @IBOutlet weak var confirmButton: UIButton!
    @IBOutlet weak var reTestButton: UIButton!
    @IBOutlet weak var showResultButton: UIButton!
    var currentExam: EmployInfoExam!
    var result: ResultExamItem!
    var onConfirm: (()->Void)?
    var onTestAgain: (()->Void)?
    var onCheckResult: (()->Void)?
    //MARK:
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        loadViewFromNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        loadViewFromNib()
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        bindView(current: currentExam, resultExam: result)
    }
    
    func bindView(current:EmployInfoExam,resultExam: ResultExamItem) {
        currentExam = current
        result = resultExam
        employNameLbl.text = "\(Cache.user?.UserName ?? "") - \(Cache.user?.EmployeeName ?? "")"
        employResult.text = "Số câu đúng \(currentExam.correctQues)"
        let percent = (Double(currentExam.correctQues) / Double(currentExam.questionExams.count)) * 100
        percentLabel.text = "\(Int(percent))%"
        showResultButton.isHidden = !result.IsShowResult
        reTestButton.isHidden = !result.IsExamAgain
        blueWidth.constant = CGFloat((percent/100)) * percentView.frame.width
        confirmButton.isHidden = result.IsExamAgain == false ? false : true
    }
    
    //MARK:
    func loadViewFromNib() {
        Bundle.main.loadNibNamed("ResultExamView", owner: self, options: nil)
        self.addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight,.flexibleWidth]
    }
    
    
    @IBAction func checkResult() {
        self.removeFromSuperview()
        if let result = onCheckResult {
            result()
        }
    }
    
    @IBAction func onAgain() {
        self.removeFromSuperview()
        if let again = onTestAgain {
            again()
        }
    }
    
    @IBAction func confirm() {
        self.removeFromSuperview()
        if let ok = onConfirm {
            ok()
        }
    }
    
}
