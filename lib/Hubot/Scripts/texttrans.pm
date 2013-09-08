package Hubot::Scripts::texttrans;

use 5.010;
use utf8;
use strict;
use warnings;
use Encode qw(encode decode);
use Data::Printer;
use DateTime;

sub load {
    my ( $class, $robot ) = @_;
    my %text;
    my $user_name;
    my $user_msg;
    my @msgs;
    

    $robot->catchAll(
        sub {
            my $msg = shift;

            $user_name = $msg->message->user->{name};
            $user_msg = $msg->message->text;

            push @msgs, $user_name, $user_msg;

            %text = (
                $user_name => $user_msg,
            );
        }
    );

    $robot->hear (
        qr/start/i,

        sub {
            my $msg = shift;
#$msg->send($text{$user_name});
            $msg->send(@msgs);
#p %text;
            p @msgs;
        }
    );
}

1;

=pod

=head1 Name 

    Hubot::Scripts::texttrans
 
=head1 SYNOPSIS

=head1 AUTHOR

    YunChang Kang <codenewb@gmail.com>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2013 by Yunchang Kang.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself
 
=cut
