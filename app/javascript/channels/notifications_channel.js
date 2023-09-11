import consumer from "./consumer"

consumer.subscriptions.create("NotificationsChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
    console.log("connected to notifications channel...")
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
    console.log("disconnected to notifications channel...")
  },

  received(data) {
    // Called when there's incoming data on the websocket for this channel
    document.querySelector('body').insertAdjacentHTML( "beforeend", data )
    
    document.querySelector('#unview-notifications-count').innerHTML = +document.querySelector('#unview-notifications-count').innerHTML + 1

    setTimeout(function() {
      $(".alert").alert("close");
    }, 2000)
  }
});
