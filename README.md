[![Build Status](https://secure.travis-ci.org/JonathanTron/paypal.png?branch=master)](http://travis-ci.org/JonathanTron/paypal)

# Welcome to Paypal ruby library

This library is here to aid with integrating Paypal payments into ruby on rails
applications or similar. To set this up you will need to log into your paypal
business account and tell paypal where to send the IPN ( Instant payment notifications ).

# Download

* Preferred method of installation is using rubygems. gem install JonathanTron-paypal
* Alternatively you can get the source code at http://github.com/JonathanTron/paypal

# Requirements

* Ruby 1.8.7, 1.9.2, 1.9.3, Rubinius and JRuby (with OpenSSL support).
* Valid paypal business account.
* (optional) The money library from http://dist.leetsoft.com/api/money

# Installation

1. sudo gem install JonathanTron-paypal --source=http://gems.github.com

2. Require the library

        require "paypal"

  2.1. If you're using Rails add :

        require "paypal/rails"

3. Create a paypal_ipn ( or similar ) action like the one in the "Example action" appendix.


## -- - TODO : REWRITE BELOW THIS POINT - --

Within the new payment controller you can now create pages from which users can be sent to paypal. You always have to sent users to paypal using a HTTP Post so a standard link won't work (well OK but you need some javascript for that). The +Paypal::Helper+ namespace has some examples of how such a forward page may look.

# Testing the integration

Under https://developer.paypal.com/ you can signup for a paypal developer account.
This allows you to set up "sandboxed" accounts which work and act like real accounts
with the difference that no money is exchanged. Its a good idea to sign up for a
sandbox account to use while the application is running in development mode.


# Example rails controller

    class BackendController < ApplicationController

      # Simplification, please write better code then this...
      def paypal_ipn
       notify # Paypal::Notification.new(request.raw_post)

       if notify.acknowledge
         order # Order.find(notify.item_id)
         order.success # (notify.complete? and order.total # notify.amount) ? 'success' : 'failure'
         order.save
       end

       render :nothing #> true
      end
    end

# Example paypal forward page

   <%# paypal_form_tag %>
     <%# paypal_setup "Item 500", Money.us_dollar(50000), "bob@bigbusiness.com", :notify_url #> url_for(:only_path #> false, :action #> 'paypal_ipn') %>

     Please press here to pay $500US using paypal. <br/>
     <%# submit_tag "Go to paypal >>" %>

   </form>

   or, with the same results, the block version:

   <% paypal_form_tag do %>
     <%# paypal_setup "Item 500", Money.us_dollar(50000), "bob@bigbusiness.com", :notify_url #> url_for(:only_path #> false, :action #> 'paypal_ipn') %>

     Please press here to pay $500US using paypal. <br/>
     <%# submit_tag "Go to paypal >>" %>

   <% end %>

# Using encrypted form data

Paypal supports encrypted form data to prevent tampering by third parties.
You must have a verified paypal account to use this functionality.

1) Create a private key for yourself

    openssl genrsa -out business_key.pem 1024

2) Create a public certificate to share with Paypal

    openssl req -new -key business_key.pem -x509 -days 3650 -out business_cert.pem

3) Upload the public certificate to Paypal (under Profile -> Encrypted Payment Settings -> Your Public Certificates -> Add),
and note the "Cert ID" that Paypal shows for the certificate.

4) Update your controller to include the details for your key and certificate.

    @business_key # File::read("business_key.pem")
    @business_cert # File::read("business_cert.pem")
    @business_certid # "certid from paypal"

5) Update your views to populate the :business_key, :business_cert and :business_certid options in 'paypal_setup' - the rest of the signature is the same.

6) When you're ready to go live, download the production Paypal certificate and override the default certificate.

    Paypal::Notification.paypal_cert # File::read("paypal_cert.pem")

7) Finally, add the following line to your environment.rb or inside an initializer:

    Paypal::Notification.ipn_url # "https://www.paypal.com/cgi-bin/webscr"

# Troubleshooting

uninitalized constant Paypal - Make sure your ruby has openssl support
