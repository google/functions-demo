// Copyright 2017 Google
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import UIKit
import Firebase
import FirebaseDatabaseUI

class TableViewController: UITableViewController {

  @IBOutlet weak var textField: UITextField!
  var messagesReference : FIRDatabaseReference?
  var dataSource : FUITableViewDataSource?

  @IBAction func itemAdded(_ sender: Any) {
    messagesReference!.childByAutoId().setValue(["item" :self.textField.text])
    self.textField.text = ""
  }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.textField.addTarget(self.textField, action: #selector(resignFirstResponder),
                                 for: UIControlEvents.editingDidEndOnExit);

      FIRApp.configure()

      messagesReference = FIRDatabase.database().reference().child("wishlist")

      dataSource = FUITableViewDataSource(query: messagesReference!, populateCell: {
        (tableView, indexPath, dataSnapshot) -> UITableViewCell in
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell")!
        let value = dataSnapshot.value as! NSDictionary

        let item = value["item"] as! String
        let detail = value["price"] as? String
        cell.textLabel?.text = "\(item) - (\(detail ?? "loading"))"
        return cell
      })

      dataSource!.bind(to: self.tableView)
    }
}
