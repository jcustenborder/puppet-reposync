define reposync::syncrepo($target, $day=absent, $hour='8', $minute='0', $ensure='present', $user='root') {
	include ::reposync	
	validate_absolute_path($target)

	$cron_name   = "reposync-${name}"
	$log_path    = "${::reposync::log_directory}/reposync-${name}.log"
	$script_path = "${::reposync::log_directory}/reposync-${name}.sh"

	case $ensure {
		'present': {
			file{$script_path:
				ensure  => present,
				mode    => '0755',
				content => 
"#This file is managed by puppet.
/usr/bin/flock -x '${target}' /usr/bin/reposync -r '${name}' -p '${target}' > '${log_path}'
/usr/bin/flock -x '${target}' /usr/bin/createrepo '${target}' >> '${log_path}'
"				
			}

			cron{$cron_name:
				ensure  => present,
				command => $script_path,
				user    => $user,
				day     => $day,
				hour    => $hour,
				minute  => $minute
			}

		}
		'absent': {
			cron{$cron_name:
				ensure => absent
			}
			file{$script_path:
				ensure => absent
			}
		}
	} 


}