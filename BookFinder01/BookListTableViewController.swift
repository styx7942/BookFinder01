//
//  BookListTableViewController.swift
//  BookFinder01
//
//  Created by D7703_17 on 2017. 10. 31..
//  Copyright © 2017년 D7703_17. All rights reserved.
//


//네이게이션 컨트롤러에 이전 다음 버튼 생성
//표지(왼쪽),제목,가격(오른쪽밑)


import UIKit

class BookListTableViewController: UITableViewController, XMLParserDelegate,UISearchBarDelegate {
      
      
      var item : [String:String] = [:]
      var items : [[String:String]] = []
      var key : String = ""
      let apiKey = "12e019b25265e571f9c178f4d9e4540d"
//      let apiKey = "4aa7f9f59eada170ebbdc5d9d45e686c"
      var page = 1
      
      
      
      
      @IBOutlet weak var searchbar: UISearchBar!
      override func viewDidLoad() {
        super.viewDidLoad()
      
      searchbar.delegate = self
      
     
    }
      
      
      func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
            search(query: searchbar.text!, pageno: page)
      }
      func search(query:String, pageno:Int){
            let str = "https://apis.daum.net/search/book?apikey=\(apiKey)&output=xml&q=\(query)&result=20&pageno=\(pageno)" as NSString
            
            let strURL = str.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)//한글을 Percent로 인코딩
            
            
            //let url = URL(string: strURL)!  <--문제생길시 터질 수 있음
            
            //----------------------------방법1
            //            if let strURL = strURL, let url = URL(string: strURL),let parser = XMLParser(contentsOf: url){//strURL가 nil이 아니면 실행
            //
            //
            //                              parser.delegate = self
            //
            //                              let success = parser.parse()
            //                              if success {
            //                                    print("parsing success")
            //                                    print(items)
            //                              }else{
            //                                    print("parsing fail")
            //                              }
            //            }
            //
            
            //---------------------------방법2
            if let strURL = strURL{//strURL가 nil이 아니면 실행
                  if let url = URL(string: strURL){
                        if let parser = XMLParser(contentsOf: url){
                              parser.delegate = self
                              
                              let success = parser.parse()
                              if success {
                                    print("parsing success")
                                    print(items)
                                    tableView.reloadData()
                              }else{
                                    print("parsing fail")
                              }
                        }
                  }
            }
            //---------
      }
      func parser(_ parser : XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]){
            if elementName == "item"{
                  item = [:]
            }else{
                  key = elementName
            }
      }
      
      func parser(_ parser : XMLParser, foundCharacters string: String){
            item[key] = string
      }
      
      
      func parser(_ parser : XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?){
            if elementName == "item"{
                  items.append(item)
            }
      }
      
      
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return items.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)

      let book = items[indexPath.row]
      
      cell.textLabel?.text = book["title"]
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
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
