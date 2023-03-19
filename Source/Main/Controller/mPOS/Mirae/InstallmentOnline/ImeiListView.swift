//
//  ImeiListView.swift
//  fptshop
//
//  Created by Ngo Bao Ngoc on 01/04/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

class ImeiListView: UIView {

    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var tableVIew: UITableView!
    
    
    var listImei = [String]()
    
    
    var onSelectImei: ((String,Int) -> Void)?
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        if listImei.count <= 0 {
            let label = UILabel()
            label.text = "Không có imei!"
            label.textAlignment = .center
            label.font = UIFont.systemFont(ofSize: 25)
            self.tableVIew.backgroundView = label
        }
    }
    
    func setupView() {
        Bundle.main.loadNibNamed("ImeiListView", owner: self, options: nil)
        self.addSubview(mainView)
        mainView.frame = self.bounds
        mainView.autoresizingMask = [.flexibleHeight,.flexibleWidth]
        tableVIew.delegate = self
        tableVIew.dataSource = self
    }
    
    @IBAction func onClose() {
        self.removeFromSuperview()
    }

}

extension ImeiListView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listImei.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = listImei[indexPath.row]
        cell.textLabel?.numberOfLines = 0
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.removeFromSuperview()
        if let select = onSelectImei {
            select(listImei[indexPath.row], indexPath.row)
        }
    }
}
