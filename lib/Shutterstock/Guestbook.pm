package Shutterstock::Guestbook;

our $VERSION = '0.01';

use 5.008008;

1;

=head1 NAME

Shutterstock::Guestbook - Example of a Guestbook application

=head1 SYNOPSIS

  plackup lib/Shutterstock/Guestbook/Web.pm

=head1 DESCRIPTION

This is an example web application using L<Web::Simple>, L<Moo> and L<HTML::Zoom>.

Written in support of tech talk

To Run:

1) clone repository
2) install dependencies ("cpanm --installdeps ." or similar)
3) start: "plackup lib/Shutterstock/Guestbook/Web.pm"

Then point your browser to http://localhost:5000

=head1 AUTHOR

John Napiorkowski C< <<jjnapiork@cpan.org>> >

=head1 COPYRIGHT & LICENSE

Copyright 2011, John Napiorkowski

This program is free software; you can redistribute it and/or modify it under
the same terms as Perl itself.

=cut

