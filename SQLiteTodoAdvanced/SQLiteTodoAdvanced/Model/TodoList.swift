// MARK: Description
/*
    Description : Model  TodoList)
    Date : 2024.5. 10
    Author : Ilhera
    Updates :
         2024.05.10  by pdg
            -
    Detail : -
    Short keys : com.swiftlec.SQLiteTodoAdvanced

*/


struct TodoList {
    var todoText: String
    var insertDate: String
    var compleDate: String
    var status: Int // 0: 미완료, 1: 완료
    var seq: Int
    
    init(todoText: String, insertDate: String, compleDate: String, status: Int, seq: Int) {
        self.todoText = todoText
        self.insertDate = insertDate
        self.compleDate = compleDate
        self.status = status
        self.seq = seq
    }
} 
