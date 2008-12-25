Problem
=======
In case of failure the normal `should be_redirect` and its friends are far from helpful...

    expected redirect? to return true, got false
    expected "new", got nil

Solution
========

    Status should be redirect but was 200(success)
     - rendered addresses/new
     - Flash:
        :error = Address contains errors!
     - Errors:Errors on @address(Address):
         City can't be blank

Install
=======
`script/plugin install git://github.com/grosser/rspec_response_enhancer.git`  
add to `spec/spec_helper.rb`:

    Spec::Runner.configure do |config|
      ...
      config.include(RspecResponseEnhancer)
      ...
    end

Usage
=======
Use `render_template` / `redirect_to` like normal.

I chose not to globally overwrite `be_redirect` and `be_success`.  
So ATM to get enhanced benefits use `have_been_success`...

    response.should have_been_success
    response.should have_been_error
    response.should have_been_missing
    response.should have_been_redirect


Author
======
Michael Grosser  
grosser.michael@gmail.com
Hereby placed under public domain, do what you want, just do not hold me accountable...  