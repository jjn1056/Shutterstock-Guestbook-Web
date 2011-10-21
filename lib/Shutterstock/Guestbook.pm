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

Written in support of tech talk.  The goal here is to explain a thinking process
used to model systems, or how I would solve my own interview question.

=head2 Install and Run

The following is an overview of how to install and run this application.

=over 4

=item Fork and Clone Repository

Fork on github L<https://github.com/jjn1056/Shutterstock-Guestbook-Web>, then
clone your fork down to your local system.

=item Install Depdendencies

From the root of your clone type:

    cpanm --installdeps .

You may use to setup a L<local::lib> first.  

=item Run the server

    plackup lib/Shutterstock/Guestbook/Web.pm

Then point your browser to http://localhost:5000

=back

=head1 AUTHOR

John Napiorkowski C< <<jjnapiork@cpan.org>> >

=head1 COPYRIGHT & LICENSE

Copyright 2011, John Napiorkowski

This program is free software; you can redistribute it and/or modify it under
the same terms as Perl itself.

=cut

