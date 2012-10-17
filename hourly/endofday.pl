#!/usr/bin/perl
# --- cleanup & move backup packs to apropriate place
system "/bin/rm -f /home/backup/hourly_yesterday/*";
system "/bin/mv -f /home/backup/hourly/* /home/backup/hourly_yesterday/";

