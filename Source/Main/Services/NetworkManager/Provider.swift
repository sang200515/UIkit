//
//  Provider.swift
//  fptshop
//
//  Created by Doan Minh Hoang on 12/04/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation

class Provider {
    static let shared = Provider()
    private let request: NetworkRequestProtocol = NetworkRequest()

    private var networkManager: APINetworkProtocol {
        return APINetwork(request: request)
    }

    var thuHoFtelAPIService: ThuHoFtelAPIService {
        return ThuHoFtelAPIService(network: networkManager)
    }
    
    var vietjetAPIService: VietjetAPIService {
        return VietjetAPIService(network: networkManager)
    }
    
    var replacementAccessoriesAPIService: ReplacementAccessoriesAPIService {
        return ReplacementAccessoriesAPIService(network: networkManager)
    }
    
    var thuhoSOMAPIService: ThuHoSOMAPIService {
        return ThuHoSOMAPIService(network: networkManager)
    }
    
    var thecaoSOMAPIService: TheCaoSOMAPIService {
        return TheCaoSOMAPIService(network: networkManager)
    }
    
    var hangHotApiService: HangHotApiService {
        return HangHotApiService(network: networkManager)
    }
    
    var payMentApiSevice: PaymentApiServices {
        return PaymentApiServices(network: networkManager)
    }

    var laprapPCAPService: LapRapPCSevice {
        return LapRapPCSevice(network: networkManager)
    }
    
    var raPCAPService: RaPCSevice {
        return RaPCSevice(network: networkManager)
    }
    
    var baoHanhMSMService: BaoHanhApiservice {
        return BaoHanhApiservice(network: networkManager)
    }
    
    var thaySimItelAPIService: ThaySimItelApiService {
        return ThaySimItelApiService(network: networkManager)
    }
    
    var ecomOrders: EcomOrdersService {
        return EcomOrdersService(network: networkManager)
    }
    
    var baokimAPIService: BaoKimAPIService {
        return BaoKimAPIService(network: networkManager)
    }
    
    var cmsnAPIService: CMSNAPIService {
        return CMSNAPIService(network: networkManager)
    }
    
    var giaDungApiService: GiaDungAPIService {
        return GiaDungAPIService(network: networkManager)
    }
    
    var shinhan: ShinhanService {
        return ShinhanService(network: networkManager)
    }
        
    var listSmApiService: CheckListSMApiService {
        return CheckListSMApiService(network: networkManager)
    }

    var checkInOutService: CheckInOutAPIService {
        return CheckInOutAPIService(network: networkManager)
    }

    var coreInstallmentService: CoreInstallMentAPIService {
        return CoreInstallMentAPIService(network: networkManager)
    }

    var createCustomerAPIService: CreateCustomerAPIService {
        return CreateCustomerAPIService(network: networkManager)
    }
    
    var ebayService: EbayAPIService {
        return EbayAPIService(network: networkManager)
    }
	
    var getOTPShinhanAPIService: ShinHanOTPService {
        return ShinHanOTPService(network: networkManager)
    }

	var eveluateAPIService: DanhGiaService {
		return DanhGiaService(network: networkManager)
	}

	var callTuVanSanPhamService: CallTuVanSanPhamService {
		return CallTuVanSanPhamService(network: networkManager)
	}
		var bookSimVinaphone: BookSimVinaphoneService {
			return BookSimVinaphoneService(network: networkManager)
	}
}
