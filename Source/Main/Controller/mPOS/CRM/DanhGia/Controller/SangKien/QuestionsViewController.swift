//
//  QuestionsViewController.swift
//  KhuiSealiPhone14
//
//  Created by Trần Văn Dũng on 26/10/2022.
//

import SwiftyJSON
import UIKit

//import RxSwift

class QuestionsViewController: BaseViewController {

	private var model: [QuestionModel] = []
	var idHistory: Int = 0
	var type: Int = 0
	var isHistory: Bool = false
	var modelDetailHistory: SangKienModel = SangKienModel(JSON: [:])!
	@IBOutlet weak var tableView: UITableView!
	@IBOutlet weak var saveButton: UIButton!
	override func viewDidLoad() {
		super.viewDidLoad()

		self.tableView.backgroundColor = UIColor.init(hexString: "#F9F9FA")
		self.tableView.register(QuestionsTableViewCell.self, forCellReuseIdentifier: "QuestionsTableViewCell")

		self.initModel(isHistory: false)

		self.tableView.dataSource = self
		self.tableView.delegate = self
		if isHistory{
			loadDetailHistory(id: idHistory, type: type)
		}
		self.saveButton.isHidden = isHistory ? true : false
	}

	func loadDetailHistory(id: Int, type: Int) {
		Provider.shared.eveluateAPIService.loadDetailHistorySangKien(
			id: id, type: type,
			success: { result in
				if result == nil {
					self.showAlertOneButton(
						title: "Thông báo",
						with: "Không load được thông tin chi tiết (App hardcode)!",
						titleButton: "Đồng ý")
				} else {
					self.modelDetailHistory = result ?? SangKienModel(JSON: [:])!
					self.initModel(isHistory: true)
					DispatchQueue.main.async {
						self.tableView.reloadData()

					}
				}
			},
			failure: { [weak self] error in
				guard let self = self else { return }
				self.showAlertOneButton(
					title: "Thông báo", with: error.description, titleButton: "Đồng ý")
			})

	}
	private func initModel(isHistory: Bool) {

		let anw11: AnswerModel = AnswerModel()
		anw11.answer = "Khách hàng"
		let anw12: AnswerModel = AnswerModel()
		anw12.answer = "Nội bộ"
		let anw13: AnswerModel = AnswerModel()
		anw13.answer = "Cả hai"

		let anw41: AnswerModel = AnswerModel()
		anw41.answer = "Có"
		let anw42: AnswerModel = AnswerModel()
		anw42.answer = "Không"

		let anw51: AnswerModel = AnswerModel()
		anw51.answer = "Không quá 30 ngày"
		let anw52: AnswerModel = AnswerModel()
		anw52.answer = "Trên 30 ngày"

		let anw71: AnswerModel = AnswerModel()
		anw71.answer = "Có thể tự làm hoặc với bộ phận của mình"
		let anw72: AnswerModel = AnswerModel()
		anw72.answer = "Mục khác"

		let anw81: AnswerModel = AnswerModel()
		anw81.answer = "Miễn phí hoặc chi phí <= 200K/Tháng"
		let anw82: AnswerModel = AnswerModel()
		anw82.answer = "Cần có chi phí >200K/Tháng"

		let anw91: AnswerModel = AnswerModel()
		anw91.answer = "Chưa triển khai"
		let anw92: AnswerModel = AnswerModel()
		anw92.answer = "Đang thực hiện"
		let anw93: AnswerModel = AnswerModel()
		anw93.answer = "Đã hoàn thành"
		let anw94: AnswerModel = AnswerModel()
		anw94.answer = "Đang trì hoãn"

		let anw101: AnswerModel = AnswerModel()
		anw101.answer = "Tồi tệ"
		let anw102: AnswerModel = AnswerModel()
		anw102.answer = "Không vui"
		let anw103: AnswerModel = AnswerModel()
		anw103.answer = "Bình thường"
		let anw104: AnswerModel = AnswerModel()
		anw104.answer = "Yêu thích"
		let anw105: AnswerModel = AnswerModel()
		anw105.answer = "Ngạc nhiên"
		let anw106: AnswerModel = AnswerModel()
		anw106.answer = "Không thể tin được"

		let md1: QuestionModel = QuestionModel()
		md1.question = "1. Hành động mà bạn muốn cải tiến tạo ra giá trị trực tiếp cho?"
		md1.answers = [anw11, anw12, anw13]
		md1.type = 0
		if isHistory {
			self.fillDataFromHistory(answer: md1.answers, compareString: modelDetailHistory.SangKien1 ?? "")
		}
		let md2: QuestionModel = QuestionModel()
		md2.question = "2. Loại dịch vụ mà bạn muốn cải tiến"
		md2.answers = []
		md2.type = 1
		if isHistory {
			md2.answersTextView = modelDetailHistory.SangKien2 ?? ""
		}
		let md3: QuestionModel = QuestionModel()
		md3.question = "3. Hành động ý tưởng muốn cải tiến là"
		md3.answers = []
		md3.type = 1
		if isHistory {
			md3.answersTextView = modelDetailHistory.SangKien3 ?? ""
		}
		let md4: QuestionModel = QuestionModel()
		md4.question = "4. Ý tưởng có vi phạm quy định công ty không?"
		md4.answers = [anw41, anw42]
		md4.type = 0
		if isHistory {
			self.fillDataFromHistory(answer: md4.answers, compareString: modelDetailHistory.SangKien4 ?? "")
		}
		let md5: QuestionModel = QuestionModel()
		md5.question =
			"5. Bạn cần bao lâu kể từ hôm nay để bắt đầu để thực hiện hành động/ ý tưởng cải tiến này?"
		md5.answers = [anw51, anw52]
		md5.type = 0
		if isHistory {
			self.fillDataFromHistory(answer: md5.answers, compareString: modelDetailHistory.SangKien5 ?? "")
		}
		let md6: QuestionModel = QuestionModel()
		md6.question = "6. Thời gian dự kiến hoàn thành?"
		md6.answers = []
		md6.type = 2
		if isHistory {
			md6.answersTextView = Common.convertDateToStringWith(dateString: modelDetailHistory.SangKien6 ?? "", formatIn: "yyyy-MM-dd", formatOut: "dd/MM/yyyy")
		}
		let md7: QuestionModel = QuestionModel()
		md7.question = "7. Việc cải tiến đó cần phối hợp với (những) ai/bộ phận nào?"
		md7.answers = [anw71, anw72]
		md7.type = 3
		md7.answers[0].isChoose = false
		md7.answers[1].isChoose = false
		if isHistory {
			self.fillDataFromHistory(answer: md7.answers, compareString: modelDetailHistory.SangKien7 ?? "")
			if modelDetailHistory.SangKien7 ?? "" != "Có thể tự làm hoặc với bộ phận của mình"{
				md7.answers[1].isChoose = true
				md7.answersTextView = modelDetailHistory.SangKien7 ?? ""
			}else  {
				md7.answers[0].isChoose = true
			}
		}
		let md8: QuestionModel = QuestionModel()
		md8.question = "8. Bạn cần bao nhiêu ngân sách để triển khai hành động cải tiến này?"
		md8.answers = [anw81, anw82]
		md8.type = 0
		if isHistory {
			self.fillDataFromHistory(answer: md8.answers, compareString: modelDetailHistory.SangKien8 ?? "")
		}
		let md9: QuestionModel = QuestionModel()
		md9.question = "9. Hành động này hiện đã triển khai chưa?"
		md9.answers = [anw91, anw92, anw93, anw94]
		md9.type = 0
		if isHistory {
			self.fillDataFromHistory(answer: md9.answers, compareString: modelDetailHistory.SangKien9 ?? "")
		}
		let md10: QuestionModel = QuestionModel()
		md10.question =
			"10. Nếu hành động này được triển khai, Khách hàng/Đồng nghiệp (Người sử dụng dịch vụ của bạn) sẽ đánh giá dịch vụ ở cấp độ nào?"
		md10.answers = [anw101, anw102, anw103, anw104, anw105, anw106]
		md10.type = 0
		if isHistory {
			self.fillDataFromHistory(
				answer: md10.answers, compareString: modelDetailHistory.SangKien10 ?? "")
		}

		self.model = [md1, md2, md3, md4, md5, md6, md7, md8, md9, md10]

		//		let arrayModelDetailHistory:[String] = modelDetailHistory.toArray
		//		model.forEach { item  in
		//			modelDetailHistory.forEach { itemHistory in
		//				if itemHistory.type == 0 {
		//					itemHistory.answer.forEach { answer in
		//						if answer.answer == item {
		//							answer.isChoose = true
		//							break
		//						}
		//					}
		//				}
		//			}
		//		}
	}
	private func fillDataFromHistory(answer: [AnswerModel], compareString: String) {
		answer.forEach { item in
			if item.answer == compareString {
				item.isChoose = true
			}
		}
	}
	@IBAction func finalTapped(_ sender: Any) {
		var count: Int = 0
		for i in 0..<self.model.count {
			if self.model[i].type == 0 {
				self.model[i].answers.forEach { item in
					if item.isChoose {
						count += 1
					}
				}
			}
			if self.model[i].type == 3 {
				self.model[i].answers.forEach { item in
					if item.answer != "Mục khác" {
						if item.isChoose {
							count += 1
						}
					} else {
						if model[i].answersTextView != "" {
							count += 1
						}
					}
				}
			}
			if model[i].type == 1 {
				if self.model[i].answersTextView != "" {
					count += 1
				}
			}
			if model[i].type == 2 {
				if self.model[i].answersTextView != "" {
					count += 1
				}
			}
		}
		if count != self.model.count {
			self.outPut(message: "Câu trả lời của bạn chưa đủ. Vui lòng kiểm tra lại.")
			return
		}
		self.doneInitiative()
	}
	private func doneInitiative() {
		Provider.shared.eveluateAPIService.doneInitiative(
			param: createParameter(),
			success: { [weak self] result in
				guard let self = self else { return }
				self.showAlertOneButton(
					title: "Thông báo", with: result?.mess ?? "", titleButton: "Đồng ý",
					handleOk: {
						self.navigationController?.popViewController(animated: true)
					})
			},
			failure: { [weak self] error in
				guard let self = self else { return }
				self.showAlert(error.description)
			}

		)
	}
	private func outPut(message: String) {
		self.showAlert(message)
	}

