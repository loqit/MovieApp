import Foundation

class ChatListViewModel: ChatListViewModelProtocol {
    
    private(set) var chats: [ChatCellModel] = [
        ChatCellModel(title: "Jhon Doe",
                      lastMessage: "Hello World!",
                      image: "",
                      isOnline: true,
                      numberOfUnreadMessages: 1)
    ]
}
