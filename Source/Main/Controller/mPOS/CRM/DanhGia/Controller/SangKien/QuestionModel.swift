//
//  QuestionModel.swift
//  KhuiSealiPhone14
//
//  Created by Trần Văn Dũng on 26/10/2022.
//

import Foundation

class QuestionModel {
    var question:String = ""
    var answers:[AnswerModel] = []
    var answersTextView:String = ""
    var type:Int = 0
}

class AnswerModel {
    var answer:String = ""
    var isChoose:Bool = false
}
