TopHat
======

TopHat is a set of view helpers to keep your layouts and views DRY.

Layout Usage
------------

You'll want to add the relevant TopHat helpers to your layouts:

    <head>
      <%= title :site => "My website" %>
      <%= keywords :default => "Some default, keywords, that can be overridden" %>
      <%= description :default => "A description" %>
    </head>

View Usage
----------

To set the page title, use the title method to each of your views:

    <% title "My page title" %>

When rendered, the page title will be included in your view.

    <head>
      <title>My website | My page title</title>
    </head>

Usage Options
-------------

Use these options to customize the title format:

* :prefix (text between site name and separator)
* :separator (text used to separate website name from page title)
* :suffix (text between separator and page title)
* :lowercase (when true, the page name will be lowercase)
* :reverse (when true, the page and site names will be reversed)
* :default (default title to use when title is blank)

And here are a few examples to give you ideas.

    <%= title :separator => "|" %>
    <%= title :prefix => false, :separator => ":" %>
    <%= title :lowercase => true %>
    <%= title :reverse => true, :prefix => false %>
    <%= title :default => "The ultimate site for Rails" %>

These options can be set as defaults for your layout, or when setting the title in your views, you can override any of the default settings by passing an optional hash

    <% title "My page title", :lowercase => true, :separator => "~" %>

Meta Tag Usage
--------------

TopHat also works with keywords and descriptions.  In your view, simply declare the keywords and description.

    <% description('You say goodbye, I say hello.') %>
    <% keywords('John, Paul, George, Ringo') %>

Keywords can also be passed as an array:

    <% keywords(%w{ John Paul George Ringo }) %>

Then in your layout, add the keyword and description helpers:

    <%= keywords %>
    <%= description %>

which will output the meta-tags:

    <meta name="keywords" content="John, Paul, George, Ringo" />
    <meta name="description" content="You say goodbye, I say hello." />

keywords and descriptions can also take a default in the layout:

    <%= keywords :default => 'default keywords if none are passed' %>
    <%= description :default => 'default description if none is passed' %>

Note on Patches/Pull Requests
-----------------------------

* Fork the project.
* Make your feature addition or bug fix.
* Add tests for it. This is important so I don't break it in a
  future version unintentionally.
* Commit, do not mess with rakefile, version, or history.
  (if you want to have your own version, that is fine but bump version in a commit by itself I can ignore when I pull)
* Send me a pull request. Bonus points for topic branches.

Copyright
---------

Copyright (c) 2011 Steve Agalloco. See LICENSE for details.
