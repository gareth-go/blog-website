import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="notifications"
export default class extends Controller {
  static targets = [ "allNotifications", "postsNotifications", "commentsNotifications", "reactionsNotifications", "loadMoreButton" ]
  static values = { type: String }

  initialize() {
    switch (this.typeValue) {
      case "Post":
        this.postsNotificationsTarget.classList.add("bg-white");
        break;
      case "Comment":
        this.commentsNotificationsTarget.classList.add("bg-white");
        break;
      case "Reaction":
        this.reactionsNotificationsTarget.classList.add("bg-white");
        break;
      default:
        this.allNotificationsTarget.classList.add("bg-white");
    }

    let observer;

    let options = {
      root: null,
      rootMargin: "0px",
    };

    observer = new IntersectionObserver(handleIntersect, options);
    observer.observe(this.loadMoreButtonTarget);
  
    function handleIntersect(entries, observer) {
      entries.forEach((entry) => {
        if (entry.isIntersecting) {
          // get url of the next page
          var url = $('.pagination > .next > a').attr('href');
          if (url == '#') return
          
          console.log(url)
          $.ajax({
            url,
            data: {
              next_page: true 
            },
            method: 'get',
            dataType: 'script',
            success: function (data) {
              if (data.errors) {
                console.log('error')
              }
            },
            error: function(xhr, textStatus, errorThrown) {
              console.log("Error:", errorThrown);
            }
          })
        }
      })
    }
  }
}
