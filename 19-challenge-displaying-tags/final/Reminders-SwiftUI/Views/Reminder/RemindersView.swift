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

import SwiftUI

struct RemindersView: View {
  @Environment(\.managedObjectContext) var viewContext
  @State var isShowingCreateModal: Bool = false
  @State var isShowingTagsModal: Bool = false
  var fetchRequest: FetchRequest<Reminder>
  var reminders: FetchedResults<Reminder> { return fetchRequest.wrappedValue }
  
  let reminderList: ReminderList
  
  var tags: Array<Tag> {
    let tagsSet = reminderList.reminders.compactMap({$0.tags}).reduce(Set<Tag>(), {(result, tags) in
      var result = result
      result.formUnion(tags)
      return result
    })
    
    return Array(tagsSet)
  }
  
  var body: some View {
    VStack {
      List {
        Section {
          ForEach(reminders, id: \.self) { reminder in
            ReminderRow(reminder: reminder)
          }
        }
      }
      .background(Color.white)
      HStack {
        NewReminderButtonView(isShowingCreateModal: $isShowingCreateModal, reminderList: self.reminderList)
        Spacer()
      }
      .padding(.leading)
    }
    .navigationBarTitle(Text("Reminders"))
    .navigationBarItems(trailing:
      Button(action: { self.isShowingTagsModal.toggle() }) {
        Text("Tags")
      }.sheet(isPresented: self.$isShowingTagsModal, content: {
        TagsView(tags: self.tags)
      })
    )
  }
  
  init(reminderList: ReminderList) {
    self.reminderList = reminderList
    self.fetchRequest = Reminder.reminders(in: reminderList)
  }
}

struct RemindersView_Previews: PreviewProvider {
  static var previews: some View {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let newReminderList = ReminderList(context: context)
    newReminderList.title = "Preview List"
    return RemindersView(reminderList: newReminderList).environment(\.managedObjectContext, context)
  }
}
