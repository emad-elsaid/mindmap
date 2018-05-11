# Mindmap (Work In Progress)

[![Gem Version](https://badge.fury.io/rb/mindmap.svg)](https://badge.fury.io/rb/mindmap)

Mindmap is a tiny framework to render and browser a graph like structure,
assuming you have set of simple classes that are related to each other.

The following is the example project to browse file system, generated when issuing
"mindmap new" command, and contains 2 nodes (File, Directory)

[![file system browser](https://i.imgur.com/6ZVIN0x.gif)](https://imgur.com/a/tA7iCtp)

# Rationale

It started with another project I'm working on called
[rubrowser](https://github.com/emad-elsaid/rubrowser) it statically analyze your
ruby code and visualize it in a graph, I thought that this kind of data
(tree/graph like) is everywhere, like my servers, that I can see files,
processes and other open sockets on it, through it I can open another server in
my network, browse through it, open a process there...and so on.

Or Imagine how many times you went to Wikipedia and you found yourself on a page
and you can't remember what made you land here after couple hours of reading.

so I wanted a setup that does the following:

* A shared library that visualize a data structure of nodes linked to each other
* every node could be rendered in any form
* I need to see where I was and the trail that led me to that point and I can
  get back and take another path
* it should be as simple as possible to generate new graph project and put my
  files in it.
* I wanted to have ready made layouts, and the ability to override them and define
  my own layouts.

At first I thought of D3 and visualizing these nodes and make it interactive,
but I had to discard this idea as visualizing nodes in different forms will be
extremely hard for users, not to mention the graph will be very crowded.

So I settled on a page that renders the root node children first, then when you
try to open a node, I append children to the page and the path goes on
endlessly, you can scroll back at any time and open another node it'll clear
every thing under it's level then showing you the node children...and so on.

## Installation

Install it with

    $ gem install mindmap

## Usage

First create a new project, like you do with rails

    $ mindmap new hello

That will create a new directory `hello` with some skeleton in it.

```
example/
├── config.ru
├── Gemfile
├── nodes
│   ├── directory_node.rb
│   ├── file_node.rb
│   └── root_node.rb
└── public

3 directories, 5 files
```

it's a rack application you can start it by `rackup` or

    $ mindmap server

the project contains an example nodes to browse the file system content, you can
start the server and open `http://localhost:9292` in your browser to see it in
action.

a tutorial could be found in the wiki [here](https://github.com/emad-elsaid/mindmap/wiki/Mindmap-tutorial-(file-system-browser))

## Project structure

* config.ru : a rack config file that starts mindmap application and serves
  files from the public directory in both the gem and your project, with your
  project public directory having precedence, so any file you put there will
  override the library file.
* Gemfile : the project has only one direct dependency `mindmap`
* nodes : a directory that has your classes that needs to be visualized, by
  default it contains classes that visualize the file system, it also holds the
  views for these classes in `class_name.html.erb` format or other formats
  wanted like `class_name.json.erb` or similar
* public : the public directory, you can serve any files from there
  css framework in your views as they're loaded by default.

## How to write your Nodes

the `nodes` directory holds your nodes, they're all loaded by default when
starting the mindmap server, the following is a commented example for a node class

```ruby
# a node class name MUST end with "Node"
class DirectoryNode
  # node class MUST include the Node module
  # it include methods to render the node and
  # an initializer for the class
  include Mindmap::Node

  # you can define attributes/member variables as you wish
  # if you're using one of the library views you'll need to defind
  # a specific methods to make it works
  attr_accessor :path

  def name
    File.basename(path)
  end

  # it must return an array of other nodes that this node is related to
  def children
    Dir
      .entries(path)
      .sort
      .reject! { |file| ['.', '..'].include?(file) }
      .map { |file| child(File.expand_path(file, path)) }
  end

  private

  def child(file_path)
    return DirectoryNode.new(path: file_path) if File.directory?(file_path)

    FileNode.new(path: file_path)
  end
end
```

## How it works?

when you start the mindmap server, it loads all library code then loads the
project nodes, it serves files from library public and project public
directories.

when browsing to `localhost:9292` it'll serve the `public/index.html` which is
an empty page that load jquery and bulma css framework and
`public/assets/index.js`

`index.js` is what does the interaction part of the page, it request the `root`
node, so your `nodes` directory must contain that class, mindmap will handle the
request, creating `RootNode` object giving it all `parameters` sent with the
request as a hash, `Mindmap::Node#initializer` will assign any key value to the
object if the `key=` method is public, then mindmap will call the node children.

for every child we'll render it and return the result to the page, the page will
append the response, then wait until you click on any link that refer to a local
page, when you do it'll handle the request, will request the link content with
Ajax sending the `data-params` of the link as parameters to the Ajax POST
request.

mindmap will know the node from the page, for example requesting `/file` will
signal mindmap to create a `FileNode` object with the passed arguments,
`/directory/specific_dir` will create a `Directory::SpecificDir` object...etc


## How rendering nodes works

the renderer will get the view name by calling `view` method, then search for a
file in the project nodes directory, when
found it'll be rendered as an ERB template with the node as a bounding context,
so any method called in the view will be executed from the node.

## How to form links in your views

any link that points to a URL that starts with '/' is considered an AJAX link
and mindmap JavaScript will call the URL with a post request passing the
`data-params` attribute as parameters in the request, so it's a good idea that
you set some hash there that when gets assigned to the object it'll tell him
what to do, an ID in most cases, or for our example nodes the file path, for
others maybe UUID, by default the views will serialize the object as JSON and
put it in the attribute, you can be selective with your views implementation if
you wish, also `data-children-title` attribute is used by the mindmap JavaScript
to use it as a title for the response when appended to the page, it's a good
idea to print the node `children_title` in it.

## Root Node

every graph must have an entry point, `RootNode` is our entry point, this nodes
doesn't have to have any views, an object is created from that class when the
page loads, and the children will be called an rendered, so the node itself
doesn't have to do anything but implementing `children` method returning an array
of nodes to start with.

## Hot code reload

Mindmap doesn't have a hot reload feature, so if you want to change your code
then see the changes without restarting your server manually you can use
[reflex](https://github.com/cespare/reflex) or any other tool that executes a
command on files change, with reflex you can use this command

    $ reflex -s rackup

or

    $ reflex -s mindmap server

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/emad-elsaid/mindmap.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
