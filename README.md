# Tessera

This gem is intended as JSON API wrapper for OTRS 6.

Documentation of this API with `curl` examples can be found [here](http://doc.otrs.com/doc/manual/admin/5.0/en/html/genericinterface.html#id-1.6.12.10.7.4)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'tessera'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install tessera

## Usage

First of all you have to setup your creadentials like so:

```ruby
Tessera.configure do |config|
  config.username = 'jon'
  config.password = 'SuperSecret'
  config.base_url = 'https://otrs.com/otrs/nph-genericinterface.pl/Webservice/rest/'
end
```

Now you also have to load yourself webservice yml file locate [here](https://github.com/redrick/tessera/blob/master/templates/ticket.yml)
Please do use one enclosed with this gem from github since name of the
webservice is hardcoded for now, will appear in TODO section for further
adjustments...

Gem provides you `Tessera::Ticket` class to use now with following methods:

### FIND

You can find ticket by its ID or by array of IDS like so:

```ruby
ticket = Tessera::Ticket.find(1)
tickets = Tessera::Ticket.find([1, 2, 3])
```

### WHERE

You can search through tickets like so:

```ruby
results = Tessera::Ticket.where(Title: 'Whic%')
```

for the list of all available options to search through you can see [this
page](http://doc.otrs.com/doc/api/otrs/6.0/Perl/Kernel/GenericInterface/Operation/Ticket/TicketSearch.pm.html)

Following where call you get the results object on which you can either choose
if you want array of Tickets or you are just interested in count of them:

```ruby
results.tickets

results.count
```

### CREATE

You can create new ticket like so:

```ruby
params = {
  ticket: {
    title: 'New ticket',
    queue: 2,
    state: 'new',
    priority: 3,
    customer_user: 'andrej',
    customer_id: 'aaaaa'
  },
  article: {
    from: 'sender@gmail.com',
    to: 'receiver@destination.com',
    subject: 'Hello World!',
    body: 'Hello body!',
    article_send: 1
  },
  attachment: {
    tempfile: Rack::Test::UploadedFile.new('spec/support/files/test.pdf')
  }
}

result = Tessera::Ticket.create(params)
```


OR with multiple attachments:

```ruby
params = {
  ticket: {
    title: 'New ticket',
    queue: 2,
    state: 'new',
    priority: 3,
    customer_user: 'andrej',
    customer_id: 'aaaaa'
  },
  article: {
    from: 'sender@gmail.com',
    subject: 'Hello World!',
    body: 'Hello body!',
  },
  attachment: [
    {
      tempfile: Rack::Test::UploadedFile.new('spec/support/files/test.pdf')
    },
    {
      tempfile: Rack::Test::UploadedFile.new('spec/support/files/test2.pdf')
    }
  ]
}

result = Tessera::Ticket.create(params)
```

or creating tickets with specific usage of sending article created to `To`
recipients like so:

```ruby
params = {
  ticket: {
    title: 'New ticket',
    queue: 2,
    state: 'new',
    priority: 3,
    customer_user: 'andrej',
    customer_id: 'aaaaa'
  },
  article: {
    from: 'sender@gmail.com',
    to: 'receiver@destination.com, second@email.com',
    subject: 'Hello World!',
    body: 'Hello body!',
    article_send: 1
  }
}

result = Tessera::Ticket.create(params)
```

NOTE: this sending of article `To` email is not done purely by OTRS, you will
have to user this plugin:
https://github.com/znuny/Znuny4OTRS-GIArticleSend

Please see instalation notes provided by
https://github.com/znuny/Znuny4OTRS-Rep

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/tessera. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## TODO

Unfinished or stuff that needs adjusting:
* Webservice name to configuration (or default from project yml file)
* Update existing ticket not implemented

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Tessera project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/tessera/blob/master/CODE_OF_CONDUCT.md).
