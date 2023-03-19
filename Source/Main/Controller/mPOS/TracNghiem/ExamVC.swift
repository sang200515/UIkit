//
//  ExamVC.swift
//  MutipleChoiceTest
//
//  Created by Ngoc Bao on 11/08/2021.
//

import UIKit

class ExamVC: BaseController {

    @IBOutlet weak var tableView: UITableView!
    var examData: EmployInfoExam?
    var resultExam: ResultExamItem!
    
    var isShowResult = false
    var examCode = -1
    
    var timeStart = ""
    var isloading = false
    var stateBottomButtom: ContestState = .complete
    var startStr = ""
    private var countNumber = 0
    private var timer: Timer?
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        loadData()
        getCurrentTime()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        startTimerWith(minute: examData?.dateTimeExam ?? 0)
    }
    
    func getCurrentTime(){
        timeStart = gettimeWith(format: "dd/MM/yyyy HH:mm")
        startStr = gettimeWith(format: "yyyy-MM-dd HH:mm:ss.SSS")
        startStr = startStr.replace(" AM", withString: "")
        startStr = startStr.replace(" PM", withString: "")
        startStr = startStr.replace(" SA", withString: "")
        startStr = startStr.replace(" CH", withString: "")
    }
    
    func gettimeWith(format: String) -> String {
        let currentDateTime = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: currentDateTime)
    }
    
    @objc func updateTimer() {
        print(self.countNumber)
                if self.countNumber != 0 {
                    self.countNumber -= 1  // decrease counter timer
                } else {
                    if let timer = self.timer {
                        timer.invalidate()
                        self.timer = nil
                    }
                }
        DispatchQueue.global(qos: .background).async {
            DispatchQueue.main.async {
                let cell = self.tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? UserExamInforCell
                cell?.timeRemainLbl?.text = self.timeFormatted(self.countNumber)
                cell?.dateLbl.text = self.timeStart
                cell?.timesTestLbl.text = "\(self.examData?.timesExamCurrent ?? "")/\(self.examData?.timesExamMax ?? "")"
            }
        }
        if self.countNumber == 0 {
            self.timer?.invalidate()
            self.timer = nil
            print("Het thoi gian")
            subMitTest()
        }
    }
    func timeFormatted(_ totalSeconds: Int) -> String {
        let seconds: Int = totalSeconds % 60
        let minutes: Int = (totalSeconds / 60) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    func startTimerWith(minute: Int) {
            self.countNumber = minute * 60
            self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.updateTimer), userInfo: nil, repeats: true)
        
    }
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "AnswerTableViewCell", bundle: nil), forCellReuseIdentifier: "AnswerTableViewCell")
        tableView.register(UINib(nibName: "UserExamInforCell", bundle: nil), forCellReuseIdentifier: "UserExamInforCell")
        tableView.register(UINib(nibName: "MultipleChoiceBtnCell", bundle: nil), forCellReuseIdentifier: "MultipleChoiceBtnCell")
        let nib = UINib(nibName: "HeaderLeaseTableView", bundle: nil)
        tableView.register(nib, forHeaderFooterViewReuseIdentifier: "HeaderLeaseTableView")
    }
    
    func scrollToFirstRow() {
        let indexPath = NSIndexPath(row: 0, section: 0)
        self.tableView.scrollToRow(at: indexPath as IndexPath, at: .top, animated: true)
    }
    
    private func loadData() {
        MultipleChoiceApiManager.shared.getDetailExam(ExamCode: self.examCode) { [weak self] detail, error in
            guard let self = self else {return}
            if error != ""{
                self.showPopup(with: error) {
                    self.actionClose()
                }
            } else {
                self.bindUI(item: detail)
            }
        }
    }

    func bindUI(item: EmployInfoExam?) {
        guard let newItem = item else {return}
        examData = newItem
        tableView.reloadData()
    }
    
     func checkAndsumit() {
        if !validateAll() {
            let alert = UIAlertController(title: "Thông báo", message: "Vui lòng chọn mỗi câu hỏi một đáp án.", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
            return
        }
        subMitTest()
    }
    
    private func validateAll() -> Bool{
        for list in examData?.questionExams ?? [] {
            let filter = list.QuestionAnswers.filter({$0.isSelected})
            if filter.count == 0 {
                return false
            }
        }
        return true
    }
    
    func subMitTest() {
        timer?.invalidate()
        timer = nil
        var params = [String: Any]()
        params["ExamCode"] = examCode
        params["Employcode"] = Cache.user?.UserName
        params["BeginDatetime"] = startStr
        
        var endTime = gettimeWith(format:"yyyy-MM-dd HH:mm:ss.SSS")
        endTime = endTime.replace(" AM", withString: "")
        endTime = endTime.replace(" PM", withString: "")
        endTime = endTime.replace(" SA", withString: "")
        endTime = endTime.replace(" CH", withString: "")
        params["EndDatetime"] = endTime
        
        var answerList = [[String:Any]]()
        for list in examData?.questionExams ?? [] {
            let filter = list.QuestionAnswers.filter({$0.isSelected})
            var newItem: [String: Any] = [:]
            newItem["QuestionCode"] = list.QuestionCode
            newItem["QuestionAnswerCode"] = filter.first?.QuestionAnswerCode
            answerList.append(newItem)
        }
        params["ExamOfUser"] = answerList
        self.showLoading()
        isloading = true
        MultipleChoiceApiManager.shared.postResultExam(params: params) {[weak self] result, err in
            self?.isloading = false
            self?.stopLoading()
            self?.isloading = false
            guard let self = self else {return}
            if err != "" {
                self.showPopup(with: err, completion: nil)
            } else {
                let newPopup = ResultExamView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
                guard let data = self.examData , let ketqua = result else {return}
                self.resultExam = ketqua
                newPopup.currentExam = data
                newPopup.result = ketqua
                newPopup.onTestAgain = {
                    self.reloadList()
                    if ketqua.DetailContentExam.isQuestionRandom {
                        self.examData = ketqua.DetailContentExam
                    } else {
                        self.examData?.timesExamCurrent = ketqua.DetailContentExam.timesExamCurrent
                        self.examData?.timesExamMax = ketqua.DetailContentExam.timesExamMax
                    }
                    self.scrollToFirstRow()
                    self.tableView.reloadData()
                }
                newPopup.onConfirm = {
                    self.actionClose()
                }
                
                newPopup.onCheckResult = {
                    if ketqua.IsExamAgain {
                        self.stateBottomButtom = .reTest
                    }
                    if ketqua.IsPass {
                        self.stateBottomButtom = .home
                    }
                    self.isShowResult = !self.isShowResult
                    self.tableView.reloadData()
                }
                self.view.addSubview(newPopup)
            }
        }
        
    }
    
    @objc func actionClose(){
        self.dismiss(animated: false, completion: nil)
        NotificationCenter.default.post(name: NSNotification.Name.init("didCloseSurvey"), object: nil)
    }
    
    func reloadList() {
        for (indexContest,contest) in examData!.questionExams.enumerated() {
            for (index, _) in contest.QuestionAnswers.enumerated() {
                examData?.questionExams[indexContest].QuestionAnswers[index].isSelected = false
            }
        }
        getCurrentTime()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.startTimerWith(minute: self.examData?.dateTimeExam ?? 0)
        }
    }

}

