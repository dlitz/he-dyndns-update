#
# Regular cron jobs for the he-dyndns-update package.
#
0 4	* * *	root	[ -x /usr/bin/he-dyndns-update_maintenance ] && /usr/bin/he-dyndns-update_maintenance
