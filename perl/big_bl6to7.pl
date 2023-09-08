#!/usr/bin/perl

#
# big_bl6to7.pl 2017-12-12 10:00 crancurel $
#

=pod

=head1 DESCRIPTION 

big_bl6to7 script

  This script allows to convert outfmt7 to  outfmt6

=head1 VERSION 1  

# Version 1 original version date 2017-12-12 10:00 crancurel $
# Last update 20190228

# Bioinformatics spiboc ISA
# spiboc.big@inra.fr 
# corinne.rancurel@inra.fr
# martine.da-rocha@inra.fr
# Copyright INRA/CNRS

=head1 SYNOPSIS    

$0 [--in][--out]
$0 --in <blast.outfmt7> --out <blast.outfmt6>

=head1 NOTES

### HELP

  in     : path/infile (outfmt6)
  out    : path/outfile (outfmt7)

  big_bl6to7.pl [in][out]
  big_bl6to7.pl --in <path/infile> --out <path/outfile>

=cut

use strict;
use warnings;
use Getopt::Long;
use IO::File;
use Data::Dumper;

			  
MAIN:
{   
	##-- Get Option Long
	my ($in,$out);
	my $opts = GetOptions (	"in=s" => \$in,
							"out=s" => \$out
						  );
	exit() if( $in eq '' || $out eq ''); ## faire un usage à l'occasion

    ##-- convert	
	my %h_query_list = ();
	my %h_acc_ncbi = ();
	my @a_hit_lines = ();
	my $queryb = 'nd';
	
	#- lecture de tous les hits et impression query par query 
	my $fhr_in = new IO::File($in) or Carp::croak("ERROR INFILE - \"$in\" does not exist");
	my $fhw_out = IO::File->new("> $out");
	while (my $record = <$fhr_in>)
	{
		chomp $record;
		my @a_col = split(/\t/,$record);
		
		$queryb = $a_col[0] if( $queryb eq 'nd');
		
		if($queryb eq $a_col[0])
		{
			$h_query_list{$a_col[0]}++;
			$h_acc_ncbi{$a_col[1]}++;
			push(@a_hit_lines,$record);
		}
		else
		{		
			#~ warn  $queryb . "\n";
			print $fhw_out "# BLASTP 2.2.29+\n"; #Version blast fictive !! pas dans M&M, si on connait la version changer ici la version ou faire un sed à posteriori
			print $fhw_out "# Query: " . $queryb . "\n";
			print $fhw_out "# Database: nr\n";
			print $fhw_out "# Fields: query id, subject id, % identity, alignment length, mismatches, gap opens, q. start, q. end, s. start, s. end, evalue, bit score\n";
			print $fhw_out "# " . $h_query_list{$queryb} . " hits found\n"; 

			foreach(keys(@a_hit_lines))
			{
				print $fhw_out $a_hit_lines[$_] . "\n";
			}	 
			$queryb = $a_col[0];
			$h_query_list{$a_col[0]}++;
			$h_acc_ncbi{$a_col[1]}++;
			@a_hit_lines = ();
			push(@a_hit_lines,$record);

		}
	}
	$fhr_in->close(); 	
			
	#- impression de la derniere query
	#~ warn  $queryb . "\n";
	print $fhw_out "# BLASTP 2.2.29+\n";
	print $fhw_out "# Query: " . $queryb . "\n";
	print $fhw_out "# Database: nr\n";
	print $fhw_out "# Fields: query id, subject id, % identity, alignment length, mismatches, gap opens, q. start, q. end, s. start, s. end, evalue, bit score\n";
	print $fhw_out "# " . $h_query_list{$queryb} . " hits found\n"; 
	foreach(keys(@a_hit_lines))
	{
		print $fhw_out $a_hit_lines[$_] . "\n";
	}
		
	#- impression de la derniere ligne avec le nombre total de séquences du fichier			
	print $fhw_out "# BLAST processed " .scalar(keys(%h_query_list)). " queries\n";	    
	$fhw_out->close();
	
	
	##-- travail preliminaire sur la correspondance acc <=> gi
	#- to get correspondance
	my $fhw_acc = IO::File->new("> AccList.txt");
	foreach my $acc (keys(%h_acc_ncbi))
	{
		print $fhw_acc $acc . "\n";
	}
	$fhw_acc->close();
	#~ system("blastdbcmd -db /bighub/hub/DB/NR/nr -dbtype prot -entry_batch AccList.txt -target_only -outfmt '%a\tgi|%g|%i' -out AccListGi.txt -logfile AccListGi.log");	   
}
