#insert your perl path here


# given a file of nodes, construct the paths



sub getNodePairs()
{

	# read the pairs file and construct an array of links where the first node is
	# used as the index in the array and the other node is part of a colon delimited
	# string of nodes it links to

	my($PairsFile) = @_;

	my %pairs;

	my $line;
	my $fh;
	my @tempsplit;

	open(fh,"<$PairsFile");

	while($line = <fh>)
	{
#		print "\n $line";
		@tempsplit = split(' ',$line);
#		print $tempsplit[0], " maps to ", $tempsplit[1]."\n";
		if(exists $pairs{$tempsplit[0]})
		{
			# amend
			$pairs{$tempsplit[0]}= $pairs{$tempsplit[0]}.":".$tempsplit[1];
#			print "Amended ".$tempsplit[0]." to ".$pairs{$tempsplit[0]};
		}
		else
		{
			# new
			$pairs{$tempsplit[0]}= $tempsplit[1];
#			print  "Initiated ".$tempsplit[0]." to ".$pairs{$tempsplit[0]};
		}
#		print "\n";
	}

	close(fh);

	return %pairs;

}

sub rprint()
{

	# recursive print routine to parse through the pairs array

	local($current, $trace, %pairs) = @_;

	#print "\n Current $current Trace $trace\n";

	if(exists $pairs{$current})
	{
		local @validvars= split(':',$pairs{$current});
		NODES: foreach $validvar (@validvars)
		{

			# is current validvar pair in trace?
			# if so then is it in more than twice?
			# if so then write an * and go to the next validvar
			my $patternToFind= "$current $validvar";

			if( $trace =~ m/([^$current]*)$patternToFind([^$current]*)/)
			{
    			   if( $trace =~ m/([^$current]*)$patternToFind([^$current]*)$patternToFind([^$current]*)/)
			   {

				#print "\nLOOP FOUND $current $validvar ... $trace\n";
				if ($pairs{$current} =~ m/:/)
				{
					#print "\nFOUND EXIT POINT FROM LOOP $current $validvar ... $trace\n";
					next NODES;
				}
			   }
			}
				#print "\n For $validvar we have $trace $current\n";
				local $newtrace = $trace." $current";

				#print "\n Newtrace is $newtrace Valid var is $validvar\n";
				&rprint($validvar, $newtrace, %pairs );		
		
		}
	}
	else
	{
		print $trace." ".$current."\n";
	}

}

sub main()
{

	my %pairs = &getNodePairs($ARGV[0]);


	&rprint("-"," ",%pairs);

}

main();

0;