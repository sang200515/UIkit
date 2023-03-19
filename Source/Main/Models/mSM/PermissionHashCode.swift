//
//  ReportSections.swift
//  fptshop
//
//  Created by Trần Thành Phương Đăng on 29/11/18.
//  Copyright © 2018 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation;

enum PermissionHashCode: Int{
    case BC_VUNG_REALTIME = 1;
    case BC_KHUVUC_REALTIME = 2;
    case BC_SHOP_REALTIME = 3;//BC_G38_REALTIME
    case BC_VUNG_MTD = 4;
    case BC_KHU_VUC_MTD = 5;
    
    case BC_SHOP_MTD = 6;//BC_G38_MTD
    
    case BC_SHOP_THE0_NGHANH_HANG = 7;
    case BC_SALEMAN = 8;
    case BC_TON_KHO_NGHANH_HANG = 9;
    case BC_OVER_DANG_TON_KHO_THANH_LY = 10;
    case BC_OVER_DA_BAN = 11;
    case BC_BAO_HANH_QUA_HAN = 12;
    case BC_NO_KHUYEN_MAI = 13;
    case BC_QUY_TU_TIN = 14;
    case BC_QUY_DUYET_GIAM_GIA = 15;
    
    // We love FPTShop
    case BC_LOI_CAMERA = 16;
    case BC_DIEM_CSKH_WE_LOVE_FPT = 17;
    //F.FRIENDS
    case BC_CAI_DAT_FFRIENDS = 18;
    case BC_TINH_TRANG_CALLLOG_HINH_ANH = 19;
    case BC_TINH_TRANG_CALLLOG_CHUNG_TU = 20;
    case BC_DON_HANG_PENDING_CALLLOG_OUTSIDE = 21;
    case BC_DOANH_SO_DON_HANG_FFRIENDS = 22;
    case BC_TONG_NO_THEO_SHOP = 23;
    case BC_DOANH_NGHIEP_CHUA_MUA_HANG = 24;
    case BC_APR = 25;
    case BC_SUC_KHOE = 27;
    case BC_REAL_TIME_PHU_KIEN = 28;
    case BC_REAL_TIME_PHU_KIEN_VUNG = 29;
    case BC_NGANH_TRA_GOP_VUNG = 30;
    case BC_NGANH_TRA_GOP_KHUVUC = 31;
    case BC_NGANH_TRA_GOP_SHOP = 32;
    
    case BC_CHUA_NOP_TIEN_THU_HO = 100;
    case BC_MAY_XIN_CHUA_BAN = 101;
    case BC_TRAFFIC = 102;
    case BC_TY_LE_TRA_GOP = 103;
//    case NGHANH_HANG_DICH_VU = 104;
    case NHAN_VIEN_VI_PHAM = 111;
    case MO_THE_THEO_VUNG = 112;
    case MO_THE_THEO_KHU_VUC = 113;
    case MO_THE_THEO_SHOP = 114;
    case KT_SSD_ASM = 115;
    case BC_LENDOI_TRAGOP = 116;
    
    case BC_DS_VUNG_VINAMILK = 201;
    case BC_DS_SHOP_VINAMILK = 202;
    
    ////F.Thuoc
    case BC_FPhamarcy104 = 26;
//    case NONE = 0;
    
    case BC_COMBO_PK_VUNG_REALTIME = 118;
    case BC_COMBO_PK_KHUVUC_REALTIME = 119;
    case BC_COMBO_PK_SHOP_REALTIME = 120;
    case BC_COMBO_PK_REALTIME = 117;
    
    case BC_FFRIEND = 104;
    case BC_CALLOG_PENDING = 121;
    case BC_TL_DUYET_TRONG_THANG = 122;
    case BC_TL_DUYET_THEO_TUNG_THANG = 123;
    
    case BC_LIST_DS_REALTIME_SLMAY = 124;
    case BC_LIST_DS_REALTIME_SLMAY_VUNG = 125;
    case BC_LIST_DS_REALTIME_SLMAY_KHUVUC = 126;
    case BC_LIST_DS_REALTIME_SLMAY_SHOP = 127;
    
    case BC_LUY_KE_SLMAY = 128;
    case BC_LUY_KE_SLMAY_VUNG = 129;
    case BC_LUY_KE_SLMAY_KHUVUC = 130;
    case BC_LUY_KE_SLMAY_SHOP = 131;
    
    case BC_THEO_DOI_SO_COC = 132
    case BC_THEO_DOI_SO_COC_VUNG = 133
    case BC_THEO_DOI_SO_COC_KHUVUC = 134
    case BC_THEO_DOI_SO_COC_SHOP = 135
    
    case BC_TRA_GOP = 136
    case BC_TRA_GOP_VUNG = 137
    case BC_TRA_GOP_KHUVUC = 138
    case BC_TRA_GOP_SHOP = 139
    
    case BC_SL_SIM = 140;
    case BC_SL_SIM_VUNG = 141;
    case BC_SL_SIM_KHUVUC = 142;
    case BC_SL_SIM_SHOP = 143;
    
