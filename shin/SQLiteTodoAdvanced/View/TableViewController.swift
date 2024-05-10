//
//  TableViewController.swift
//  SQLiteTodoAdvanced
//
//  Created by 신나라 on 5/10/24.
//

import UIKit

class TableViewController: UITableViewController {

    @IBOutlet var tvListView: UITableView!
    
    var dataArray: [TodoList] = []
    var titleValue: String = ""
    var message = ""
    var actionTitle = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        self.navigationItem.leftBarButtonItem = self.editButtonItem
    }
    
    override func viewWillAppear(_ animated: Bool) {
        reloadAction()
    }
    
    func reloadAction() {
        let todoList = TodoListDB()
        dataArray.removeAll()
        todoList.delegate = self
        todoList.queryDB()
        tvListView.reloadData()
    }
    
    @IBAction func btnAdd(_ sender: UIBarButtonItem) {
        let addAlert = UIAlertController(title: "TodoList", message: "추가할 내용을 입력하세요", preferredStyle: .alert)
        
        addAlert.addTextField{ACTION in
            ACTION.placeholder = "추가 내용"
        }
        
        let cancelAction = UIAlertAction(title: "취소", style: .default)
        let okAction = UIAlertAction(title: "추가", style: .default, handler: { ACTION in
            let queryModel = TodoListDB()
            
            let textValue = addAlert.textFields![0].text!
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            let currentDate = Date()
            let insertDate = dateFormatter.string(from: currentDate)
            
            let status = 0
            let result = queryModel.insertDB(text: textValue, insertdate: insertDate, compledate: "", status: status)
            
            
            if result {
                let textAlert = UIAlertController(title: "결과", message: "입력이 완료했습니다.", preferredStyle: .alert)
                let actionDefalut = UIAlertAction(title: "확인", style: .default)
                textAlert.addAction(actionDefalut)
                
                self.present(textAlert, animated: true) //화면띄우기
                
                self.reloadAction()
                
            } else {
                let textAlert = UIAlertController(title: "결과", message: "입력에 실패했습니다.", preferredStyle: .alert)
                let actionDefalut = UIAlertAction(title: "확인", style: .default)
                textAlert.addAction(actionDefalut)
                
                self.present(textAlert, animated: true) //화면띄우기
                self.reloadAction()
            }
            
        })
        addAlert.addAction(cancelAction)
        addAlert.addAction(okAction)
        
        present(addAlert, animated: true)
        
        
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
        content.image = UIImage(systemName: "pencil.circle")
        
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

    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    

}

extension TableViewController: QueryModelProtocol {
    func itemDownloaded(items: [TodoList]) {
        dataArray = items
        tvListView.reloadData()
    }
}
