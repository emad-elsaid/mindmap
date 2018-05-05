const childrenContainer = function (title, content){
  var contents = $('<div class="message is-info">')

  if( title ){
    contents.append('<div class="message-header">'+ title +'</div>')
  }

  contents.append('<div class="message-body">' + content + '</div>')

  var children = $("<div>", {class: "children"}).html(contents)

  return children
}

const insertChildren = function (content, element){
  var parentContainer = $(element).parents(".children")

  parentContainer
    .nextAll()
    .remove()

  var title = $(element).data('children-title'),
      children = childrenContainer(title, content)

  children.insertAfter(parentContainer)

  $('html, body').animate({
    scrollTop: children.offset().top
  }, 500);
}

$.get("/root", function(response){
  $('body').html(childrenContainer(null, response));
})

$(document).on('click', 'a[href^="/"]', function(evt){
  var element = this,
      params = $(this).data('params')
  evt.preventDefault()
  evt.stopPropagation()

  $.ajax({
    type: "POST",
    url: this.href,
    data: params,
    success: function (data, text) {
      insertChildren(data, element)
    },
    error: function (request, status, error) {
      insertChildren(request.responseText, element)
    }
  });
})
