# Awardflair

Award flair (badges) to people using your app via the free PickFlair service (http://www.pickflair.com)

## Installation

Add this line to your application's Gemfile:

    gem 'awardflair'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install awardflair

## Usage

    # Get your API keys by:
    1. Going to http://business.awardflair.com
    2. Creating a business (which is free)
    3. Getting your keys at https://yourbusinessnamegoeshere.pickflair.com/applications

    # Connect to your PickFlair account
    pf = PickFlair.new(api_key, api_secret, application_id)

    # Get a list of all the badges you have created on PickFlair
    pf.collect_badges

    # If you have already collected badges, this just gets that list again.  If you haven't, it collects them for the first time
    pf.badges

    # Get badge information using badge identifier
    pf.get_badge_by_identifier(badge_identifier)

    # Find a specific badge that you know you have created using it's name.
    pf.find_badges("Ruby Ace")

    # Award a badge via a link that you can provide to the recipient
    ruby_ace_badge = pf.find_badges("Ruby Ace").first # Choosing the first (and probably only) badge you have named "Ruby Ace"
    ruby_ace_badge.award # Returns a link that you can show to recipient so they can claim the badge.  

    # Award a badge by email (also gets you a link that you can give to the user.)
    first_badge = pf.badges.first # Getting the first badge you created.
    first_badge.award_to("email_address@mydomain.com", :send_email => true)

    # Note that send_email is an option, not a requirement.  Default is false.  
    # If you do not send an email, the user can still claim their badge by creating a PF account using that email address or by following the link you provide.
    # If they have one, they are automatically awarded the badge.
    # Here's an example with no email notification:
    award_link = first_badge.award_to("email_address@mydomain.com")

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
