//
//  Constants.swift
//  fptshop
//
//  Created by KhanhNguyen on 7/16/20.
//  Copyright © 2020 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

struct Constants {
    
    struct LocalKey {
        static let myinfo_token_key = "myinfo_token_key"
        static let username_login   = "username_login"
    }
    
    struct COLORS {
        static let main_color_white         = UIColorFromRGB(0xFFFFFF)
        static let black_main               = UIColorFromRGB(0x393939)
        static let bold_green               = UIColorFromRGB(0x219653)
        static let light_green              = UIColorFromRGB(0x6FCF97)
        static let main_red_my_info         = UIColorFromRGB(0xEB5757)
        static let main_blue_my_info        = UIColorFromRGB(0x418DF1)
        static let main_orange_my_info      = UIColorFromRGB(0xF57C00)
        static let main_yellow_my_info      = UIColorFromRGB(0xF2C94C)
        static let text_gray                = UIColorFromRGB(0xA6A6A6)
        static let bg_gray_popup            = UIColorFromRGB(0xD9D9D7)
        static let main_navigationbar       = UIColorFromRGB(0x00579c)
        static let sendo_color              = UIColor(red: 238, green: 38, blue: 37)
        static let createStatus             = UIColor(red: 244, green: 141, blue: 95)
        static let processingStatus         = UIColor(red: 238, green: 38, blue: 37)
        static let doneStatus               = UIColorFromRGB(0x6FCF97)

        
    }
    
    struct TextSizes {
        static let size_8           = CGFloat(8.0)
        static let size_10          = CGFloat(10.0)
        static let size_11          = CGFloat(11.0)
        static let tabbar           = CGFloat(10.0)
        static let size_14          = CGFloat(14.0)
        static let size_13          = CGFloat(13.0)
        static let size_12          = CGFloat(12.0)
        static let size_15          = CGFloat(15.0)
        static let size_16          = CGFloat(16.0)
        static let size_18          = CGFloat(18.0)
        static let size_20          = CGFloat(20.0)
        static let size_22          = CGFloat(22.0)
        static let size_24          = CGFloat(24.0)
        static let size_26          = CGFloat(26.0)
        static let size_30          = CGFloat(30.0)
    }
    
    struct Values {
        static let border_width: CGFloat               = 0.5
        static let button_pay_now                = CGFloat(15.0)
        static let button_corner                 = CGFloat(4.0)
        static let button_round_corner           = CGFloat(20.0)
        static let view_corner                   = CGFloat(8.0)
        static let button_border_width           = CGFloat(1.0)
        static let tabbar_height                 = CGFloat(49.0)
        static let progressHUD_show_time         = Double(25)
        static let date_format                   = "dd - MMM - yyyy"
        static let rating_screen_date_format     = "MMMM dd, yyyy"
        static let booking_date_string_format    = "yyyy-MM-dd"
        static let currency_symbol               = "₫"
        static let max_phonenumber_lenght        = 10
        static let max_pincode_lenght            = 6
        static let max_address_floor_lenght      = 30
        static let max_address_house_no_lenght   = 12
        static let max_address_block_lenght      = 33
        static let max_name_lenght               = 32
        static let min_name_lenght               = 3
        static let date_format_ISO8601           = "yyyy-MM-dd'T'HH:mm:ss"
        static let delivery_info_des_min_lenght  = 4
        static let delivery_info_des_max_lenght  = 40
    }
    
}
