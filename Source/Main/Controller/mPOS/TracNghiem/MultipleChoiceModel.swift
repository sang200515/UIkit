//
//  MutipleChoiceObject.swift
//  MutipleChoiceOnline
//
//  Created by Ngoc Bao on 11/08/2021.
//

import Foundation
import SwiftyJSON

class EmployInfoExam: NSObject {
    
    var examCode : Int
    var examName : String
    var dateTimeExam : Int
    var timesExamMax : String
    var timesExamCurrent : String
    var isQuestionRandom : Bool
    var questionExams : [QuestionExams]
    
    init(examCode: Int, examName: String, dateTimeExam: Int, timesExamMax: String, timesExamCurrent: String, isQuestionRandom: Bool, questionExams: [QuestionExams]) {
        self.examCode = examCode
        self.examName = examName
        self.dateTimeExam = dateTimeExam
        self.timesExamMax = timesExamMax
        self.timesExamCurrent = timesExamCurrent
        self.isQuestionRandom = isQuestionRandom
        self.questionExams = questionExams
    }
    var correctQues: Int {
        var count = 0
        for list in questionExams {
            let filter = list.QuestionAnswers.filter({$0.isSelected && $0.IsAnswer})
            if filter.count > 0 {
                count += 1
            }
        }
        return count
    }
    
    class func getObjFromDictionary(map:JSON) -> EmployInfoExam {
        let examCode = map["ExamCode"].intValue
        let examName = map["ExamName"].stringValue
        let dateTimeExam = map["DateTimeExam"].intValue
        let timesExamMax = map["TimesExamMax"].stringValue
        let timesExamCurrent = map["TimesExamCurrent"].stringValue
        let isQuestionRandom = map["IsQuestionRandom"].boolValue
        let questionExams = QuestionExams.parseObjfromArray(array: map["QuestionExams"].arrayValue)
        return EmployInfoExam(examCode: examCode, examName: examName, dateTimeExam: dateTimeExam, timesExamMax: timesExamMax, timesExamCurrent: timesExamCurrent, isQuestionRandom: isQuestionRandom, questionExams: questionExams)
    }
    
    class func parseObjfromArray(array:[JSON])->[EmployInfoExam]{
        var list:[EmployInfoExam] = []
        for item in array {
            list.append(self.getObjFromDictionary(map: item))
        }
        return list
    }
    
}

class QuestionExams {
    
    var QuestionCode: Int
    var QuestionContent: String
    var QuestionAnswers: [QuestionAnswerItem]
    
    init(QuestionCode: Int, QuestionContent: String, QuestionAnswers: [QuestionAnswerItem]) {
        self.QuestionCode = QuestionCode
        self.QuestionContent = QuestionContent
        self.QuestionAnswers = QuestionAnswers
    }
    
    class func getObjFromDictionary(map:JSON) -> QuestionExams {
        let QuestionCode = map["QuestionCode"].intValue
        let QuestionContent = map["QuestionContent"].stringValue
        let QuestionAnswers = QuestionAnswerItem.parseObjfromArray(array: map["QuestionAnswers"].arrayValue)
        return QuestionExams(QuestionCode: QuestionCode, QuestionContent: QuestionContent, QuestionAnswers: QuestionAnswers)
    }
    
    class func parseObjfromArray(array:[JSON])->[QuestionExams]{
        var list:[QuestionExams] = []
        for item in array {
            list.append(self.getObjFromDictionary(map: item))
        }
        return list
    }
    
    var isSelectCorrect: Bool {
        let filter = QuestionAnswers.filter({$0.IsAnswer && $0.isSelected})
        if filter.count > 0 {
            return true
        }
        return false
    }
}

class QuestionAnswerItem: NSObject {
    
    var QuestionAnswerCode: Int
    var QuestionAnswerContent: String
    var IsAnswer: Bool
    var Explain: String
    var isSelected = false
    
