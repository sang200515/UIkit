//
//  CapNhatChungTuMiraeView.swift
//  MireaKetNoiHeThong
//
//  Created by Trần Văn Dũng on 22/04/2022.
//
import DropDown
import UIKit

class CapNhatChungTuMiraeView : UIView {
 
    var dropDown:DropDown?
    
    lazy var thongTinCongViecButton:HeaderInfo = {
        let button = HeaderInfo()
        button.titleHeader.text = "THÔNG TIN CÔNG VIỆC"
        return button
    }()
    
    lazy var hinhDinhKemButton:HeaderInfo = {
        let button = HeaderInfo()
        button.titleHeader.text = "HÌNH ĐÍNH KÈM"
        return button
    }()
    
    lazy var guiHoSoButton:BaseButton = {
        let button = BaseButton()
        button.setTitle("GỬI HỒ SƠ CHO MIRAE DUYỆT", for: .normal)
        return button
    }()
    
    lazy var scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.contentSize = self.frame.size
        sv.showsHorizontalScrollIndicator = false
        sv.contentInsetAdjustmentBehavior = .never
        sv.keyboardDismissMode = .interactive
        return sv
    }()
    
    let thongTinCongViecView:ThongTinCongViecMiraeView = {
        let view = ThongTinCongViecMiraeView()
        return view
    }()
    let hinhDinhKemView:HinhDinhKemMiraeView = {
        let view = HinhDinhKemMiraeView()
        return view
    }()
    let themHinhHKView:ThemHinhSoHoKhauView = {
        let view = ThemHinhSoHoKhauView()
        view.isHidden = true
        return view
    }()
    
    let viewBottom:UIView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addView()
        self.autoLayout()
    }
    
    private func addView(){
        self.addSubview(self.scrollView)
        self.scrollView.addSubview(self.thongTinCongViecButton)
        self.scrollView.addSubview(self.thongTinCongViecView)
        self.scrollView.addSubview(self.hinhDinhKemButton)
        self.scrollView.addSubview(self.hinhDinhKemView)
        self.scrollView.addSubview(self.themHinhHKView)
        self.scrollView.addSubview(self.guiHoSoButton)
        self.scrollView.addSubview(self.viewBottom)
    }
    
    private func autoLayout(){
        self.scrollView.snp.makeConstraints { (make) in
            make.leading.trailing.bottom.top.equalTo(self.safeAreaLayoutGuide)
        }
        self.thongTinCongViecButton.snp.makeConstraints { make in
            make.height.equalTo(40)
            make.top.equalToSuperview()
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
        }
        self.thongTinCongViecView.snp.makeConstraints { make in
            make.top.equalTo(self.thongTinCongViecButton.snp.bottom)
            make.leading.equalTo(self.thongTinCongViecButton)
            make.trailing.equalTo(self.safeAreaLayoutGuide).offset(-Common.TraGopMirae.Padding.padding)
            make.height.equalTo(446)
        }
        self.hinhDinhKemButton.snp.makeConstraints { make in
            make.height.equalTo(40)
            make.top.equalTo(self.thongTinCongViecView.snp.bottom)
            make.leading.trailing.equalTo(self.thongTinCongViecButton)
        }
        self.hinhDinhKemView.snp.makeConstraints { make in
            make.top.equalTo(self.hinhDinhKemButton.snp.bottom).offset(10)
            make.leading.equalTo(thongTinCongViecView)
            make.trailing.equalTo(thongTinCongViecView)
            make.height.equalTo(668)
        }
        self.themHinhHKView.snp.makeConstraints { make in
            make.top.equalTo(self.hinhDinhKemView.snp.bottom).offset(10)
            make.leading.equalTo(thongTinCongViecView)
            make.trailing.equalTo(thongTinCongViecView)
            make.height.equalTo(0)
        }
        self.guiHoSoButton.snp.makeConstraints { make in
            make.top.equalTo(self.themHinhHKView.snp.bottom).offset(0)
            make.leading.equalTo(hinhDinhKemView)
            make.trailing.equalTo(hinhDinhKemView)
            make.height.equalTo(45)
        }
        self.viewBottom.snp.makeConstraints { make in
            make.top.equalTo(self.guiHoSoButton.snp.bottom).offset(20)
            make.leading.equalTo(safeAreaLayoutGuide).offset(10)
            make.trailing.equalTo(safeAreaLayoutGuide).offset(-10)
            make.height.equalTo(20)
            make.bottom.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
