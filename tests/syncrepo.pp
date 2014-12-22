
reposync::syncrepo{'test-repo':
	ensure => present,
	target => '/tmp/repos/test-repo'
}