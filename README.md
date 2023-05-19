# AGILE WEB DEV WITH RAILS 6 - book

## CHAPTER 1
### Installing Rails
- didnt do it but here it is
```
> ruby -e "$(curl -fsSL \ https://raw.githubusercontent.com/Homebrew/install/master/install)"
When it asks you to install the Xcode command line tools, say yes.
Next, you have a choice. You can let Homebrew update your version of Ruby to the latest (currently Ruby 2.6.5). Or you can install rbenv and install a parallel version of Ruby alongside the system version of Ruby.
Upgrading your version of Ruby is the most straightforward path and can be done with a single command:
$ brew install ruby
Alternatively, you can install rbenv and use it to install Ruby 2.6.5. Just be sure that you do not have RVM installed as those two applications don’t work well together.
Note that in macOS Catalina, the default shell is zsh, not bash as it had been historically. Assuming you are using Catalina and zsh, the Homebrew setup is as follows:
$ brew install rbenv ruby-build
$ rbenv init
$ echo 'eval "$(rbenv init -)"' >> ~/.zshrc $ rehash
On older versions of macOS (or if you are using bash on Catalina), the instructions are similar:
$ brew install rbenv ruby-build
$ echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bash_profile $ ~/.rbenv/bin/rbenv init
$ hash -r
Once you’ve done that, restart your terminal by typing exit and hitting return, and then opening a new terminal window. After that, you can install Ruby like so:
$ rbenv install 2.6.5
$ rbenv global 2.6.5
If you had previously installed ruby-build and it can’t find the definition for Ruby 2.6.5, you might need to reinstall ruby-build and try again:
$ brew reinstall --HEAD ruby-build
$ rbenv install 2.6.5
$ rbenv global 2.6.5
These are the two most popular routes for Mac developers. RVM and chruby are two other alternatives.6,7
Whichever path you take, run the following command to see which version of Ruby you’re working with:
$ ruby -v
You should see the following type of result:
ruby 2.6.5p114 (2019-10-01 revision 67812) [x86_64-darwin18]
Next, run this command to update Rails to the version used by this book: $ gem install rails --version=6.0.1 --no-document
Finally, install Yarn and ChromeDriver:
$ brew install yarn
$ brew tap homebrew/cask
$ brew cask install chromedriver
OK, you OS X users are done. You can skip forward to join the Windows users
in Choosing a Rails Version, on page 14. See you there.
```

# CHAPTER 2
## Instant Gratification
- ls -p
- rails about
```
uncle_leo@uncle-leos-MBP nnn_agile_6 % rails about
About your application's environment
Rails version             7.0.4.3
Ruby version              ruby 3.0.4p208 (2022-04-12 revision 3fa771dded) [arm64-darwin21]
RubyGems version          3.2.33
Rack version              2.2.7
Middleware                ActionDispatch::HostAuthorization, Rack::Sendfile, ActionDispatch::Static, ActionDispatch::Executor, ActionDispatch::ServerTiming, ActiveSupport::Cache::Strategy::LocalCache::Middleware, Rack::Runtime, Rack::MethodOverride, ActionDispatch::RequestId, ActionDispatch::RemoteIp, Sprockets::Rails::QuietAssets, Rails::Rack::Logger, ActionDispatch::ShowExceptions, WebConsole::Middleware, ActionDispatch::DebugExceptions, ActionDispatch::ActionableExceptions, ActionDispatch::Reloader, ActionDispatch::Callbacks, ActiveRecord::Migration::CheckPending, ActionDispatch::Cookies, ActionDispatch::Session::CookieStore, ActionDispatch::Flash, ActionDispatch::ContentSecurityPolicy::Middleware, ActionDispatch::PermissionsPolicy::Middleware, Rack::Head, Rack::ConditionalGet, Rack::ETag, Rack::TempfileReaper
Application root          /Users/uncle_leo/Documents/Web2023_M1_laptop/_tutorials/nnn_agile_6
Environment               development
Database adapter          sqlite3
Database schema version   0
```

- Note if you are using a virtual machine, you need to run Rails like so:
```
demo> bin/rails server -b 0.0.0.0
```

- If you want to enable this server to be accessed by other machines on your network, you will either need to list each server you want to have access separately or you can enable everybody to access your development server by adding the following to config/environments/development.rb:
config.hosts.clear
You will also need to specify 0.0.0.0 as the host to bind to the following code: 
```
demo> bin/rails server -b 0.0.0.0
```

- to see all the files in the folder in the app
```
class PagesController < ApplicationController
  def home
    @files = Dir.glob('*')
  end
end

in the view
<% @files.each do |file| %>
  file name is: <%= file %> <br>
<% end %>
```

# Chapter 3
## The Architecture of Rails Applications
- explaining how rails works

# Chapter 4
## Introduction to Ruby
- expalining ruby

# Chapter 5
## The Depot Application
- explaining the logic/flow of the app

# Chapter 6
## Task A: Creating the Application
- rails generate scaffold Product \
         title:string description:text image_url:string price:decimal
- rails db:migrate
- update the form
```
<%= form.text_area :description, rows: 10, cols: 60 %>
```         
- added to seeds a few products
```
Product.create!(title: 'Programming Crystal',
  description:
    %{<p>
      <em>Create High-Performance, Safe, Concurrent Apps</em>
      Crystal is for Ruby programmers who want more performance or for 
      developers who enjoy working in a high-level scripting environment. Crystal 
      combines native execution speed and concurrency with Ruby-like syntax, so 
      you will feel right at home. This book, the first available on Crystal, 
      shows you how to write applications that have the beauty and elegance of a 
      modern language, combined with the power of types and modern concurrency 
      tooling. Now you can write beautiful code that runs faster, scales better, 
      and is a breeze to deploy.
      </p>},
  image_url: 'crystal.jpg',
  price: 40.00)
```
- (Note that this code uses %{...}. This is an alternative syntax for double- quoted string literals, convenient for use with long strings. Note also that because it uses the Rails create!() method, it’ll raise an exception if records can’t be inserted because of validation errors.)
- added gem: gem "sassc-rails"
- added to layout/app
```
<main class='<%= controller.controller_name %>'> 
  <%= yield %>
</main>
```
- copied over the images to the assets/images
- updated the products/index file
- cool tricks
- a way to add a class to every other line with 'cycle' and strip_tags to take the html tags out

```
      <tr class="<%= cycle('list_line_odd', 'list_line_even') %>">

        <td class="image">
          <%= image_tag(product.image_url, class: 'list_image') %>
        </td>

        <td class="description">
          <h1><%= product.title %></h1>
          <p>
            <%= truncate(strip_tags(product.description),
                         length: 80) %>
          </p>
        </td>
```

# Chapter 7
## Task B: Validation and Unit Testing
- added validations
```
  validates :title, :description, :image_url, presence: true
# 
  validates :title, uniqueness: true
  validates :image_url, allow_blank: true, format: {
    with:    %r{\.(gif|jpg|png)\z}i,
    message: 'must be a URL for GIF, JPG or PNG image.'
  }
  validates :title, length: {minimum: 10}
  validates :price, numericality: { greater_than_or_equal_to: 0.01 }

```