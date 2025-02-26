#!/usr/bin/perl

my @files = `find . -name sysbench*`;

open( OUTFILE, "> out/all_res.data" ) or die "could not open all_res.data: $!";
print OUTFILE "run, time, tps\n";

while( my $file = shift @files ) {
    next if $file =~ m/\.data$/;
    chomp( $file );
    
    $file =~ m'/(.*)/';
    my $run = $1;
    
    print "parsing file: $file\n";
    
    open( FILE, "< $file" ) or die "could not open $file: $!";
    


    while( my $line = <FILE> ) {
        # print $line;

        # The regular expression does not work as set up before, for me
        # This is a workaround to make it work for me: Pick the required fields one by one; and remove unknown fields(response time)
        my $l1, $l2;
        if( $line =~ m/^\[\s(\d+)s\s\].+/) {
            $l1 = $1;
            if ( $line =~ m/\stps\:\s(\d+\.\d+).+/ ) {
                print OUTFILE "$run, $l1, $1\n";
            }
        }
    } 
    close( FILE );
}
close( OUTFILE );
