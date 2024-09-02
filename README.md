# CrontabParse

A simple command line application that parses a crontab and renders explicitely each parts in a table

## instalation

```
bundle install
```

## run the specs

```
bundle exec rspec
```

## try it out

```
./exe/crontab_parse "*/15 0 1,15 * 1-5 /usr/bin/find"
```

```
minute       0 15 30 45
hour         0
day of month 1 15
month        1 2 3 4 5 6 7 8 9 10 11 12
day of week  1 2 3 4 5
command      /usr/bin/find
```
