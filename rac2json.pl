#!/usr/bin/env perl

use strict;
use warnings;
use utf8;

# use Carp;
# use English qw( -no_match_vars ) ;
# use Data::Dumper::AutoEncode '-dumper';

#use Encode;
use warnings FATAL => 'all';
use autodie;
use Devel::Peek qw(Dump);
#use Encode qw(decode encode);

my $L=0;
my $C=0;
my $NR=0;

## sub ltrim { my $s = shift; $s =~ s/\A \s+ //mxs;            return $s }
## sub rtrim { my $s = shift; $s =~ s/ \s+ \z //mxs;           return $s }
## sub  trim { my $s = shift; $s =~ s/\A \s+ | \s+ \z //gmxs;  return $s }


printf( "[\n" );

while( my $line=<> ) {
    chomp( $line );
    $NR++;

    if( $line ne "") {
        my ($vvar, $vval) = split /[:\s]+/, $line, 2;

        if( $L == 0) {
            if( $NR>1 ) {
                printf( ",\n" );
            }
            printf( "{\n" );
            $L = 1;
            $C = 0;
        }
        if( $C > 0 ) {
            printf( ",\n" );
        }

        $vvar =~ s/\A [\s'"]+ | [\s'"]+ \z //gmxs;
        $vval =~ s/\A [\s'"]+ | [\s'"]+ \z //gmxs;

        printf( q{"%s" : "%s"}, $vvar, $vval );
        $C = 1;
    } else {
        if( $L > 0 ) {
            printf( "\n}" );
            $L = 0;
        }
    }
}

printf( "\n]\n" );
