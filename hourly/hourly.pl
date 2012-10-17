#!/usr/bin/perl
# --- autosave exta & costomers projects
system "/home/backup/bin/hourly/asave.pl 1 exta-prj /home/backup/hourly /home/projects/exta";
system "/home/backup/bin/hourly/asave.pl 1 cust-prj /home/backup/hourly /home/projects/customers";

