const childrenContainer = function (title, content){
  var contents = $('<div class="card">')

  if( title ){
    contents.append('<div class="card-header"><p class="card-header-title">'+ title +'</p></div>')
  }

  contents.append('<div class="card-content">' + content + '</div>')

  var children = $("<div>", {class: "children"}).html(contents)

  return children
}

const insertChildren = function (content, element){
  var parentContainer = $(element).parents(".children")

  parentContainer
    .nextAll()
    .remove()

  var title = $(element).data('title'),
      children = childrenContainer(title, content)

  children.insertAfter(parentContainer)

  $('html, body').animate({
    scrollTop: children.offset().top
  }, 500);
}

$.get("/root", function(response){
  $('body').html(childrenContainer(null, response));
})

$(document).on('click', '.action', function(evt){
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
