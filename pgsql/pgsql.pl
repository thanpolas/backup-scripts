#!/usr/bin/perl
use POSIX qw(strftime);
use Time::Local;

### date stamp
$dateStamp = strftime("%d-%m-%Y", localtime);

system "/usr/local/bin/pg_dumpall > /home/backup/sql/pgsql/pgsql.$dateStamp.db";
system "/usr/bin/bzip2 -9 /home/backup/sql/pgsql/pgsql.$dateStamp.db";

