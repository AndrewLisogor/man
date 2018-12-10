//
//  ViewController.swift
//  Shandruk Rostik MAN
//
//  Created by Rostik on 12/5/18.
//  Copyright © 2018 Shandruk. All rights reserved.
//

import UIKit
import Starscream


class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
  
  
  var messages = [String]()
  var authors = [String]()
  var time = [String]()
 
  var socket = WebSocket(url: URL(string: "ws://localhost:1337/")!, protocols: ["chat"])
  
  @IBOutlet weak var tableView: UITableView!
  
  @IBOutlet weak var chatTextField: UITextField!
  
  @IBAction func sendMessageButton(_ sender: Any) {
    sendMessage(chatTextField.text!)
    chatTextField.text = ""
  }
  
  
  var username = ""
  
  override func viewWillAppear(_ animated: Bool) {
    configureTableView()
  }
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    //configureTableView()
    socket.delegate = self
    socket.connect()
    websocketDidConnect(socket: socket)
  }
  
  deinit {
    socket.disconnect(forceTimeout: 0)
    socket.delegate = nil
  }
  
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return messages.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "idCellChat", for: indexPath) as! CustomChatTableViewCell
    cell.lblMessage.text = messages[indexPath.row]
    cell.nameLabel.text = "by \(authors[indexPath.row].uppercased()) @ \(time[indexPath.row])"
    
    return cell
  }
  
  func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    cell.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
    UIView.animate(withDuration: 0.4) {
      cell.transform = CGAffineTransform.identity
    }
  }
  
  func getTodayString() -> String {
    let date = Date()
    let calender = Calendar.current
    let components = calender.dateComponents([.hour,.minute,.second], from: date)
    
    let hour = components.hour
    let minute = components.minute
    let second = components.second
    
    let today_string = String(hour!)  + ":" + String(minute!) + ":" +  String(second!)
    
    return today_string
    
  }

}



// MARK: - FilePrivate
extension ViewController {
  
  func sendMessage(_ message: String) {
    socket.write(string: message)
  }
  
  func messageReceived(_ message: String, senderName: String) {
    let date:String!
    date = getTodayString()
    messages.append(message)
    authors.append(senderName)
    time.append(date)
  }
}

// MARK: - WebSocketDelegate
extension ViewController : WebSocketDelegate {
  func websocketDidReceiveData(socket: WebSocketClient, data: Data) {
   ////
  }
  
  func websocketDidConnect(socket: WebSocketClient) {
    socket.write(string: username)
  }
  
  func websocketDidDisconnect(socket: WebSocketClient, error: Error?) {
    performSegue(withIdentifier: "websocketDisconnected", sender: self)
  }
  
  func websocketDidReceiveMessage(socket: WebSocketClient, text: String) {
    guard let data = text.data(using: .utf16),
      let jsonData = try? JSONSerialization.jsonObject(with: data),
      let jsonDict = jsonData as? [String: Any],
      let messageType = jsonDict["type"] as? String else {
        return
  }
    if messageType == "message",
      let messageData = jsonDict["data"] as? [String: Any],
      let messageAuthor = messageData["author"] as? String,
      let messageText = messageData["text"] as? String {
      
      
      messageReceived(messageText, senderName: messageAuthor)
      tableView.reloadData()
    
    }
  
}
  
  func configureTableView() {
    tableView.delegate = self
    tableView.dataSource = self
    let nibName = UINib(nibName: "CustomChatTableViewCell", bundle: nil)
    tableView.register(nibName, forCellReuseIdentifier: "idCellChat")
    tableView.estimatedRowHeight = 90.0
    tableView.rowHeight = UITableView.automaticDimension
  }
}

