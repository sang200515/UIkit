//
//  SelectTripBaoKimViewController.swift
//  fptshop
//
//  Created by Doan Minh Hoang on 17/11/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

class SelectTripBaoKimViewController: UIViewController {

    @IBOutlet weak var btnLastDay: UIButton!
    @IBOutlet weak var btnNextDay: UIButton!
    @IBOutlet weak var clvDate: UICollectionView!
    @IBOutlet weak var lbNumber: UILabel!
    @IBOutlet weak var tbvTrip: UITableView!
    @IBOutlet weak var svFilter: UIStackView!
    @IBOutlet weak var btnTime: UIButton!
    @IBOutlet weak var btnVIP: UIButton!
    @IBOutlet weak var btnCompanies: UIButton!
    @IBOutlet weak var btnSpace1: UIButton!
    @IBOutlet weak var btnSpace2: UIButton!
    @IBOutlet weak var svSeatType: UIStackView!
    @IBOutlet weak var btnSeat1: UIButton!
    @IBOutlet weak var btnSeat2: UIButton!
    @IBOutlet weak var btnSeat3: UIButton!
    @IBOutlet weak var btnSeatSpace1: UIButton!
    @IBOutlet weak var btnSeatSpace2: UIButton!
    
    var selectedDate: Date = Date()
    var trip: BaoKimTrip = BaoKimTrip(JSON: [:])!
    var filter: BaoKimFilter = BaoKimFilter(JSON: [:])!
    private var dates: [Date] = []
    private var selectedDateIndex: Int = 0
    private var totalItems: Int = 0
    private var currentPage: Int = 1
    private var isLoadMore: Bool = false
    private var isLoadMoreNeeded: Bool = true
    private var is0012: Bool = false
    private var is1219: Bool = false
    private var is1924: Bool = false
    private var isVIP: Bool = false
    private var isSeat1: Bool = false
    private var isSeat2: Bool = false
    private var isSeat3: Bool = false
    private var selectedColor: String = "42935D"
    private var selectedCompanies: [BaoKimFilterCompaniesData] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupCollectionView()
        setupTableView()
    }
    
    private func setupUI() {
        title = "Thông tin chuyến xe"
        addBackButton()
        
        totalItems = trip.total
        lbNumber.text = "\(totalItems)"
        setupFilterStackView()
    }
    
    private func setupFilterStackView() {
        if is0012 || is1219 || is1924 || isVIP || selectedCompanies.count > 0 {
            svFilter.isHidden = false
        } else {
            svFilter.isHidden = true
        }
        
        if isSeat1 || isSeat2 || isSeat3 {
            svSeatType.isHidden = false
        } else {
            svSeatType.isHidden = true
        }
        if (self.isSeat1 && self.isSeat2 && self.isSeat3) || (!self.isSeat1 && !self.isSeat2 && !self.isSeat3) {
            svSeatType.isHidden = true
        }
        
        if self.is0012 {
            btnTime.setTitle("0 giờ-12 giờ", for: .normal)
            btnTime.backgroundColor = UIColor(hexString: selectedColor)
            btnTime.setTitleColor(.white, for: .normal)
            btnTime.isHidden = false
            btnSpace1.isHidden = true
        } else if self.is1219 {
            btnTime.setTitle("12 giờ-19 giờ", for: .normal)
            btnTime.backgroundColor = UIColor(hexString: selectedColor)
            btnTime.setTitleColor(.white, for: .normal)
            btnTime.isHidden = false
            btnSpace1.isHidden = true
        } else if self.is1924 {
            btnTime.setTitle("19 giờ-24 giờ", for: .normal)
            btnTime.backgroundColor = UIColor(hexString: selectedColor)
            btnTime.setTitleColor(.white, for: .normal)
            btnTime.isHidden = false
            btnSpace1.isHidden = true
        } else {
            btnTime.isHidden = true
            btnSpace1.isHidden = false
        }
        if self.isVIP {
            btnVIP.setTitle("Xe ghế VIP", for: .normal)
            btnVIP.backgroundColor = UIColor(hexString: selectedColor)
            btnVIP.setTitleColor(.white, for: .normal)
            btnVIP.isHidden = false
            btnSpace2.isHidden = true
        } else {
            btnVIP.isHidden = true
            btnSpace2.isHidden = false
        }
        if self.selectedCompanies.count > 0 {
            btnCompanies.setTitle("\(selectedCompanies.count) nhà xe", for: .normal)
            btnCompanies.backgroundColor = UIColor(hexString: selectedColor)
            btnCompanies.setTitleColor(.white, for: .normal)
            btnCompanies.isHidden = false
        } else {
            btnCompanies.isHidden = true
            btnSpace1.isHidden = false
            btnSpace2.isHidden = true
        }
        if self.isSeat1 {
            if self.isSeat2 {
                btnSeat1.isHidden = false
                btnSeat2.isHidden = false
                btnSeat3.isHidden = true
                btnSeatSpace1.isHidden = false
                btnSeatSpace2.isHidden = true
            } else if self.isSeat3 {
                btnSeat1.isHidden = false
                btnSeat2.isHidden = true
                btnSeat3.isHidden = false
                btnSeatSpace1.isHidden = false
                btnSeatSpace2.isHidden = true
            } else {
                btnSeat1.isHidden = false
                btnSeat2.isHidden = true
                btnSeat3.isHidden = true
                btnSeatSpace1.isHidden = false
                btnSeatSpace2.isHidden = false
            }
        } else {
            if self.isSeat2 {
                if self.isSeat3 {
                    btnSeat1.isHidden = true
                    btnSeat2.isHidden = false
                    btnSeat3.isHidden = false
                    btnSeatSpace1.isHidden = false
                    btnSeatSpace2.isHidden = true
                } else {
                    btnSeat1.isHidden = true
                    btnSeat2.isHidden = false
                    btnSeat3.isHidden = true
                    btnSeatSpace1.isHidden = false
                    btnSeatSpace2.isHidden = false
                }
            } else {
                if self.isSeat3 {
                    btnSeat1.isHidden = true
                    btnSeat2.isHidden = true
                    btnSeat3.isHidden = false
                    btnSeatSpace1.isHidden = false
                    btnSeatSpace2.isHidden = false
                }
            }
        }
    }
    
    private func setupCollectionView() {
        clvDate.registerCollectionCell(VietjetDateCollectionViewCell.self)
        makeDateList()
    }
    
    private func setupTableView() {
        tbvTrip.registerTableCell(BaoKimTripCell.self)
        tbvTrip.prefetchDataSource = self
        tbvTrip.estimatedRowHeight = 100
        tbvTrip.rowHeight = UITableView.automaticDimension
    }
    
    private func loadData() {
        BaoKimDataManager.shared.searchTripParam.page = currentPage
        
        ProgressView.shared.show()
        Provider.shared.baokimAPIService.getTrips(param: BaoKimDataManager.shared.searchTripParam, success: { [weak self] result in
            ProgressView.shared.hide()
            guard let self = self, let data = result else { return }
            if self.isLoadMore {
                if self.trip.data.count == 0 { self.isLoadMoreNeeded = false }
                self.trip.data.append(contentsOf: data.data)
                self.isLoadMore = false
                self.tbvTrip.reloadRows(at: self.calculateIndexPathsToReload(from: data.data), with: .automatic)
            } else {
                self.trip.data = data.data
                if self.trip.data.count > 0 {
                    self.totalItems = data.total
                    self.lbNumber.text = "\(self.totalItems)"
                } else {
                    self.totalItems = 0
                    self.lbNumber.text = "\(self.totalItems)"
                }
                self.tbvTrip.reloadData()
            }
        }, failure: { [weak self] error in
            ProgressView.shared.hide()
            guard let self = self else { return }
            self.showAlertOneButton(title: "Thông báo", with: error.description, titleButton: "OK")
        })
    }
    
    private func reloadFilter() {
        BaoKimDataManager.shared.searchTripParam.companies = ""
        selectedCompanies = []
        
        ProgressView.shared.show()
        Provider.shared.baokimAPIService.getFilters(from: BaoKimDataManager.shared.searchTripParam.from, to: BaoKimDataManager.shared.searchTripParam.to, date: BaoKimDataManager.shared.searchTripParam.date, success: { [weak self] result in
            ProgressView.shared.hide()
            guard let self = self, let data = result else { return }
            self.filter = data
            BaoKimDataManager.shared.companies = data.data.companies.data
        }, failure: { [weak self] error in
            ProgressView.shared.hide()
            guard let self = self else { return }
            self.showAlertOneButton(title: "Thông báo", with: error.description, titleButton: "OK")
        })
    }
    
    private func makeDateList() {
        let firstCal = Calendar.current
        let beforeCal = Calendar.current
        let afterCal = Calendar.current
        let calToday = Calendar.current

        let currentFirstDate = firstCal.startOfDay(for: selectedDate)
        var beforeFirstDate = beforeCal.startOfDay(for: selectedDate)
        var afterFirstDate = afterCal.startOfDay(for: selectedDate)
        let today = calToday.startOfDay(for: Date())
        
        var days: [Date] = []
        
        for _ in 1...7 {
            beforeFirstDate = beforeCal.date(byAdding: .day, value: -1, to: beforeFirstDate)!
            if beforeFirstDate < today {
                break
            }
            
            days.append(beforeFirstDate)
        }
        
        days.reverse()
        days.append(currentFirstDate)
        selectedDateIndex = days.count - 1
        
        for _ in 1...7 {
            afterFirstDate = afterCal.date(byAdding: .day, value: 1, to: afterFirstDate)!
            days.append(afterFirstDate)
        }
        
        dates = days
        clvDate.reloadData()
        clvDate.performBatchUpdates(nil, completion: { result in
            self.clvDate.selectItem(at: IndexPath(row: self.selectedDateIndex, section: 0), animated: true, scrollPosition: .centeredHorizontally)
        })
        setupDateButton()
    }
    
    private func setupDateButton() {
        if selectedDateIndex == 0 {
            btnLastDay.isHidden = true
        } else {
            btnLastDay.isHidden = false
        }
        
        if selectedDateIndex == dates.count - 1 {
            btnNextDay.isHidden = true
        } else {
            btnNextDay.isHidden = false
        }
    }
    
    @IBAction func lastDayButtonPressed(_ sender: Any) {
        if selectedDateIndex - 1 >= 0 {
            selectedDateIndex -= 1
        }
        
        selectedDate = dates[selectedDateIndex]
        clvDate.selectItem(at: IndexPath(row: selectedDateIndex, section: 0), animated: true, scrollPosition: .centeredHorizontally)
        setupDateButton()
        
        isLoadMore = false
        currentPage = 1
        BaoKimDataManager.shared.searchTripParam.date = selectedDate.stringWith(format: "yyyy-MM-dd")
        loadData()
        reloadFilter()
    }
    
    @IBAction func nextDayButtonPressed(_ sender: Any) {
        if selectedDateIndex + 1 < dates.count {
            selectedDateIndex += 1
        }
        
        selectedDate = dates[selectedDateIndex]
        clvDate.selectItem(at: IndexPath(row: selectedDateIndex, section: 0), animated: true, scrollPosition: .centeredHorizontally)
        setupDateButton()
        
        isLoadMore = false
        currentPage = 1
        BaoKimDataManager.shared.searchTripParam.date = selectedDate.stringWith(format: "yyyy-MM-dd")
        loadData()
        reloadFilter()
    }
    
    @IBAction func filterButtonPressed(_ sender: Any) {
        let vc = FilterTripBaoKimViewController()
        vc.seletedCompanies = selectedCompanies
        vc.is0012 = is0012
        vc.is1219 = is1219
        vc.is1924 = is1924
        vc.isVIP = isVIP
        vc.isSeat1 = isSeat1
        vc.isSeat2 = isSeat2
        vc.isSeat3 = isSeat3
        vc.didApplyFilter = { is0012, is1219, is1924, isVIP, isSeat1, isSeat2, isSeat3, companies in
            self.selectedCompanies = companies
            self.is0012 = is0012
            self.is1219 = is1219
            self.is1924 = is1924
            self.isVIP = isVIP
            self.isSeat1 = isSeat1
            self.isSeat2 = isSeat2
            self.isSeat3 = isSeat3
            
            self.isLoadMore = false
            self.currentPage = 1
            if self.is0012 {
                BaoKimDataManager.shared.searchTripParam.timeMin = "00:00"
                BaoKimDataManager.shared.searchTripParam.timeMax = "11:59"
            } else if self.is1219 {
                BaoKimDataManager.shared.searchTripParam.timeMin = "12:00"
                BaoKimDataManager.shared.searchTripParam.timeMax = "18:59"
            } else if self.is1924 {
                BaoKimDataManager.shared.searchTripParam.timeMin = "19:00"
                BaoKimDataManager.shared.searchTripParam.timeMax = "23:59"
            } else {
                BaoKimDataManager.shared.searchTripParam.timeMin = "00:00"
                BaoKimDataManager.shared.searchTripParam.timeMax = "23:59"
            }
            if self.isVIP {
                BaoKimDataManager.shared.searchTripParam.limousine = 1
            } else {
                BaoKimDataManager.shared.searchTripParam.limousine = 0
            }
            if (self.isSeat1 && self.isSeat2 && self.isSeat3) || (!self.isSeat1 && !self.isSeat2 && !self.isSeat3) {
                BaoKimDataManager.shared.searchTripParam.seatType = "1,2,7"
            } else {
                if self.isSeat1 {
                    if self.isSeat2 {
                        BaoKimDataManager.shared.searchTripParam.seatType = "1,2"
                    } else if self.isSeat3 {
                        BaoKimDataManager.shared.searchTripParam.seatType = "1,7"
                    } else {
                        BaoKimDataManager.shared.searchTripParam.seatType = "1"
                    }
                } else {
                    if self.isSeat2 {
                        if self.isSeat3 {
                            BaoKimDataManager.shared.searchTripParam.seatType = "2,7"
                        } else {
                            BaoKimDataManager.shared.searchTripParam.seatType = "2"
                        }
                    } else {
                        if self.isSeat3 {
                            BaoKimDataManager.shared.searchTripParam.seatType = "7"
                        }
                    }
                }
            }
            var companyString = ""
            for company in self.selectedCompanies {
                companyString += "\(company.id)" + ","
            }
            companyString = companyString.dropLast
            BaoKimDataManager.shared.searchTripParam.companies = companyString
            
            self.setupFilterStackView()
            self.loadData()
        }
        
        vc.modalTransitionStyle = .coverVertical
        vc.modalPresentationStyle = .overCurrentContext
        present(vc, animated: true, completion: nil)
    }
}

