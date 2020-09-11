import UIKit

class GameViewController: UIViewController {

   
        //MARK: - Properties
        @IBOutlet private weak var bestTimeRecordLabel: UILabel!
        @IBOutlet private weak var nowTimeRecordLabel: UILabel!
        @IBOutlet private weak var collectionView: UICollectionView!
        @IBOutlet private weak var pressToStartButton: UIButton!
        
        private var cellIdentifier = "cell"
        private var numbers = Array(1...25)
        private var nowNum = 1
        private var mainTimer: Timer?
        private var timeCount = 0
        private let dateFormatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy.MM.dd HH:mm:ss"
            return formatter
        }()
        private let nsKeyedArchiverHelper = NSKeyedArchiverHelper.shared
        
        
        //MARK: - Life Cycle
        override func viewDidLoad() {
            super.viewDidLoad()
            
            numbers.shuffle()
            if nsKeyedArchiverHelper.userDatas.count >= 1 {
                 bestTimeRecordLabel.text = "\(nsKeyedArchiverHelper.userDatas[0].userName) \(nsKeyedArchiverHelper.userDatas[0].timerRecord)"
            }
            let flowLayout = UICollectionViewFlowLayout()
            flowLayout.sectionInset = UIEdgeInsets.zero
            flowLayout.minimumLineSpacing = 5
            flowLayout.minimumInteritemSpacing = 5
            
            let cellWidth = (collectionView.bounds.width / 5.0) - 10
            let cellHeight = (collectionView.bounds.height / 5.0) - 10
            flowLayout.estimatedItemSize = CGSize(width: cellWidth, height: cellHeight)
            collectionView.collectionViewLayout = flowLayout
            collectionView.reloadData()
        }
        
        //MARK: - Collection View
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return 25
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? MyCollectionViewCell else {
                return UICollectionViewCell()
            }
            
            cell.numLabel.text = "\(numbers[indexPath.row])"
            
            return cell
        }
        
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            guard let cell = collectionView.cellForItem(at: indexPath) as? MyCollectionViewCell else {
                return
            }
            if cell.numLabel.text == String(nowNum) {
                nowNum += 1
                cell.alpha = 0
            }
        }

        //MARK: - @IBAction
        @IBAction func homeButtonTouched(_ sender: UIButton){
            navigationController?.popViewController(animated: true)
        }
        
        @IBAction func pressToStartButtonTouched(_ sender: UIButton){
            pressToStartButton.alpha = 0
            mainTimer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true, block: {(_) in self.timeCount += 1
                DispatchQueue.main.async {
                    let timeString = self.makeTimeLabel(count: self.timeCount)
                    self.nowTimeRecordLabel.text = timeString
                }
            
                if self.nowNum >= 26 {
                    self.mainTimer?.invalidate()
                    self.mainTimer = nil
                    
                    let alertController = UIAlertController(title: "Clear!", message: "Enter Your name", preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "OK", style: .default) { [weak self] (_) in
                        guard let name = alertController.textFields?[0].text else {
                            return
                        }
                        let userData = UserData (userName: name, timerRecord: self?.nowTimeRecordLabel.text ??  "00:00:00", dateAndTime: self?.dateFormatter.string(from: Date()) ?? "2020.9.1 02:2:2")
                        self?.nsKeyedArchiverHelper.saveUserDatas(userData: userData)
                        self?.nowTimeRecordLabel.text = "00:00:00"
                        self?.bestTimeRecordLabel.text = "\(self?.nsKeyedArchiverHelper.userDatas[0].userName) \(self?.nsKeyedArchiverHelper.userDatas[0].timerRecord)"
                        self?.pressToStartButton.alpha = 1
                        self?.collectionView.reloadData()
                        self?.nowNum = 1
                        self?.timeCount = 0
                    }
                    let cancelAction = UIAlertAction(title: "cancel", style: .cancel, handler: nil)
                    alertController.addAction(okAction)
                    //이거 블로그에서는 addAction순서 중요하다고 했는데 업뎃하고 나서부터는 상관 없어졌나.?.?
                    alertController.addAction(cancelAction)
                    alertController.addTextField() { (myTextField) in
                        myTextField.placeholder = "Enter your name"
                    }
                    self.present(alertController, animated: true, completion: nil)
                }
            })
            
        }
        
      
        
        //MARK: - Methods
        func makeTimeLabel(count: Int) -> String {
            let sec = (count/10) % 60
            let min = (count / 10) / 60
            let hour = (count / 10 ) / 3600
            
            let sec_string = "\(sec)".count == 1 ? "0\(sec)" : "\(sec)"
            let min_string = "\(min)".count == 1 ? "0\(min)" : "\(min)"
            let hour_string = "\(sec)".count == 1 ? "0\(hour)" : "\(hour)"
            return ("\(hour_string):\(min_string):\(sec_string)")
        }
}
