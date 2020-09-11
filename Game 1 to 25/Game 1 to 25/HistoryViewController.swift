import UIKit

class HistoryViewController: UIViewController {

  
        //MARK: - Properties
        @IBOutlet private weak var tableView: UITableView!
        
        private let nsKeyedArchiverHelper = NSKeyedArchiverHelper.shared
        private let cellIdentifier = "cell"
        
        //MARK: - Life Cycle
        override func viewDidLoad() {
            super.viewDidLoad()
    }
        
        //MARK: - TableView
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return nsKeyedArchiverHelper.userDatas.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
            let userData = nsKeyedArchiverHelper.userDatas[indexPath.row]
            cell.textLabel?.text = userData.timerRecord
            cell.detailTextLabel?.text = "\(userData.userName) \(userData.dateAndTime)"
            return cell
        }
        //MARK: - IBAction
        @IBAction func closeButtonTouched(_ sender: UIButton) {
            navigationController?.popViewController(animated: true)
        }
        
        @IBAction func resetButtonTouched(_ sender: UIButton) {
            let alertController = UIAlertController(title: "REALLY?", message: nil, preferredStyle: .alert)
            let yesAction = UIAlertAction(title: "YES", style: .destructive) { [weak self] (_) in
                guard let self = self else { return }
                self.nsKeyedArchiverHelper.deleteUserDatas()
                self.tableView.reloadData()
            }
            let noAction = UIAlertAction(title: "NO", style: .cancel, handler: nil)
            alertController.addAction(noAction)
            alertController.addAction(yesAction)
            present(alertController, animated: true, completion: nil)
        }
}
