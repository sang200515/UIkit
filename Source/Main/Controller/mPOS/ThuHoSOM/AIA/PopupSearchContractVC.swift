//
//  PopupListCityVC.swift
//  QuickCode
//
//  Created by Sang Trương on 17/10/2022.
//

import UIKit

class PopupSearchContractVC: UIViewController{

	var onSelectPin:((SuggestionsModel) -> Void)?
	var listSuggestion:[SuggestionsModel] = []
    @IBOutlet weak var tableView :UITableViewAutoHeight!
    @IBOutlet weak var cancelButton :UIButton!

    @IBOutlet weak var blurView: UIView!
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!

    override func viewDidLoad() {
        super.viewDidLoad()
        blurView.alpha = 0.5
        setupUI()
		self.tableView.backgroundView = nil
		let gesture2 = UITapGestureRecognizer(target: self, action: #selector(cancelButtonPressed))
		blurView.isUserInteractionEnabled = true
		
		blurView.addGestureRecognizer(gesture2)

    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

    }

    private func setupUI(){
        tableView.dataSource = self
        tableView.delegate = self
        tableView.registerTableCell(PopupSearchContractCell.self)
        self.tableView.reloadData()
    }



    @IBAction func cancelButtonPressed(_ sender: Any) {
        self.dismiss(animated: true)
    }

}

extension PopupSearchContractVC:UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listSuggestion.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueTableCell(PopupSearchContractCell.self)
		cell.bindCell(item:listSuggestion[indexPath.row],Stt:indexPath.row)
        cell.selectionStyle = .none
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

		if let select = onSelectPin {
			self.dismiss(animated: true)
			select(listSuggestion[indexPath.row])
		}
    }
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
	{
		return UITableView.automaticDimension
	}

}

extension UIViewController {

    func setRootViewController(to viewController: UIViewController) {
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.isNavigationBarHidden = true
        UIApplication.shared.windows.first?.rootViewController = navigationController
    }

//    func push(viewController: UIViewController) {
//        navigationController?.pushViewController(viewController, animated: true)
//    }

    func pop() {
        navigationController?.popViewController(animated: true)
    }
}
