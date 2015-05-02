[![Build Status](https://travis-ci.org/itsthejb/NSURL-QueryDictionary.svg?branch=master)](https://travis-ci.org/itsthejb/NSURL-QueryDictionary)
[![Build Status](https://travis-ci.org/itsthejb/NSURL-QueryDictionary.svg?branch=develop)](https://travis-ci.org/itsthejb/NSURL-QueryDictionary)

NSURL-QueryDictionary
=====================

Just some simple `NSURL`, `NSString` and `NSDictionary` categories to make working with URL queries more pleasant.

* `-[NSURL uq_queryDictionary]` extract the URL's query string as key/value pairs.
* `-[NSURL uq_URLByAppendingQueryDictionary:]` append the specified key/value pairs to the URL, with existing query handled. Note that behaviour for overlapping keys/values is undefined.
* `-[NSURL uq_URLByReplacingQueryWithDictionary:]` create a copy of the URL with its query component replaced by that specified in the dictionary.
* `-[NSURL uq_URLByRemovingQuery]` create a copy of the URL with the query component completely removed.

The parsing components of the above are also available separately as:

* `-[NSString uq_URLQueryDictionary]` split a valid query string into key/value pairs.
* `-[NSDictionary uq_URLQueryString]` the reverse of above; create a URL query string from an `NSDictionary` instance.

The methods returning URL instances have `withSortedKeys:` partner methods that sort the dictionary's keys alphabetically with `YES`. This is so as to make the generated URL's string deterministic, with is necessary if you're unit testing URLs created using these methods - at least this was helpful for me!

Queries with empty values are converted to `NSNull` and vice versa as of `v0.0.5`.

##Version history

###v1.1.0

* Now has methods to create URL copies with the query removed, or replaced with a specified query dictionary.

###v1.0.3

Bug fixes courtesy of [Jan Berkel](https://github.com/jberkel), [Elliot Chance](https://github.com/elliotchance) and [Grzegorz Nowicki](https://github.com/wikia-gregor). [1](https://github.com/itsthejb/NSURL-QueryDictionary/pull/6), [2](https://github.com/itsthejb/NSURL-QueryDictionary/pull/7), [3](https://github.com/itsthejb/NSURL-QueryDictionary/pull/5).

###v1.0.2

* Added category prefixes at the suggestion of [Mike Abdullah](https://github.com/mikeabdullah).
* Now compiles for OSX 10.8, with thanks to [Elliot Chance](https://github.com/elliotchance).

###v0.0.7

Fixed a potential issue/static analyser false positive with thanks to [Adam Lickel](https://github.com/lickel).

###v0.0.6

Added optional flag to sort the dictionary's keys alphabetically when generating the URL. This makes the generated URLs more deterministic, which helps (for example) if you are running unit tests to inspect your URLs and would like to test the absolute string, rather than having to recreate a query dictionary.

###v0.0.5

Covered an additional empty value case - URL query component has separator, but empty value.

###v0.0.4

Added handling for keys with no value, empty value or `NSNull`.

###v0.0.3

Split the query string parsing components out into `NSString` and `NSDictionary` categories for additional flexibility.

###v0.0.2

Added support for dictionary keys other than NSString. Currently just uses `-description`, but this is ok for `NSNumber` and `NSDate` and a few others, so may be sufficient.

###v0.0.1

Initial release.

Have fun!
---------

[MIT Licensed](http://jc.mit-license.org/) >> [jon.crooke@gmail.com](mailto:jon.crooke@gmail.com)
