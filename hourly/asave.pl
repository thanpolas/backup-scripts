#!/usr/bin/perl
use POSIX qw(strftime);
use Time::Local;
###############[ Configuration ]###################
## Params
$hourz = $ARGV[0];
$tarname = $ARGV[1];
$DestPath = $ARGV[2];
$SrcPath = $ARGV[3];
$SrcFilesList = "srcfiles.list";
$find = "/usr/bin/find";
############################################
# --- file stat operator values ---
$mhour="0.0416";
$timeFC = $mhour * $hourz;
# --- time sets ---
$timeoffset = 0;
($sec, $min, $hour, $mday, $mon, $year, $wday, $yday, $isdst) = localtime(time + (3600*$timeoffset));
$year = $year + 1900;
$mon=$mon+1;

$timeStamp = strftime("%H-%M.%d-%m-%Y", localtime);

# --- pack name ---
$packfile="$tarname.$timeStamp.tar";
# --- get list of files and dirs ---
system "$find $SrcPath -type f > $DestPath/$SrcFilesList";

open(SRCFILES, "$DestPath/$SrcFilesList");
@SrcFilesArray = <SRCFILES>;
close(SRCFILES);

$cntVal = 0;

foreach $sfile (@SrcFilesArray) {
	chomp($sfile);
	if (-M "$sfile" < $timeFC) {
		if ($cntVal == 0) {
			system "/usr/bin/tar -cf $DestPath/$packfile \"$sfile\"";
		}
		if ($cntVal > 0) {
			system "/usr/bin/tar -rf $DestPath/$packfile \"$sfile\"";
		}
		$cntVal++;
	}
}

# ---compress package ---
if ($cntVal > 0) {
	system "/usr/bin/gzip -9 $DestPath/$packfile";
}
# --- clean up ---
system "/bin/rm -f $DestPath/$SrcFilesList";
