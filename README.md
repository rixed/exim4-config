EXIM4 configuration for Debian Squeeze
======================================

Executive Summary
-----------------

Help fight spams by allowing user control of email validity.
Basically:

- `yourname-amazon@your.domain.com` -> `yourname@your.domain.com` if amazon is not blacklisted
- `yourname-2014-01-25@your.domain.com` -> `yourname@your.domain.com` if the expiration date is not reached

The rules
---------

Rewrite localparts to remove chars after a '-', with additional checks:
- trailing dates in format `YYYY-MM-DD` are in the past
- trailing key is not present in `not-locals.dbm`

Local parts that fails these conditions will be delivered to user `fail`
instead (which is unlikely to exist).

So for instance the email `user-2015-12-01@your.domain.com` will be delivered
(to `user@your.domain.com`) until the first of January 2012, while
`user-foobar@your.domain.com` will get delivered (to `user@your.domain.com`) only
if `user-foobar` is not listed in `/etc/exim4/no-locals.dbm` (Note: it's `user-foobar`
not `foobar`!).

The two mechanisms can be used together, as long as the expiration date is
last.

The purpose of this is to be able to forge unique email addresses that are
valid up to a given point.

Makefile
--------

- `make` will build not-locals.dbm from not-locals.txt

- `make DOMAIN=your.domain.com install` will reload exim with the new configuration

- `make DOMAIN=your.domain.com check` will test that the rules are in place and will show some
example of what's to expect. Depending on your configuration you may want
to replace the user name, though.

Enjoy!

