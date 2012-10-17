#!/usr/bin/perl
use POSIX qw(strftime);
use Time::Local;
######################### CONFIG ###############################
### date stamp
$dateStamp = strftime("%d-%m-%Y", localtime);
### mysql binaries
$mySQLshow = "/usr/local/bin/mysqlshow";
$SQLdump = "/usr/local/bin/mysqldump";
### backup path
$SQLback = "/home/backup/sql/mysql/";
### pack binaries
$rm = "/bin/rm";
$tar = "/usr/bin/tar";
$zip = "/usr/bin/bzip2";
### db login data
$DBuser="root";
$DBpass="pipa";
### pack name
$tarFname = "sqlbackup";
################################################################
open (DBZ, "$mySQLshow|");      @dbz = <DBZ>;   close (DBZ);
$dbz[0] = "";   $dbz[1] = "";

$cnt2 = 4;
while ($cnt2 < @dbz) {
        @dbParse = split (/(.*?)\|(.*?)\|(.*?)/, $dbz[$cnt2-1], 3);;
        $dbParse[2] =~ s/^\s+|\s+$//g;
        if ($dbParse[2] ne "") {
                $database = $dbParse[2];
                $fname = "$SQLback" . "$database." . "$dateStamp" . ".sql";
                system "$SQLdump --password=$DBpass -u $DBuser $database > $fname";
        }
        $cnt2++;
}
$fname2 = "$SQLback" . "$tarFname." . "$dateStamp" . ".tar";
system "$tar -cf $fname2 $SQLback" . "*.sql";
system "$rm -f $SQLback" . "*.sql";
system "$zip -9 $fname2";

