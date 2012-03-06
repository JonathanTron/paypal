= 3.0.0 (git)

    Add missing require of `common.rb` in `lib/paypal/rails.rb` file (Lairton Borges)
    Update spec task to use the new RSpec module name
    Remove constant/class variable usage and use Thread specific configurations
    Start spec on Paypal::Helpers::Common.paypal_setup
    Fix specs for Paypal::Config
    Upgrade dev dependencies to use Rspec >= 2.0.0.a
    Introduce a Paypal::Config module to handle ipn/certificates (Jonathan Tron)
    Allow access to params as method (via method_missing) (Jonathan Tron)
    Rework Paypal::Notification :
      Remove methods to get params informations (CAUTION !!! THIS BREAK OLD API) (Jonathan Tron)
      Add methods for all possible statuses and rename #complete? as completed? to follow Paypal naming (Jonathan Tron)
    Use Rack::Utils#parse_query in Paypal::Notification for query parsing (Jonathan Tron)
    Add Spec for notification (Jonathan Tron)
    Add paypal/rails.rb to trigger helper inclusion in view (Jonathan Tron)
    Separate actual helpers in two files (paypal/helpers/common.rb and paypal/helpers/rails.rb) (Jonathan Tron)
    Move files around (Jonathan Tron)
    Update the README and switch to MarkDown (Jonathan Tron)
    Add a CHANGELOG file and switch to new format (Jonathan Tron)
    Remove init.rb (Jonathan Tron)
    Configure gem generation with jelewer (Jonathan Tron)

= 2008-10-16 -- 2.0.2

    NEW: Added block style support for paypal_form_tag (paypal_form_tag do blah.. blah... end)
    DEL: Removed patch for 2.0.0, no longer seems suitable.
    NEW: Added testing for the paypal_form_tag block style.
    NEW: Added a sample (actual from paypal sandbox) PayPal server response for IPN, to aid in testing.

= 2008-10-15 -- 2.0.1

    CHG: Modified README.
    FIX: Moved patch to own directory, was being caught by git-hub as gem's README
    NEW: Added patch for currently installed paypal-2.0.0 gem to apply directly on gems directory.
    NEW: Added relevant test statements.
    FIX: removed duplicate 'invoice' method in lib/notification.rb
    NEW: added correct 'custom' method to lib/notification.rb
    NEW: added pending_reason, reason_code, memo, payment_type, exchange_rate methods to lib/notification.rb

= 2006-04-20 -- 2.0.0

    Uses paypal extended syntax. The plugin can now submit shipping and billing addresses using the paypal_address helper.

= 2006-04-20 -- 1.7.0 

    Now a rails plugin

= 2006-02-10 -- 1.5.1

    added complete list of valid paypal options (Paul Hart)

= 2006-02-02 -- 1.5.0

    Now report an error when invalid option is passed to paypal_setup
    Had to rename parameters cancel_url to cancel_return and return_url to return, please update your app
    Improved the test coverage strategy for helper tests
    Added support for encrypted form data (Paul Hart)

= 2005-09-16 -- 0.9.6

    Added readme note about the openssl requirement

= 2005-07-26 -- 0.9.5

    Added tax to the helper parameters
    fixed bug when money class was used to pass in amount. Cents were always 00 (doh!)
    Added invoice and custom optional parameters
    Added charset = utf-8 to all paypal posts
    Wrongly used undefined_quanitity parameter in 0.9.1, this caused users to be prompted for the quanitity on the paypal checkout page... fixed

= 2005-07-22 -- 0.9.1

    support for cancel_url as well as notify_url. This means you can now set the IPN callback address from the paypal_setup method and 
  you don't have to do that in the paypal admin interface!
    Removed the actual form tag from the paypal_setup generated code to conform better with docs 
