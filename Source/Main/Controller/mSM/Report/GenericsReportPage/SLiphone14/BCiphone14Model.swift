//
//  BCiphone14Model.swift
//  fptshop
//
//  Created by Sang Trương on 12/10/2022.
//  Copyright © 2022 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import SwiftyJSON
import UIKit

class SLIPHONE14: Jsonable {

	required init?(
		json: JSON
	) {
        SL_BaoVeToanDien = json["SL_BaoVeToanDien"].stringValue
        SL_IFanApple = json["SL_IFanApple"].stringValue
        SL_combo3monPKNK = json["SL_combo3monPKNK"].stringValue
        SL_combo3monPK = json["SL_combo3monPK"].stringValue
        SL_combo4monPK = json["SL_combo4monPK"].stringValue
        SL_combo4monPKNK = json["SL_combo4monPKNK"].stringValue
        SL_combo5monPK = json["SL_combo5monPK"].stringValue
        SL_combo5monPKNK = json["SL_combo5monPKNK"].stringValue
        SL_may = json["SL_may"].stringValue
        STT = json["STT"].stringValue
        TileCombo = json["TileCombo"].stringValue
        Total_SLcombo = json["Total_SLcombo"].stringValue
        Vung = json["Vung"].stringValue
        flagToken = json["flagToken"].stringValue
        ASM = json["ASM"].stringValue
        KhuVuc = json["KhuVuc"].stringValue
        Shop = json["Shop"].stringValue
        SL_combo2monGD = json["SL_combo2monGD"].stringValue
        SL_combo6mon = json["SL_combo6mon"].stringValue
        SL_combo3monGD = json["SL_combo3monGD"].stringValue
		SLDH_GD_PK_PKNK_DV = json["SLDH_GD_PK_PKNK_DV"].stringValue
		SL_Combo_BH = json["SL_ComboBH"].stringValue
	}

	var SL_BaoVeToanDien: String
	var SL_IFanApple: String
	var SL_combo3monPKNK: String
    var SL_combo3monPK: String
	var SL_combo4monPK: String
	var SL_combo4monPKNK: String
	var SL_combo5monPK: String
	var SL_combo5monPKNK: String
	var SL_may: String
	var STT: String
	var TileCombo: String
	var Total_SLcombo: String
	var Vung: String
	var flagToken: String
    var ASM: String
    var KhuVuc: String
    var Shop: String
    var SL_combo2monGD: String
    var SL_combo6mon: String
    var SL_combo3monGD: String
	var SLDH_GD_PK_PKNK_DV: String
	var SL_Combo_BH: String
}