    init(QuestionAnswerCode: Int, QuestionAnswerContent: String, IsAnswer: Bool, Explain: String) {
        self.QuestionAnswerCode = QuestionAnswerCode
        self.QuestionAnswerContent = QuestionAnswerContent
        self.IsAnswer = IsAnswer
        self.Explain = Explain
    }
    
    class func getObjFromDictionary(map:JSON) -> QuestionAnswerItem {
        let QuestionAnswerCode = map["QuestionAnswerCode"].intValue
        let QuestionAnswerContent = map["QuestionAnswerContent"].stringValue
        let IsAnswer = map["IsAnswer"].boolValue
        let Explain = map["Explain"].stringValue
        return QuestionAnswerItem(QuestionAnswerCode: QuestionAnswerCode, QuestionAnswerContent: QuestionAnswerContent, IsAnswer: IsAnswer, Explain: Explain)
    }
    
    class func parseObjfromArray(array:[JSON])->[QuestionAnswerItem]{
        var list:[QuestionAnswerItem] = []
        for item in array {
            list.append(self.getObjFromDictionary(map: item))
        }
        return list
    }
}

class ResultExamItem: NSObject {
    var IsPass: Bool
    var IsShowResult: Bool
    var IsExamAgain: Bool
    var DetailContentExam:EmployInfoExam
    
    init(IsPass: Bool, IsShowResult: Bool, IsExamAgain: Bool, DetailContentExam: EmployInfoExam) {
        self.IsPass = IsPass
        self.IsShowResult = IsShowResult
        self.IsExamAgain = IsExamAgain
        self.DetailContentExam = DetailContentExam
    }
    
    class func getObjFromDictionary(data:JSON) -> ResultExamItem {
        let IsPass = data["IsPass"].boolValue
        let IsShowResult = data["IsShowResult"].boolValue
        let IsExamAgain = data["IsExamAgain"].boolValue
        let DetailContentExam = EmployInfoExam.getObjFromDictionary(map: data["DetailContentExam"])
        return ResultExamItem(IsPass: IsPass, IsShowResult: IsShowResult, IsExamAgain: IsExamAgain, DetailContentExam: DetailContentExam)
    }
    
    class func parseObjfromArray(array:[JSON])->[ResultExamItem]{
        var list:[ResultExamItem] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    
}

class InfoExamItem: NSObject {
    var IsExam: Bool
    var ExamCode: Int
    
    init(IsExam: Bool, ExamCode: Int) {
        self.IsExam = IsExam
        self.ExamCode = ExamCode
    }
    
    
    class func getObjFromDictionary(data:JSON) -> InfoExamItem {
        let IsExam = data["IsExam"].boolValue
        let ExamCode = data["ExamCode"].intValue
        return InfoExamItem(IsExam: IsExam, ExamCode: ExamCode)
    }
    
    class func parseObjfromArray(array:[JSON])->[InfoExamItem]{
        var list:[InfoExamItem] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    
}

class BaseErrorExam {
    var error: ErrorContent
    
    init(error: ErrorContent) {
        self.error = error
    }
    
    class func getObjFromDictionary(data:JSON) -> BaseErrorExam {
        let error = ErrorContent.getObjFromDictionary(data: data["error"])
        return BaseErrorExam(error: error)
    }
}

class ErrorContent {
    var code:String
    var message:String
    var details:String
    var validationErrors: String
    
    init(code: String, message: String, details: String, validationErrors: String) {
        self.code = code
        self.message = message
        self.details = details
        self.validationErrors = validationErrors
    }
    
    class func getObjFromDictionary(data:JSON) -> ErrorContent {
        let code = data["code"].stringValue
        let message = data["message"].stringValue
        let details = data["details"].stringValue
        let validationErrors = data["validationErrors"].stringValue
        return ErrorContent(code: code, message: message, details: details, validationErrors: validationErrors)
    }
    
}
