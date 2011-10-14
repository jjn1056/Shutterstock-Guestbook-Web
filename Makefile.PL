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

test_requires 'Test::Most';
tests_recursive;
WriteAll;
