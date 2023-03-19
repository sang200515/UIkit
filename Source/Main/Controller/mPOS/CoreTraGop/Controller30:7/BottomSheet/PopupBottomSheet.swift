//
//  PopupBottomSheet.swift
//  QuickCode
//
//  Created by Sang Trương on 15/07/2022.
//

import UIKit

class PopupBottomSheet: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    let arrData = ["Phường tân phong1","Phường tân phong","Phường tân phong","Phường tân phong","Phường tân phong","Phường tân phong","Phường tân phong","Phường tân phong","Phường tân phong","Phường tân phong","Phường tân phong","Phường tân phong","Phường tân phong","Phường tân phong","Phường tân phong"]
    var onSelected:((String) -> Void)?
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "PopupCell")
        // Do any additional setup after loading the view.
    }



}
extension PopupBottomSheet:UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrData.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PopupCell")!
        cell.textLabel?.text = arrData[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let select = onSelected {
            select(arrData[indexPath.row])
            self.dismiss(animated: true)
        }
    }
}
