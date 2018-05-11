vagrant-norequiretty
====================

[![Build Status](https://travis-ci.org/oscar-stack/vagrant-norequiretty.svg?branch=master)](https://travis-ci.org/oscar-stack/vagrant-norequiretty)

A Vagrant plugin that disables `requiretty` on Linux guests. We've all seen it
before. The dreaded "you must have a tty to run sudo" error:

```
The following SSH command responded with a non-zero exit status.
Vagrant assumes that this means the command failed!

Stderr from the command:

sudo: sorry, you must have a tty to run sudo
```

Simply install this plugin and it will attempt to make that error disappear by
hooking into the Vagrant startup sequence and sanitizing `/etc/sudoers` before
other commands run.

To install, simply run:

    vagrant plugin install vagrant-norequiretty

Everything else should start happening automagically™.

Synopsis
========

This error is caused by many VM templates and default installations requiring
a TTY to use `sudo` due to concerns about echoing plaintext passwords in the
clear. For many cases,
[this requirement is questionable](https://bugzilla.redhat.com/show_bug.cgi?id=1020147):

> Well, I know how to work around this.
>
> But nobody has yet explained why I have to.
>
> The problem is not that it's annoying, the problem is that it's annoying for no value.  The case that it was supposed to handle is handled just fine without it.
>
> So let me re-state the cons of this:
>
> 1) it adds no security
> 2) it breaks valid usage
> 3) it diverges from the upstream
>
> I see no pros.  Do you?

This Vagrant plugin hooks into startup actions for VirtualBox, vSphere, VMware
Desktop, and OpenStack providers by running a `sed` command to purge the
`requiretty` setting from `/etc/sudoers` before provisioners, synced folders
and networking actions are executed.

Support for additional providers coming soon.
