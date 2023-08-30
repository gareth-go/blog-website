import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="dashboard--accounts"
export default class extends Controller {
  static targets = ['searchInput', 'roleSelector', 'statusSelector', 'loadMoreButton']

  initialize() {
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

  filter() {
    $.ajax({
      url: '/dashboard/accounts',
      method: 'get',
      data: {
        search: this.searchInputTarget.value,
        role: this.roleSelectorTarget.value,
        status: this.statusSelectorTarget.value
      },
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
}
