Description
===========
Add opscode repository and Install chef-server.

Requirements
============
* cookbook[apt] from opscode
* git-core
* chef-solo or [https://github.com/higanworks/chef-with-ruby_precise-x86_64](https://github.com/higanworks/chef-with-ruby_precise-x86_64)

Attributes
==========

None

Usage
=====

### Recipe::default

Run with opscode apt cookbook.

<pre><code>{
   "run_list" : [
      "recipe[apt]",
      "recipe[bootstrap-chefserver]"
   ]
}</code></pre>

### Recipe::maintance

This recipe exec couchdb compact job for all namespace.

<pre><code>{
   "run_list" : [
      "recipe[bootstrap-chefserver::maintenance]"
   ]
}</code></pre>