	private func createParameter() -> [String: String] {
		var count: Int = 0
		var dict: [String: String] = [
			"userCode": Cache.user!.UserName,
			"shopCode": Cache.user!.ShopCode,
		]
		for i in 0..<self.model.count {
			count += 1
			if self.model[i].type == 0 {
				self.model[i].answers.forEach { item in
					if item.isChoose {
						dict["sangKien\(count)"] = item.answer
					}
				}
			}
			if self.model[i].type == 3 {
				self.model[i].answers.forEach { item in
					if item.isChoose {
						if item.answer != "Mục khác" {
							dict["sangKien\(count)"] = item.answer
						}
					}
				}
			}
			if self.model[i].answersTextView != "" {
				dict["sangKien\(count)"] = model[i].answersTextView
			}
		}
		return dict
	}
}

extension QuestionsViewController: UITableViewDelegate, UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return self.model.count
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell =
			tableView.dequeueReusableCell(withIdentifier: "QuestionsTableViewCell", for: indexPath)
			as! QuestionsTableViewCell
		cell.model = self.model[indexPath.row]
		cell.delegate = self
		cell.isHistory = self.isHistory
		cell.row = indexPath.row
		cell.selectionStyle = .none
		return cell
	}

	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return UITableView.automaticDimension
	}

	func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
		if isHistory {
			return false
		} else {
			return true
		}
	}
}

extension QuestionsViewController: QuestionsTableViewCellDelegate {
	func reload(index: Int) {
		let indexPath = IndexPath(item: index, section: 0)
		self.tableView.reloadRows(at: [indexPath], with: .automatic)
	}
}
