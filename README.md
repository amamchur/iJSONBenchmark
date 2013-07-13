iJSONBenchmark
==============

Bechnmark for Objective-C JSON parsers.

JSON Parsers
--------

<a href="https://github.com/couchdeveloper/JPJson">JPJson</a> (Commit e4ab587ce26b49a737791767e05cdc44e11f06fe)

<a href="https://github.com/johnezang/JSONKit">JSONKit</a> (Commit 82157634ca0ca5b6a4a67a194dd11f15d9b72835)

<a href="https://github.com/amamchur/jsonlite">JsonLite Objective-C</a> (Commit 43dd5b5888ee54b39cbd7ef27e86cbb5a57cdc90)

<a href="http://developer.apple.com/library/ios/#documentation/Foundation/Reference/NSJSONSerialization_Class/Reference/Reference.html">NSJSONSerialization</a> (iOS 6.1.3)

<a href="https://github.com/stig/json-framework">SBJson</a> (Commit f30481843f7cc49be9b9e8f8fd0fe8f0162c9241)

<a href="https://github.com/gabriel/yajl-objc">YAJL Framework</a> (Commit 51f245719335dcc27434685fcec990de31729412)


Payload Information
-------------------
<table>
    <tr>
        <th>File Name</th>
        <th>Source</th>
    </tr>
    <tr>
        <td><a href="https://github.com/amamchur/iJSONBenchmark/blob/master/payload/apache_builds.json">apache_builds.json</a></td>
        <td><a href="https://github.com/chadaustin/Web-Benchmarks/tree/master/json/testdata">Web-Benchmarks</a></td>
    </tr>
    <tr>
        <td><a href="https://github.com/amamchur/iJSONBenchmark/blob/master/payload/github_events.json">github_events.json</a></td>
        <td><a href="https://github.com/chadaustin/Web-Benchmarks/tree/master/json/testdata">Web-Benchmarks</a></td>
    </tr>
    <tr>
        <td><a href="https://github.com/amamchur/iJSONBenchmark/blob/master/payload/instruments.json">instruments.json</a></td>
        <td><a href="https://github.com/chadaustin/Web-Benchmarks/tree/master/json/testdata">Web-Benchmarks</a></td>
    </tr>
    <tr>
        <td><a href="https://github.com/amamchur/iJSONBenchmark/blob/master/payload/mesh.json">mesh.json</a></td>
        <td><a href="https://github.com/chadaustin/Web-Benchmarks/tree/master/json/testdata">Web-Benchmarks</a></td>
    </tr>
    <tr>
        <td><a href="https://github.com/amamchur/iJSONBenchmark/blob/master/payload/mesh.pretty.json">mesh.pretty.json</a></td>
        <td><a href="https://github.com/chadaustin/Web-Benchmarks/tree/master/json/testdata">Web-Benchmarks</a></td>
    </tr>
    <tr>
        <td><a href="https://github.com/amamchur/iJSONBenchmark/blob/master/payload/truenull.json">truenull.json</a></td>
        <td><a href="https://github.com/chadaustin/Web-Benchmarks/tree/master/json/testdata">Web-Benchmarks</a></td>
    </tr>
    <tr>
        <td><a href="https://github.com/amamchur/iJSONBenchmark/blob/master/payload/update-center.json">update-center.json</a></td>
        <td><a href="https://github.com/chadaustin/Web-Benchmarks/tree/master/json/testdata">Web-Benchmarks</a></td>
    </tr>
    <tr>
        <td><a href="https://github.com/amamchur/iJSONBenchmark/blob/master/payload/random.json">random.json</a></td>
        <td><a href="https://github.com/bontoJR/iOS-JSON-Performance/tree/master/JSONlibs">iOS-JSON-Performance</a></td>
    </tr>
    <tr>
        <td><a href="https://github.com/amamchur/iJSONBenchmark/blob/master/payload/repeat.json">repeat.json</a></td>
        <td><a href="https://github.com/bontoJR/iOS-JSON-Performance/tree/master/JSONlibs">iOS-JSON-Performance</a></td>
    </tr>
    <tr>
        <td><a href="https://github.com/amamchur/iJSONBenchmark/blob/master/payload/twitter_timeline.json">twitter_timeline.json</a></td>
        <td><a href="https://github.com/bontoJR/iOS-JSON-Performance/tree/master/JSONlibs">iOS-JSON-Performance</a></td>
    </tr>
</table>

Benchmark results
------------------

* Device: iPad (4th generation Model A1458)
* OS: 6.1.3 (10B329)
* 50 iterations per payload
* Results provided in nanosec (less is better)
* Charts display average value per payload 
* Other reports can be found [here](https://github.com/amamchur/iJSONBenchmark/tree/master/results)

mesh.json and mesh.pretty.json

![Image](../master/charts/mesh.png?raw=true)

apache_builds.json, github_events.json and twitter_timeline.json

![Image](../master/charts/agt.png?raw=true)

instruments.json, update-center.json and random.json

![Image](../master/charts/iur.png?raw=true)

truenull.json and repeat.json

![Image](../master/charts/tnr.png?raw=true)


