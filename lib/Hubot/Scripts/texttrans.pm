package Hubot::Scripts::texttrans;

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

            push @msgs, "$user_name"." $user_msg";
        }
    );

    $robot->hear (
        qr/^s\/(.*?)\/(.*?)\/g$/i,

        sub {
            my $msg = shift;

            my $sender = $msg->message->user->{name};
            my $before_wr = $msg->match->[0];
            my $after_wr = $msg->match->[1];

            for my $sender_p ( @msgs ) {
                if ( $sender_p =~ /^$sender .*?$before_wr.*?/ ) { 
                    $sender_p =~ s/$before_wr/$after_wr/;
                    $msg->send($sender_p);
                }
            }
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
