//
//  ChatViewController.swift
//  
//
//  Created by Nathan khosla on 25 Jun 17.
//
// Shamelessly copied from the Chatto Demo Project

import UIKit
import Chatto
import ChattoAdditions

class ChatViewController: BaseChatViewController {

        var messageSender: FakeMessageSender!
        var dataSource: FakeDataSource! {
            didSet {
                self.chatDataSource = self.dataSource
            }
        }
    
    let chatName = "Chat"
        
        lazy private var baseMessageHandler: BaseMessageHandler = {
            return BaseMessageHandler(messageSender: self.messageSender)
        }()
        
        override func viewDidLoad() {
            super.viewDidLoad()
            let image = UIImage(named: "bubble-incoming-tail-border", in: Bundle(for: ChatViewController.self), compatibleWith: nil)?.bma_tintWithColor(.blue)
            super.chatItemsDecorator = ChatItemsDemoDecorator()
            let addIncomingMessageButton = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(ChatViewController.addRandomIncomingMessage))
            self.navigationItem.rightBarButtonItem = addIncomingMessageButton
        }
    
    
        @objc
        private func addRandomIncomingMessage() {
            self.dataSource.addRandomIncomingMessage()
        }
        
        var chatInputPresenter: BasicChatInputBarPresenter!
        override func createChatInputView() -> UIView {
            let chatInputView = ChatInputBar.loadNib()
            var appearance = ChatInputBarAppearance()
            appearance.sendButtonAppearance.title = NSLocalizedString("Send", comment: "")
            appearance.textInputAppearance.placeholderText = NSLocalizedString("Type a message", comment: "")
            self.chatInputPresenter = BasicChatInputBarPresenter(chatInputBar: chatInputView, chatInputItems: self.createChatInputItems(), chatInputBarAppearance: appearance)
            chatInputView.maxCharactersCount = 1000
            return chatInputView
        }
        
        override func createPresenterBuilders() -> [ChatItemType: [ChatItemPresenterBuilderProtocol]] {
            
            let textMessagePresenter = TextMessagePresenterBuilder(
                viewModelBuilder: DemoTextMessageViewModelBuilder(),
                interactionHandler: DemoTextMessageHandler(baseHandler: self.baseMessageHandler)
            )
            textMessagePresenter.baseMessageStyle = BaseMessageCollectionViewCellAvatarStyle()
            
            let photoMessagePresenter = PhotoMessagePresenterBuilder(
                viewModelBuilder: DemoPhotoMessageViewModelBuilder(),
                interactionHandler: DemoPhotoMessageHandler(baseHandler: self.baseMessageHandler)
            )
            photoMessagePresenter.baseCellStyle = BaseMessageCollectionViewCellAvatarStyle()
            
            return [
                DemoTextMessageModel.chatItemType: [
                    textMessagePresenter
                ],
                DemoPhotoMessageModel.chatItemType: [
                    photoMessagePresenter
                ],
                SendingStatusModel.chatItemType: [SendingStatusPresenterBuilder()],
                TimeSeparatorModel.chatItemType: [TimeSeparatorPresenterBuilder()]
            ]
        }
        
        func createChatInputItems() -> [ChatInputItemProtocol] {
            var items = [ChatInputItemProtocol]()
            items.append(self.createTextInputItem())
            //items.append(self.createPhotoInputItem())
            return items
        }
        
        private func createTextInputItem() -> TextChatInputItem {
            let item = TextChatInputItem()
            item.textInputHandler = { [weak self] text in
                self?.dataSource.addTextMessage(text)
                AnsweredQuestionStore.shared.createAnswerForMostRecentQuestion(a:text)
            }
            return item
        }
        
        private func createPhotoInputItem() -> PhotosChatInputItem {
            let item = PhotosChatInputItem(presentingController: self)
            item.photoInputHandler = { [weak self] image in
                self?.dataSource.addPhotoMessage(image)
            }
            return item
        }
    }

/*
    override func viewDidLoad() {
        super.viewDidLoad()
        self.chatDataSource = YourDataSource()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    var chatInputPresenter: BasicChatInputBarPresenter!
    override func createChatInputView() -> UIView {
        let chatInputView = ChatInputBar.loadNib()
        var appearance = ChatInputBarAppearance()
        appearance.sendButtonAppearance.title = NSLocalizedString("Send", comment: "")
        appearance.textInputAppearance.placeholderText = NSLocalizedString("Type a message", comment: "")
        self.chatInputPresenter = BasicChatInputBarPresenter(chatInputBar: chatInputView, chatInputItems: self.createChatInputItems(), chatInputBarAppearance: appearance)
        chatInputView.maxCharactersCount = 1000
        return chatInputView
    }
    
    func createChatInputItems() -> [ChatInputItemProtocol] {
        var items = [ChatInputItemProtocol]()
        items.append(self.createTextInputItem())
        items.append(self.createPhotoInputItem())
        return items
    }
    
    private func createTextInputItem() -> TextChatInputItem {
        let item = TextChatInputItem()
        item.textInputHandler = { [weak self] text in
            // Your handling logic
        }
        return item
    }
    
    private func createPhotoInputItem() -> PhotosChatInputItem {
        let item = PhotosChatInputItem(presentingController: self)
        item.photoInputHandler = { [weak self] image in
            // Your handling logic
        }
        return item
    }
    
    override func createPresenterBuilders() -> [ChatItemType: [ChatItemPresenterBuilderProtocol]] {
        let textMessagePresenter = TextMessagePresenterBuilder(
            viewModelBuilder: DemoTextMessageViewModelBuilder(),
            interactionHandler: DemoTextMessageHandler(baseHandler: self.baseMessageHandler)
        )
        textMessagePresenter.baseMessageStyle = BaseMessageCollectionViewCellAvatarStyle()
        
        let photoMessagePresenter = PhotoMessagePresenterBuilder(
            viewModelBuilder: DemoPhotoMessageViewModelBuilder(),
            interactionHandler: DemoPhotoMessageHandler(baseHandler: self.baseMessageHandler)
        )
        photoMessagePresenter.baseCellStyle = BaseMessageCollectionViewCellAvatarStyle()
        
        return [
            "text-message-type": [textMessagePresenter],
            "photo-message-type": [photoMessagePresenter],
        ]
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    */


