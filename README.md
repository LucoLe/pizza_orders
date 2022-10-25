# About

This is an MVP for a pizza orders overview application. It should:
- List a set of orders
- Calculate the price for the items in the order
- Apply promotion codes added to an order
- Apply a discount code
- Mark an order as complete and remove it from the list of orders

# Running the application locally

This is a minimal Rails application. It doesn't have a database so setting up the application is very simple:
1. Clone the repo
2. Execute `bin/setup` to download dependencies, clean up logs and temporary files and restart the server if it's
   already running.
3. Execute `bin/dev` to start the web server and asset compilation

In the `lib/config/` folder you can find `orders.json` and `config.yml` files. Feel free to change them to test the
implementation. Keep in mind that the `config.yml` file is used for the tests so if you do changes to this file you'll
need to update the tests.

# Tests

To run the tests just execute
```bash
bin/rails test
```

The tests are written using Minitest.
