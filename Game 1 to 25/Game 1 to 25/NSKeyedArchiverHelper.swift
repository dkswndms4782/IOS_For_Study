import Foundation

class NSKeyedArchiverHelper {
    
    //MARK: - Properties
    static let shared = NSKeyedArchiverHelper()
    private let fileName = "UserDatas"
    var userDatas: [UserData] = []
    private lazy var userDataArchiveURL: URL = {
        let documentDirectories = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return documentDirectories[0].appendingPathComponent(fileName)
    } ()
    
    //MARK: - Methods
    init(){
        getUserDatas()
    }
    
    func getUserDatas() {
        do {
            let archivedData = try Data(contentsOf: userDataArchiveURL)
            if let archivedDatas = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(archivedData) as? [UserData] {
                userDatas = archivedDatas}
            } catch {
                print(error.localizedDescription)
            }
    }
    
    func saveUserDatas(userData: UserData){
        userDatas.append(userData)
        do {
            userDatas = userDatas.sorted(by: {$0.timerRecord < $1.timerRecord })
            let dataToBeArchived = try NSKeyedArchiver.archivedData(withRootObject: userDatas, requiringSecureCoding: false)
            try dataToBeArchived.write(to: userDataArchiveURL)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func deleteUserDatas(){
        userDatas = []
        do {
            let dataToBeArchived = try NSKeyedArchiver.archivedData(withRootObject: userDatas, requiringSecureCoding: false)
            try dataToBeArchived.write(to: userDataArchiveURL)
        } catch {
            print(error.localizedDescription)
        }
    }
    
}