extension ExamVC: UITableViewDelegate,UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return (examData?.questionExams.count ?? 0) + 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else if section == (examData?.questionExams.count ?? 0) + 1 {
            return 1
        } else {
            return examData?.questionExams[section - 1].QuestionAnswers.count ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == (examData?.questionExams.count ?? 0) + 1 {
            return 64
        } else {
            return UITableView.automaticDimension
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section != 0 && section != (examData?.questionExams.count ?? 0) + 1 {
            let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "HeaderLeaseTableView") as! HeaderLeaseTableView
            header.corectLbl.textColor = .black
            header.contentView.backgroundColor = Constants.COLORS.bold_green
            header.backgroundColor = .green
            header.lbName.text = "\(section). \(examData?.questionExams[section - 1].QuestionContent ?? "")"
            header.lbName.textColor  = .white
            header.rightView.isHidden = true
            header.rightView.backgroundColor = .clear
            if isShowResult {
                header.rightView.isHidden = false
                header.corectLbl.backgroundColor = .white
                header.corectLbl.layer.cornerRadius = 5
                if examData?.questionExams[section - 1].isSelectCorrect ?? false {
                    header.corectLbl.text = "Đúng"
                } else {
                    header.corectLbl.textColor = .red
                    header.corectLbl.text = "Sai"
                }
            }
            return header
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section != 0 && section != (examData?.questionExams.count ?? 0) + 1 {
            return UITableView.automaticDimension
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        if section != 0 && section != (examData?.questionExams.count ?? 0) + 1 {
            return 50
        }
        return 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "UserExamInforCell", for: indexPath) as! UserExamInforCell
            guard let exam = examData else {return UITableViewCell()}
            cell.bindCell(item: exam, timeStart: timeStart)
            return cell
        } else if indexPath.section == (examData?.questionExams.count ?? 0) + 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MultipleChoiceBtnCell", for: indexPath) as! MultipleChoiceBtnCell
            cell.bindCell(state: stateBottomButtom)
            cell.onClick = {
                if !self.isloading {
                    if self.stateBottomButtom == .complete {
                        self.checkAndsumit()
                    } else if self.stateBottomButtom == .reTest {
                        self.isShowResult = false
                        self.stateBottomButtom = .complete
                        self.scrollToFirstRow()
                        self.reloadList()
                        if self.examData!.isQuestionRandom {
                            self.examData = self.resultExam.DetailContentExam
                        } else {
                            self.examData?.timesExamCurrent =
                                self.resultExam.DetailContentExam.timesExamCurrent
                            self.examData?.timesExamMax = self.resultExam.DetailContentExam.timesExamMax
                        }
                        tableView.reloadData()
                    } else if self.stateBottomButtom == .home {
                        self.actionClose()
                    }
                }
            }
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "AnswerTableViewCell", for: indexPath) as! AnswerTableViewCell
            guard let item = examData?.questionExams[indexPath.section - 1].QuestionAnswers[indexPath.row] else { return UITableViewCell() }
            cell.bindCell(object: item,isShowResult: isShowResult)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if isShowResult || indexPath.section == 0 || indexPath.section == (examData?.questionExams.count ?? 0) + 1 {return}
        guard let item = examData?.questionExams[indexPath.section - 1].QuestionAnswers else {return}
        for (index,new) in item.enumerated() {
            if new.QuestionAnswerCode != item[indexPath.row].QuestionAnswerCode {
                item[index].isSelected = false
            } else {
                item[index].isSelected = true
            }
        }
        examData?.questionExams[indexPath.section - 1].QuestionAnswers = item
        tableView.reloadData()
    }
}
