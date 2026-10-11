my %hash;
my %mm;
my @genes;
open(IN,$ARGV[0]);
while(<IN>) {
    chomp;
    next if (/^#/);
    my @ll=split/\t/;
    if (/\tmRNA\t.*ID=([^;]+).*Parent=([^;]+)/) {
        my $id=$1;
        my $parent=$2;
        if (! exists $hash{$parent}) {push(@genes,$parent);}
        $hash{$parent}{$id}{ID}=$id;
        $hash{$parent}{$id}{seq}="$_\n";
        $mm{$id}=$parent;
        next;
    }
    #if (/\texon\t.*Parent=([^;]+)/) {
    #   my $parent=$1;
    #   if (exists $mm{$parent}) {
    #       $hash{$mm{$parent}}{$parent}{exon}+=$ll[4]-$ll[3]+1;
    #       $hash{$mm{$parent}}{$parent}{seq}.="$_\n";
    #   }
    #}
    if (/\tCDS\t.*Parent=([^;]+)/) {
        my $parent=$1;
        if (exists $mm{$parent}) {
            $hash{$mm{$parent}}{$parent}{CDS}+=$ll[4]-$ll[3]+1;
            $hash{$mm{$parent}}{$parent}{seq}.="$_\n";
        }
    }
}
close IN;
foreach my $gene (@genes) {
    my $max=0;
    my $id;
    foreach my $mRNA (keys %{$hash{$gene}}) {
        if ($hash{$gene}{$mRNA}{CDS} >= $max) {
            $max=$hash{$gene}{$mRNA}{CDS};
            $id=$hash{$gene}{$mRNA}{ID};
        }
    }
    #print "$gene\t$id\t$max\n$hash{$gene}{$id}{seq}";
    print "$hash{$gene}{$id}{seq}";
}



