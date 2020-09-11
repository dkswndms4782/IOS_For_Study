import Foundation

class UserData: NSObject, NSCoding {
    
    //MARK: - Properties
    var userName: String
    var timerRecord: String
    var dateAndTime: String
    
    //MARK: - Methods
    init(userName: String, timerRecord: String, dateAndTime: String){
        self.userName = userName
        self.timerRecord = timerRecord
        self.dateAndTime = dateAndTime
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(userName, forKey: "userName")
        aCoder.encode(timerRecord, forKey: "timerRecord")
        aCoder.encode(dateAndTime, forKey: "dateAndTime")
    }
    
    required init?(coder aDecoder: NSCoder) {
        userName = aDecoder.decodeObject(forKey: "userName") as? String ?? "oo"
        timerRecord = aDecoder.decodeObject(forKey: "timerRecord") as? String ?? "00:00:00"
        dateAndTime = aDecoder.decodeObject(forKey: "dateAndTime") as? String ?? "2020.09.01 17:35:64"
        super.init()
    }
}
