// MARK: Description
/*
    Description : View Model
    Date : 2024.5. 10
    Author : Ilhera
    Updates :
         2024.05.10  by pdg
            -
    Detail : -
    Short keys : com.swiftlec.SQLiteTodoAdvanced

*/

import Foundation
import SQLite3
import UIKit

protocol QueryModelProtocol {
    func itemDownloaded(items: [TodoList])
}


//self.todoText = todoText
//self.insertDate = insertDate
//self.compleDate = compleDate
//self.status = status
//self.seq = seq

class TodoListDB{
    var db: OpaquePointer?
    var addressList: [TodoList] = []
    var delegate: QueryModelProtocol!
    
    init() {
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appending(path: "AddressData.sqlite")
        
        if sqlite3_open(fileURL.path(percentEncoded: true), &db) != SQLITE_OK{
            print("error opening database")
        }
        
        // Table 만들기
        if sqlite3_exec(db, "CREATE TABLE IF NOT EXISTS todoList (sid INTEGER PRIMARY KEY AUTOINCREMENT, text TEXT, insertdate TEXT, compledate TEXT, status INTEGER, seq INTEGER)", nil, nil, nil) != SQLITE_OK{
            let errMsg = String(cString: sqlite3_errmsg(db)!)
            print("error creating table :\(errMsg)")
        }
    }
    
    // todo insert
    // insertdate : 입력날짜
    // compledate : 완료된 날짜 => 처음 insert 시에는 compledate는 널값 처리
    func insertDB(text: String, insertdate: String, compledate: String, status: Int, seq: Int) -> Bool{
        
        
        return true
    }
    
    // 조회
    func queryDB(){
        var stmt: OpaquePointer?
        let queryString = "SELECT * FROM todoList order by sname"
        
        if sqlite3_prepare(db, queryString, -1, &stmt, nil) != SQLITE_OK{
            let errMsg = String(cString: sqlite3_errmsg(db)!)
            print("error preparing select : \(errMsg)")
            return
        }

        while(sqlite3_step(stmt) == SQLITE_ROW){
//            let id = Int(sqlite3_column_int(stmt, 0))
//            let name = String(cString: sqlite3_column_text(stmt, 1))
//            let phone = String(cString: sqlite3_column_text(stmt, 2))
//            let address = String(cString: sqlite3_column_text(stmt, 3))
//            let relation = String(cString: sqlite3_column_text(stmt, 4))
//            var image: UIImage = UIImage()
//            
//            if let dataBlob = sqlite3_column_blob(stmt, 5){
//                let dataBlobLength = sqlite3_column_bytes(stmt, 5)
//                let data = Data(bytes: dataBlob, count: Int(dataBlobLength))
//                image = UIImage(data: data)!
//            }
//            
//            addressList.append(Address(id: id, name: name, phone: phone, address: address, relation: relation, image: image))
        }
        self.delegate.itemDownloaded(items: addressList)
    }
    
    
    // 삭제
    func deleteDB(id: Int) -> Bool{
//        var stmt: OpaquePointer?
//        let queryString = "DELETE FROM address WHERE sid = ?"
//        
//        sqlite3_prepare(db, queryString, -1, &stmt, nil)
//        
//        sqlite3_bind_int(stmt, 1, Int32(id))
//
//        if sqlite3_step(stmt) == SQLITE_DONE{
//            return true
//        }else{
//            return false
//        }
        
    return true
    }
    
    // 수정
    func updateDB(id: Int, text: String, status: Int, seq: Int) -> Bool{
//        var stmt: OpaquePointer?
//        let SQLITE_TRANSIENT = unsafeBitCast(-1, to: sqlite3_destructor_type.self)
//                
//        let queryString = "UPDATE address SET sname = ?, sphone = ?, saddress = ?, srelation = ?, simage = ? WHERE sid = ?"
//        
//        sqlite3_prepare(db, queryString, -1, &stmt, nil)
//        
//        sqlite3_bind_text(stmt, 1, name, -1, SQLITE_TRANSIENT)
//        sqlite3_bind_text(stmt, 2, phone, -1, SQLITE_TRANSIENT)
//        sqlite3_bind_text(stmt, 3, address, -1, SQLITE_TRANSIENT)
//        sqlite3_bind_text(stmt, 4, relation, -1, SQLITE_TRANSIENT)
//        
//        let imageData = image.jpegData(compressionQuality: 0.4)! as NSData
//        sqlite3_bind_blob(stmt, 5, imageData.bytes, Int32(imageData.length), SQLITE_TRANSIENT)
//        
//        sqlite3_bind_int(stmt, 6, Int32(id))
//      
//        if sqlite3_step(stmt) == SQLITE_DONE{
//            return true
//        }else{
//            return false
//        }
        return true
    }
}
