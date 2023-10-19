import consumer from "./consumer"

consumer.subscriptions.create("NotificationsChannel", {
  received(data) {
    document.querySelector('body').insertAdjacentHTML( "beforeend", data )
    
    document.querySelector('#unview-notifications-count').innerHTML = +document.querySelector('#unview-notifications-count').innerHTML + 1

    setTimeout(function() {
      $(".alert").alert("close");
    }, 3500)
  }
});
