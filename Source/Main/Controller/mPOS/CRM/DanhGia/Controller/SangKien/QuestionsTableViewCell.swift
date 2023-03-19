//
//  QuestionsTableViewCell.swift
//  KhuiSealiPhone14
//
//  Created by Trần Văn Dũng on 26/10/2022.
//
import ActionSheetPicker_3_0
import UIKit
//import RxSwift
//import RxCocoa

protocol QuestionsTableViewCellDelegate:AnyObject {
    func reload(index:Int)
}

class QuestionsTableViewCell : UITableViewCell {
    
    weak var delegate:QuestionsTableViewCellDelegate?
    
    var row:Int = 0
	var isHistory:Bool = false
    var model:QuestionModel? {
        didSet {
            self.bind()
        }
    }
    
    let titleLable:UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        label.numberOfLines = 0
        label.textColor = .darkGray
        return label
    }()
    
    let noteLable:UILabel = {
        let label = UILabel()
        label.isHidden = true
        label.font = .systemFont(ofSize: 13)
        label.text = "(Có thể điền nhiều email người cần hợp tác, cách nhau bằng dấu phẩy)"
        label.numberOfLines = 0
        label.textColor = .red
        return label
    }()
    
    let parentStackView:UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.backgroundColor = .clear
        stackView.spacing = 0
        stackView.alignment = .fill
        return stackView
    }()
    
    let stackView:UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.backgroundColor = .clear
        stackView.spacing = 0
        stackView.alignment = .fill
        return stackView
    }()
    
    let textView:UITextView = {
        let textView = UITextView()
        textView.backgroundColor = .white
        textView.returnKeyType = .default
        textView.layer.borderColor = UIColor.lightGray.cgColor
        textView.layer.borderWidth = 0.5
        textView.layer.cornerRadius = 5
        textView.isHidden = true
        return textView
    }()
    
    let textField:UITextField = {
        let textField = UITextField()
        textField.placeholder = "dd/MM/yyyy"
        textField.borderStyle = .roundedRect
        textField.isHidden = true
        return textField
    }()

	private var placeholderLabel: UILabel!


    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .clear
        self.contentView.addSubview(self.parentStackView)
        self.parentStackView.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().offset(10)
            make.trailing.bottom.equalToSuperview().offset(-10)
        }
        
        self.textView.snp.makeConstraints { make in
            make.height.equalTo(100)
        }
        
        self.textField.snp.makeConstraints { make in
            make.height.equalTo(40)
        }
        self.textField.delegate = self

    }
	private func createPlaceholderForTextView() {

		textView.delegate = self
		placeholderLabel = UILabel()
		placeholderLabel.text = "Nhập lý do"
		placeholderLabel.font = UIFont.systemFont(ofSize: 13)
		placeholderLabel.sizeToFit()
		textView.addSubview(placeholderLabel)
		placeholderLabel.frame.origin = CGPoint(x: 8, y: 6)
		placeholderLabel.textColor = UIColor.gray
		placeholderLabel.isHidden = !textView.text.isEmpty
	}
	private func bindDetailHistory(){

	}
	private func bind(){
		if isHistory {
			self.textView.isUserInteractionEnabled = false
			self.textField.isUserInteractionEnabled = false
			self.parentStackView.isUserInteractionEnabled = false

		}else {
			if textView.text == "" {
				self.createPlaceholderForTextView()
			}
		}
        self.parentStackView.removeFullyAllArrangedSubviews()
        self.parentStackView.addArrangedSubview(self.titleLable)
        self.parentStackView.addArrangedSubview(self.stackView)
        self.parentStackView.addArrangedSubview(self.textView)
        self.parentStackView.addArrangedSubview(self.textField)
        self.parentStackView.addArrangedSubview(self.noteLable)
        
        self.textView.delegate = self
        self.textField.delegate = self
        let attrs1 = [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 15, weight: .semibold), NSAttributedString.Key.foregroundColor : UIColor.darkGray]
        
        let attrs2 = [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 15, weight: .semibold), NSAttributedString.Key.foregroundColor : UIColor.red]
        
        let attributedString1 = NSMutableAttributedString(string:self.model?.question ?? "", attributes:attrs1)
        
        let attributedString2 = NSMutableAttributedString(string:"(*)", attributes:attrs2)
        
        attributedString1.append(attributedString2)
        self.titleLable.attributedText = attributedString1
		self.textView.text = self.model?.answersTextView
        if self.model?.type == 0 {
            self.stackView.removeFullyAllArrangedSubviews()
            self.configButton()
        }
        
        if self.model?.type == 1 {
            self.textView.isHidden = false
			self.textField.isHidden = true
        }
        
        if self.model?.type == 2 {
            self.textField.isHidden = false
			self.textView.isHidden = true
			if isHistory {
				textField.text = self.model?.answersTextView ?? ""
			}
        }
        
        if self.model?.type == 3 {
            self.stackView.removeFullyAllArrangedSubviews()
            self.configButton()
            self.noteLable.isHidden = false
        }
		let gesture = UITapGestureRecognizer(target: self, action: #selector(handleDatePickerPressed))
		textField.addGestureRecognizer(gesture)
		textField.isUserInteractionEnabled = true

    }
	@objc private func handleDatePickerPressed(){
		let datePicker = ActionSheetDatePicker(
			title: "Chọn ngày", datePickerMode: UIDatePicker.Mode.date, selectedDate: Date(),
			doneBlock: {
				picker, value, index in
				let dateFormatter = DateFormatter()
				dateFormatter.dateFormat = "dd/MM/yyyy"
				let strDate = dateFormatter.string(from: value as! Date)
				self.textField.text = "\(strDate)"
				let dateSelected  = Common.convertDateToStringWith(dateString: self.textField.text ?? "", formatIn: "dd/MM/yyyy", formatOut: "yyyy-MM-dd")
				self.model?.answersTextView = dateSelected

				return
			}, cancel: { ActionStringCancelBlock in return }, origin: self.contentView)
		datePicker?.locale = NSLocale(localeIdentifier: "vi_VN") as Locale
		datePicker?.show()
	}
    private func configButton(){
        let answers = self.model?.answers ?? []
        for i in 0..<(answers.count) {
            let button = QuestionsButton()
            button.titleLabel.text = answers[i].answer
            button.checkBox.isChecked = answers[i].isChoose
            button.tag = i
            let tap = MyTapGesture(target: self, action: #selector(self.selectedAnswer(_:)))
            tap.index = i
			if isHistory == false {
				button.addGestureRecognizer(tap)
			}
            self.stackView.addArrangedSubview(button)
            button.snp.makeConstraints { make in
                make.height.greaterThanOrEqualTo(30)
            }
            if self.model?.answers[i].answer == "Mục khác" && self.model?.answers[i].isChoose == true  {
                self.textView.isHidden = false
            }else {
                self.textView.isHidden = true
				self.textField.isHidden = true
            }
        }
    }
    
    @objc private func selectedAnswer(_ sender:MyTapGesture){
        self.endEditing(true)
        let i = sender.index
        self.model?.answers.forEach({ item in
            item.isChoose = false
        })
        self.model?.answers[i].isChoose = true
        self.delegate?.reload(index:self.row)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.noteLable.isHidden = true
        self.parentStackView.removeFullyAllArrangedSubviews()
        self.stackView.removeFullyAllArrangedSubviews()
		self.placeholderLabel.isHidden = true
		self.placeholderLabel.textColor = .white
    }
    
}

extension QuestionsTableViewCell : UITextFieldDelegate, UITextViewDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.endEditing(true)
        return true
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        self.model?.answersTextView = textField.text ?? ""
    }
    
    func textViewDidChangeSelection(_ textView: UITextView) {
		self.placeholderLabel.isHidden = true
		self.placeholderLabel.textColor = .white
        self.model?.answersTextView = textView.text ?? ""
    }

	func textViewDidChange(_ textView: UITextView) {
		self.placeholderLabel.isHidden = true
		self.placeholderLabel.textColor = .white
	}
	 func textViewShouldBeginEditing(_ textView:UITextView) -> Bool{
//		 self.placeholderLabel.removeFromSuperview()
		 self.placeholderLabel.isHidden = true
		 self.placeholderLabel.textColor = .white
		 return true
	}
	
}


class MyTapGesture: UITapGestureRecognizer {
    var index:Int = 0
}
