#!/usr/bin/env perl

use strict;
use warnings;
use inc::Module::Install;

all_from 'lib/Shutterstock/Guestbook/Web.pm';
require 'maint/Makefile.PL.include'
  if $Module::Install::AUTHOR;

requires 'Web::Simple';
requires 'HTML::Zoom';
requires 'Plack';

test_requires 'Test::Most';
tests_recursive;
WriteAll;
