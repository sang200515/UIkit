	//
	//  BaseRXViewController.swift
	//  QuickCode
	//
	//  Created by Sang Trương on 26/12/2022.
	//

import RxCocoa
import RxSwift

class BaseRXViewController: UIViewController {
	let bag = DisposeBag()
	override func viewDidLoad() {
		super.viewDidLoad()
		setupUI()
	}
	func setupUI() {

	}


}
