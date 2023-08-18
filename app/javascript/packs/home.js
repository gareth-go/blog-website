$(document).on('turbolinks:load', function() {
  // set auto close alert
  setTimeout(function() {
    $('.alert').alert('close');
  }, 2000)

  // infinite scroll with intersection observer
  load_button = $('.load-more__button')[0]

  let observer;

  let options = {
    root: null,
    rootMargin: "0px",
  };

  observer = new IntersectionObserver(handleIntersect, options);
  observer.observe(load_button);

  function handleIntersect(entries, observer) {
    entries.forEach((entry) => {
      if (entry.isIntersecting) {
        // get url of the next page
        var url = $('.pagination > .next > a').attr('href');
        if (url == '#') return

        $.ajax({
          url,
          method: 'get',
          dataType: 'script',
          success: function (data) {
            if (data.errors) {
              console.log('error')
            } else {
              $('#home-page__main__posts').append(data)
            }
          },
          error: function(xhr, textStatus, errorThrown) {
            console.log("Error:", errorThrown);
          }
        })
      }
    })
  }
})