extension SelectTripBaoKimViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dates.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueCollectionCell(VietjetDateCollectionViewCell.self, indexPath: indexPath)
        cell.setupCell(dates[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedDateIndex = indexPath.row
        selectedDate = dates[indexPath.row]
        clvDate.selectItem(at: indexPath, animated: true, scrollPosition: .centeredHorizontally)
        setupDateButton()
        
        isLoadMore = false
        currentPage = 1
        BaoKimDataManager.shared.searchTripParam.date = selectedDate.stringWith(format: "yyyy-MM-dd")
        loadData()
        reloadFilter()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (UIScreen.main.bounds.width - 100) / 3
        return CGSize(width: width, height: 70)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

extension SelectTripBaoKimViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return totalItems
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueTableCell(BaoKimTripCell.self)
        cell.selectionStyle = .none
        if !isLoadingCell(for: indexPath) {
            if trip.data[indexPath.row].route.schedules.first?.config.lowercased() == "ONLINE".lowercased() {
                cell.setupCell(trip: trip.data[indexPath.row])
                return cell
            } else {
                return UITableViewCell()
            }
        }
        return UITableViewCell()
    }
    
    private func calculateIndexPathsToReload(from newDatas: [BaoKimTripData]) -> [IndexPath] {
        let startIndex = trip.data.count - newDatas.count
        let endIndex = startIndex + newDatas.count
        return (startIndex..<endIndex).map { IndexPath(row: $0, section: 0) }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if trip.data[indexPath.row].route.schedules.first?.config.lowercased() == "ONLINE".lowercased() {
            Provider.shared.baokimAPIService.getSeats(tripCode: trip.data[indexPath.row].route.schedules.first?.tripCode ?? "", success: { [weak self] result in
                guard let self = self, let data = result else { return }
                BaoKimDataManager.shared.resetData()
                BaoKimDataManager.shared.selectedTrip = self.trip.data[indexPath.row]
                let vc = SelectSeatBaoKimViewController()
                vc.seat = data
                self.navigationController?.pushViewController(vc, animated: true)
            }, failure: { [weak self] error in
                guard let self = self else { return }
                self.showAlertOneButton(title: "Thông báo", with: error.description, titleButton: "OK")
            })
        }
    }
}

extension SelectTripBaoKimViewController: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        if indexPaths.contains(where: isLoadingCell) {
            if trip.data.count < totalItems && !isLoadMore && isLoadMoreNeeded {
                currentPage += 1
                isLoadMore = true
                loadData()
            }
        }
    }

    func isLoadingCell(for indexPath: IndexPath) -> Bool {
        return indexPath.row >= trip.data.count
    }
}