    case BC_TY_LE_SL_SIM = 144
    case BC_TY_LE_SL_SIM_VUNG = 145;
    case BC_TY_LE_SL_SIM_KHUVUC = 146;
    case BC_TY_LE_SL_SIM_SHOP = 147;

    case BC_SL_iphone14 = 232;
    case BC_SL_iphone14_VUNG = 233;
    case BC_SL_iphone14_KHUVUC = 234;
    case BC_SL_iphone14_SHOP = 235;

    case BC_LUYKE_SL_LAIGOP_THUHO = 148
    case BC_LUYKE_SL_LAIGOP_THUHO_VUNG = 149
    case BC_LUYKE_SL_LAIGOP_THUHO_KHUVUC = 150
    case BC_LUYKE_SL_LAIGOP_THUHO_SHOP = 151
    
    case BC_KHAITHAC_KM_CRM = 152
    case BC_KHAITHAC_KM_CRM_VUNG = 153
    case BC_KHAITHAC_KM_CRM_KHUVUC = 154
    case BC_KHAITHAC_KM_CRM_SHOP = 155
    
    case VISITOR_COUNTING_DETAIL = 160
    case VISITOR_THEO_DOI_SHOP = 161
    
    case CHECK_LIST_SHOP_ASM = 162
    case DS_REALTIME_MATKINH = 163
    case DS_REALTIME_MYPHAM = 164
    case DS_REALTIME_DONGHO = 165
    
    case REALTIME_VIRUS = 166
    case REALTIME_VIRUS_VUNG = 167
    case REALTIME_VIRUS_ASM = 168
    case REALTIME_VIRUS_SHOP = 169
    
    case REALTIME_BHMR = 170
    case REALTIME_BHMR_VUNG = 171
    case REALTIME_BHMR_ASM = 172
    case REALTIME_BHMR_SHOP = 173
    
    //----------------
    case LUYKE_VIRUS = 174
    case LUYKE_VIRUS_VUNG = 175
    case LUYKE_VIRUS_ASM = 176
    case LUYKE_VIRUS_SHOP = 177
    
    case LUYKE_BHMR = 178
    case LUYKE_BHMR_VUNG = 179
    case LUYKE_BHMR_ASM = 180
    case LUYKE_BHMR_SHOP = 181
    
    case REALTIME_VEMAYBAY = 182
    case REALTIME_VEMAYBAY_VUNG = 183
    case REALTIME_VEMAYBAY_KHUVUC = 184
    case REALTIME_VEMAYBAY_SHOP = 185
    
    case LUYKE_VEMAYBAY = 186
    case LUYKE_VEMAYBAY_VUNG = 187
    case LUYKE_VEMAYBAY_ASM = 188
    case LUYKE_VEMAYBAY_SHOP = 189
    
    case MYPHAM_SHOP = 190
    case MYPHAM_SALEMAN = 191
    case DS_REALTIME_DONG_HO = 192
    
    case KHAITHAC_MAY_KEM_PK = 193
    case REALTIME_KHAITHAC_MAY_KEM_PK = 194
    
    case TYLE_PHUKIEN_REALTIME = 195
    case TYLE_PHUKIEN_REALTIME_VUNG = 196
    case TYLE_PHUKIEN_REALTIME_KV = 197
    
    case PK_IPHONE_REALTIME = 198
    case PK_IPHONE_REALTIME_VUNG = 199
    case PK_IPHONE_REALTIME_KV = 200
    
    case BC_REALTIME_APPLE_COMBOPK = 203//203
    case BC_APPLE_MODEL = 204//204
    case BC_APPLE_VUNG = 205//205
    case BC_APPLE_KV = 206//206
    case BC_MYPHAM_NEW = 207
    //BC HÀNG HOT
    case BC_REALTIME_HOT = 208
    case BC_LUYKE_HOT = 209
    case BC_REALTIME_HOT_VUNG = 210
    case BC_REALTIME_HOT_KHUVUC = 211
    case BC_REALTIME_HOT_SHOP = 212
    case BC_LUYKE_HOT_VUNG = 213
    case BC_LUYKE_HOT_ASM = 214
    case BC_LUYKE_HOT_SHOP = 215
    //bao
    case BC_BAOHANH_VANG = 216
    case BC_BAOHANH_VANG_VUNG = 217
    case BC_BAOHANH_VANG_KHUVUC = 218
    case BC_BAOHANH_VANG_SHOP = 219
    case BC_BAOHIEM_XE = 220
    case BC_BAOHIEM_XE_VUNG = 221
    case BC_BAOHIEM_XE_KHUVUC = 222
    case BC_BAOHIEM_XE_SHOP = 223
    
    case BC_DAILY_GIA_DUNG = 224
    case BC_REALTIME_GIA_DUNG = 225
    
    case BC_DAILY_GIA_DUNG_VUNG = 226
    case BC_DAILY_GIA_DUNG_KHUVUC = 227
    case BC_DAILY_GIA_DUNG_SHOP = 228
    
    case BC_REALTIME_GIA_DUNG_VUNG = 229
    case BC_REALTIME_GIA_DUNG_KHUVUC = 230
    case BC_REALTIME_GIA_DUNG_SHOP = 231
}
