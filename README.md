[![Build Status](https://travis-ci.org/evansolomon/sparkfile.png?branch=master)](https://travis-ci.org/evansolomon/sparkfile)

# Spark File

A command line tool for tracking thoughts and ideas.  Inspired by [The Spark File](https://medium.com/the-writers-room/8d6e7df7ae58).

## Installation

`npm install sparkfile -g`

## Usage

```shell
sparkfile Harvard, Yale, Princeton, Cornell, Switzerland... he was thrown out of a lot of colleges.
sparkfile I should invent time travel
# wait a day...
sparkfile Inventing time travel turned out harder than expected
```

That will produce something like this:

```shell
$ cat ~/.sparkfile

[2013-06-30]
- Harvard, Yale, Princeton, Cornell, Switzerland... he was thrown out of a lot of colleges.
- I should invent time travel
[2013-07-01]
- Inventing time travel turned out harder than expected
```

I wanted my file synced in Dropbox and I wanted a shorter command, so I made this alias in my shell config.

`alias s="sparkfile --location ~/Dropbox/Sparkfile"`
