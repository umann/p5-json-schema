package JSON::Schema::Error;

use 5.010;
use strict;
use overload '""' => \&to_string;

use JSON::Path;

our $VERSION = '0.012';

sub new
{
	my ($class, $e) = @_;
	return bless $e, $class;
}

sub property
{
	my ($self) = @_;
	return JSON::Path->new($self->{property});
}

sub message
{
	my ($self) = @_;
	return $self->{message};
}

sub title
{
	my ($self) = @_;
	return $self->{title};
}

sub description
{
	my ($self) = @_;
	return $self->{description};
}

sub to_string
{
	my ($self) = @_;
	return sprintf("%s: %s", $self->property, $self->message);
}

1;

__END__

=head1 NAME

JSON::Schema::Error - an error that occurred when checking an instance against a schema

=head1 SYNOPSIS

 my $validator = JSON::Schema->new($schema);
 my $json      = from_json( ... );
 my $result    = $validator->validate($json);
 
 if ($result)
 {
   print "Valid!\n";
 }
 else
 {
   print "Errors\n";
	print " - $_\n" foreach $result->errors;
 }

=head1 DESCRIPTION

L<JSON::Schema::Error> is returned by the L<JSON::Schema::Result> C<errors>
method. It uses L<overload> to mimic a string. That is:

  print $error;

Will print something sensible.

There's also a two methods C<property> and C<message> which return the
JSONPath to the node that caused the error, and the error message respectively.

Lastly, there's methods C<title> and C<description> which return the title
and description of the offending property, as given in the schema.

=head1 SEE ALSO

L<JSON::Schema>, L<JSON::Schema::Result>.

=head1 AUTHOR

Toby Inkster E<lt>tobyink@cpan.orgE<gt>.

=head1 COPYRIGHT AND LICENCE

Copyright 2010-2012 Toby Inkster.

This module is tri-licensed. It is available under the X11 (a.k.a. MIT)
licence; you can also redistribute it and/or modify it under the same
terms as Perl itself.

=head2 a.k.a. "The MIT Licence"

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.

=cut
