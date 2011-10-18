#!/usr/bin/env perl

use strict;
use warnings;
use inc::Module::Install;

all_from 'lib/Shutterstock/Guestbook.pm';
require 'maint/Makefile.PL.include'
  if $Module::Install::AUTHOR;

requires 'Web::Simple';
requires 'HTML::Zoom';
requires 'Plack';
requires 'HTTP::Throwable';
requires 'Text::Markdown';
requires 'IO::All';
requires 'Class::Load';

test_requires 'Test::Most';
test_requires 'Plack::Test::Agent';

tests_recursive;
WriteAll;
