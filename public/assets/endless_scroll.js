$.ajax({
  type: "POST",
  url: '/root',
  headers: {
    Accept: 'text/html'
  },
  success: function (data, text) {
    $('#content').html(childrenContainer(null, data));
  },
  error: function (request, status, error) {
    $('#content').html(childrenContainer(null, request.responseText));
  }
});

$(document).on('click', 'a[href^="/"]', function(evt){
  evt.preventDefault()

  var element = $(this),
      params = element.data('params'),
      href = element.attr('href')

  $.ajax({
    type: "POST",
    url: href,
    data: params,
    headers: {
      Accept: 'text/html'
    },
    success: function (data, text) {
      insertChildren(data, element)
    },
    error: function (request, status, error) {
      insertChildren(request.responseText, element)
    }
  });
})

const insertChildren = function (content, element){
  var parentContainer = element.parents(".children")

  parentContainer
    .nextAll()
    .remove()

  var title = element.data('children-title'),
      children = childrenContainer(title, content)

  children.insertAfter(parentContainer)

  $('html, body').animate({
    scrollTop: children.offset().top
  }, 500);
}

const childrenContainer = function (title, content){
  var contents = $('<div class="message is-info">')

  if( title ){
    contents.append('<div class="message-header">'+ title +'</div>')
  }

  contents.append('<div class="message-body">' + content + '</div>')

  var children = $("<div>", {class: "children"}).html(contents)

  return children
}
