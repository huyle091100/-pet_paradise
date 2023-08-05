import { Controller } from "@hotwired/stimulus"
import consumer from "channels/consumer"

// Connects to data-controller="chat"
export default class extends Controller {
  connect() {
    let user_id = this.element.dataset.chatid;
    this.sub = this.createActionCableChannel(user_id);
    console.log(this.sub)
  }

  createActionCableChannel(user_id) {
    return consumer.subscriptions.create({channel: "ChatChannel", chat_id: user_id}, {
      connected() {
        console.log("connected chat id: ", user_id)
      },

      disconnected() {
      },

      received(data) {
        console.log(data['chat_message'])
        const chatBubble = document.getElementById(`user-chat${data["chat_id"]}`);
        chatBubble.style.display = "block";
        var msg = msg_receive();
        console.log("---------")
        $(`#user-chat${data["chat_id"]} #chat_messages`).append(msg);

        function scrollToBottom(chat_id) {
          const chatbox = document.getElementById(`chatbox-${chat_id}`);
          chatbox.scrollTop = chatbox.scrollHeight;
        }

        $(`#user-chat${data["chat_id"]} #chat_messages`).on('DOMSubtreeModified', function(){
          scrollToBottom(data["chat_id"]);
        })

        function msg_receive() {
          return data['chat_message'];
        }
        scrollToBottom(data["chat_id"]);
      }
    });

  }
}
