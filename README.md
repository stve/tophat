# TopHat

TopHat is a set of view helpers to keep your layouts and views DRY.

## Installation

Just add it to your Gemfile:

    gem 'tophat'

Note: TopHat is Rails 3.0+ compatible.

## Layout Usage

You'll want to add the relevant TopHat helpers to your layouts:

    <head>
      <%= title :site => "My website", :separator => '|' %>
      <%= keywords :default => "Some default, keywords, that can be overridden" %>
      <%= description :default => "A description" %>
    </head>

## View Usage

To set the page title, use the title method to each of your views:

    <% title "My page title" %>

When rendered, the page title will be included in your view.

    <head>
      <title>My website | My page title</title>
    </head>

## Usage Options

Use these options to customize the title format:

* `:prefix` (text between site name and separator) [default: '']
* `:separator` (text used to separate website name from page title, default is '')
* `:suffix` (text between separator and page title) [default: ' ']
* `:lowercase` (when true, the entire title will be lowercase)
* `:uppercase` (when true, the entire title will be uppercase)
* `:reverse` (when true, the page and site names will be reversed)
* `:reverse_on_default` (when true it will lead to a 'Default Title | Site' title when using a default title)
* `:default` (default title to use when title is blank)

And here are a few examples to give you ideas.

    <%= title :separator => "|" %>
    <%= title :prefix => false, :separator => ":" %>
    <%= title :lowercase => true %>
    <%= title :reverse => true, :prefix => false %>
    <%= title :default => "The ultimate site for Rails" %>

These options can be set as defaults for your layout, or when setting the title in your views, you can override any of the default settings by passing an optional hash

    <% title "My page title", :lowercase => true, :separator => "~" %>

## Meta Tags

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

    <%= keywords :default => 'Yoko, Linda' %>
    <%= description :default => 'default description if none is passed' %>

want to merge your default tags with those in your view? just pass merge_default => true

    <%= keywords :default => 'Yoko, Linda', :merge_default => true %>

There are also convenience methods for a few common meta tags:

    <%= noindex() %>          # outputs: <meta content="noindex" name="robots" />
    <%= noindex('googlebot')  # outputs: <meta content="noindex" name="googlebot" />
    <%= nofollow() %>         # outputs: <meta content="nofollow" name="robots" />
    <%= nofollow('googlebot') # outputs: <meta content="nofollow" name="googlebot" />
    <%= canonical('http://mysite.com/somepath/') %> # outputs: <link href="http://mysite.com/somepath/" rel="canonical" />

## Browser Conditionals

TopHat can generate a lot of different browser conditional comments as well:

    ie_5_conditional do
      stylesheet_link_tag 'ie'
    end

will render:

    <!--[if IE 5]>
      <link href="/stylesheets/ie.css" media="screen" rel="stylesheet" type="text/css" />
    <![endif]-->

You can also pass in conditions via an argument to the conditional:

    ie_5_5_conditional(:lt) => <!--[if lt IE 5.5]>
    ie_5_5_conditional(:gt) => <!--[if gt IE 5.5]>
    ie_5_conditional(:lte) => <!--[if lte IE 5]>
    ie_5_conditional(:gte) => <!--[if gte IE 5]>
    if_5_5_conditional(:not) => <!--[if !IE 5]>
    webkit_conditional(:eq) => <!--[if eq Webkit]>

A lot of browsers are supported, check the code for the full listing.

## OpenGraph Helpers

TopHat can also generate Facebook OpenGraph tags.  In your views, you can assign any number of attributes by passing a block to the opengraph helper.  This will store the attributes for that page.

    opengraph do |graph|
      graph.title 'Rain Man'
      graph.type 'Movie'
    end

To embed OpenGraph tags on your page, you'll need to reference opengraph in your layout.

    <%= opengraph %>

You can add an app_id and/or admin ids in your layout:

    <%= opengraph(:app_id => 'MyApp', :admins => [123, 1234]) %>

When used in combination, TopHat will render:

    <meta content="MyApp" property="fb:app_id" />
    <meta content="123,1234" property="fb:admins" />
    <meta content="movie" property="og:type" />
    <meta content="Rain Man" property="og:title" />

There's also a helper for the html tag along with the opengraph namespaces:

    html_with_opengraph => <html xmlns:fb...>


Note: TopHat does not include a "Like" button helper. TopHat's focus is inside the `<head>` tag.

## <a name="build"></a>Build Status
[![Build Status](https://secure.travis-ci.org/spagalloco/tophat.png?branch=master)][travis]

[travis]: http://travis-ci.org/spagalloco/tophat

## <a name="dependencies"></a>Dependency Status
[![Dependency Status](https://gemnasium.com/spagalloco/tophat.png?travis)][gemnasium]

[gemnasium]: https://gemnasium.com/spagalloco/tophat

## Contributing

* Fork the project.
* Make your feature addition or bug fix.
* Add tests for it. This is important so I don't break it in a
  future version unintentionally.
* Commit, do not mess with rakefile, version, or history.
  (if you want to have your own version, that is fine but bump version in a commit by itself I can ignore when I pull)
* Send me a pull request. Bonus points for topic branches.

## Copyright

Copyright (c) 2011 Steve Agalloco. See [LICENSE](https://github.com/spagalloco/tophat/blob/master/LICENSE.md) for details.
