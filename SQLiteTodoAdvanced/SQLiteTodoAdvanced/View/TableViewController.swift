// MARK: Description
/*
    Description : Table View Controller
    Date : 2024.5. 10
    Author : Ilhera
    Updates :
         2024.05.10  by pdg
            -
    Detail : -
    Short keys : com.swiftlec.SQLiteTodoAdvanced

*/

import UIKit

class TableViewController: UITableViewController {

    @IBOutlet var tvListView: UITableView!
    
    var dataArray: [TodoList] = []
    
    // MARK: Init
    override func viewDidLoad() {
        super.viewDidLoad()
        reloadAction()
   
    }

    override func viewWillAppear(_ animated: Bool) {
        reloadAction()
    }
    // MARK: -- Functions
    func reloadAction() {
        let todoList = TodoListDB()
        dataArray.removeAll()
        todoList.delegate = self
        todoList.queryDB()
        tvListView.reloadData()
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return dataArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)
        
        var content = cell.defaultContentConfiguration()
        content.text = dataArray[indexPath.row].todoText
        
        cell.contentConfiguration = content

        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    // MARK: -- Actions
     
     @IBAction func btnInsert(_ sender: Any) {
         //
                let todolistDB = TodoListDB()
                let addAlert = UIAlertController(title: "Todo List", message: "추가한 내용을 입력하세요.", preferredStyle: .alert)
                
                addAlert.addTextField { textField in
                        textField.placeholder = "내용을 입력하세요"
                    }
                let addAction = UIAlertAction(title: "네", style: .default, handler: {ACTION in
                    if let textField = addAlert.textFields?.first, let text = textField.text {
                        // 입력된 텍스트 사용
                        //id,text,insertdate,compledate,status,seq
                        let result = todolistDB.insertDB(text: "--", insertdate: "", compledate: "", status: 1, seq: 1)
                        if result{
                            print("DB 입력된 내용: \(text)")
                        }
                        // 뒤로 이동
                        self.navigationController?.popViewController(animated: true)
                            }
                        self.reloadAction()
                    
                })
                let cancelAction = UIAlertAction(title: "취소" , style: .cancel)
                addAlert.addAction(addAction)
                addAlert.addAction(cancelAction)
                present(addAlert, animated: true)
         
     }
     

}

extension TableViewController: QueryModelProtocol {
    func itemDownloaded(items: [TodoList]) {
        dataArray = items
        tvListView.reloadData()
    }
}
