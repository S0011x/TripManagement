//
//  JoinFriends.swift
//  TripManagement
//
//  Created by suha alrajhi on 08/10/1445 AH.
//

import SwiftUI

// User model to represent users in the chat room
struct User: Hashable {
    let id: Int
    let name: String
}
// Message model to represent messages in the chat room
struct Message: Hashable {
    let user: User
    let text: String
    
    // Implementing Hashable
    func hash(into hasher: inout Hasher) {
        hasher.combine(user)
        hasher.combine(text)
    }
    
    // Implementing Equatable
    static func == (lhs: Message, rhs: Message) -> Bool {
        return lhs.user == rhs.user && lhs.text == rhs.text
    }
}

// Chat room view
struct JoinFriends: View {
    @State private var messages: [Message] = []
    @State private var newMessageText: String = ""
    
    // Dummy users for demonstration
    let users: [User] = [
        User(id: 1, name: "User1"),
        User(id: 2, name: "User2")
    ]
    
    var body: some View {
        VStack {
            // Messages list
            List(messages, id: \.self) { message in
                Text("\(message.user.name): \(message.text)")
            }
            
            // Input field for new message
            HStack {
                TextField("Type a message", text: $newMessageText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                Button("Send") {
                    // Dummy logic to send message, here you might have networking logic
                    if let currentUser = users.first {
                        let newMessage = Message(user: currentUser, text: newMessageText)
                        messages.append(newMessage)
                        newMessageText = ""
                    }
                }
            }.padding()
        }
    }
}

struct JoinFriends_Previews: PreviewProvider {
    static var previews: some View {
        JoinFriends()
    }
}
