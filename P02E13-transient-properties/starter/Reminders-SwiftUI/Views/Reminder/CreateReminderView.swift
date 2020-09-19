/// Copyright (c) 2020 Razeware LLC
/// 
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
/// 
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
/// 
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
/// 
/// This project and source code may use libraries or frameworks that are
/// released under various Open-Source licenses. Use of those libraries and
/// frameworks are governed by their own individual licenses.
///
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

import CoreData
import SwiftUI

enum ReminderPriority: Int16, CaseIterable {
  case none = 0
  case low = 1
  case medium = 2
  case high = 3
}

extension ReminderPriority {
  var shortDisplay: String {
    switch self {
    case .none: return ""
    case .low: return "!"
    case .medium: return "!!"
    case .high: return "!!!"
    }
  }
  
  var fullDisplay: String {
    switch self {
    case .none: return "None"
    case .low: return "Low"
    case .medium: return "Medium"
    case .high: return "High"
    }
  }
}

struct CreateReminderView: View {
  @Environment(\.managedObjectContext) var viewContext: NSManagedObjectContext
  @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
  
  let reminderList: ReminderList
  
  // MARK: - State -
  @State var text: String = ""
  @State var notes: String = ""
  @State var shouldRemind: Bool = false
  @State var dueDate = Date()
  @State var tags = ""
  @State var priority: ReminderPriority = .none
  
  var body: some View {
    NavigationView {
      Form {
        Section {
          TextField("Title", text: $text)
          TextField("Notes", text: $notes)
        }
        Section {
          HStack {
            Toggle(isOn: $shouldRemind) {
              Text("Remind me")
            }
            .onTapGesture {
              UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to:nil, from:nil, for:nil)
            }
          }
          if shouldRemind {
            DatePicker(selection: $dueDate, displayedComponents: .date) {
              Text("Date")
            }
          }
        }
        Section {
          TextField("Tags", text: $tags)
        }
        Section {
          NavigationLink(destination: ReminderPrioritySelectionView(priority: $priority)) {
            Text("Priority")
            Spacer()
            Text(priority.fullDisplay)
          }
        }
      }
      .background(Color(.systemGroupedBackground))
      .navigationBarTitle(Text("Create Reminder"), displayMode: .inline)
      .navigationBarItems(trailing:
        Button(action: {
          
          let tags = Set(self.tags.split(separator: ",").map { Tag.fetchOrCreateWith(title: String($0), in: self.viewContext) })
          
          Reminder.createWith(title: self.text,
                              notes: self.notes,
                              date: self.dueDate,
                              priority: self.priority,
                              tags: tags,
                              in: self.reminderList,
                              using: self.viewContext)
          self.presentationMode.wrappedValue.dismiss()
        }) {
          Text("Save")
            .fontWeight(.bold)
        }
      )
    }
  }
}

struct CreateReminderView_Previews: PreviewProvider {
  static var previews: some View {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let newReminderList = ReminderList(context: context)
    newReminderList.title = "Preview List"
    return CreateReminderView(reminderList: newReminderList)
      .environment(\.managedObjectContext, context)
  }
}
