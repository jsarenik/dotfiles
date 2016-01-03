#!/bin/sh
nc ipv4.test-ipv6.com 79 | grep -Eo '[\.0-9]+$'
