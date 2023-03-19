//
//  SelectPointBaoKimViewController.swift
//  fptshop
//
//  Created by Doan Minh Hoang on 23/11/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

class SelectPointBaoKimViewController: UIViewController {

    @IBOutlet weak var tbvPickup: UITableView!
    @IBOutlet weak var cstPickup: NSLayoutConstraint!
    @IBOutlet weak var tbvDropoff: UITableView!
    @IBOutlet weak var cstDropoff: NSLayoutConstraint!
    
    var pickupPoints: [BaoKimDropOffPointsatArrive] = []
    var dropoffPoints: [BaoKimDropOffPointsatArrive] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupTableView()
    }
    
    private func setupUI() {
        title = "Chọn điểm đón / điểm trả"
        addBackButton()
        
        if BaoKimDataManager.shared.selectedPickup.id == 0 {
            BaoKimDataManager.shared.selectedPickup = pickupPoints.first ?? BaoKimDropOffPointsatArrive(JSON: [:])!
        }
        if BaoKimDataManager.shared.selectedDropoff.id == 0 {
            BaoKimDataManager.shared.selectedDropoff = dropoffPoints.first ?? BaoKimDropOffPointsatArrive(JSON: [:])!
        }
    }
    
    private func setupTableView() {
        tbvPickup.registerTableCell(BaoKimPointCell.self)
        tbvDropoff.registerTableCell(BaoKimPointCell.self)
        tbvPickup.rowHeight = 70
        tbvDropoff.rowHeight = 70
        
        cstPickup.constant = CGFloat(pickupPoints.count * 70)
        cstDropoff.constant = CGFloat(dropoffPoints.count * 70)
    }
    
    @IBAction func continueButtonPressed(_ sender: Any) {
        let vc = ReviewBookingBaoKimViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension SelectPointBaoKimViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == tbvPickup {
            return pickupPoints.count
        } else {
            return dropoffPoints.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueTableCell(BaoKimPointCell.self)
        cell.selectionStyle = .none
        if tableView == tbvPickup {
            cell.setupCell(point: pickupPoints[indexPath.row], isSelected: BaoKimDataManager.shared.selectedPickup.id == pickupPoints[indexPath.row].id)
        } else {
            cell.setupCell(point: dropoffPoints[indexPath.row], isSelected: BaoKimDataManager.shared.selectedDropoff.id == dropoffPoints[indexPath.row].id)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == tbvPickup {
            BaoKimDataManager.shared.selectedPickup = pickupPoints[indexPath.row]
        } else {
            BaoKimDataManager.shared.selectedDropoff = dropoffPoints[indexPath.row]
        }
        tableView.reloadData()
    }
}
