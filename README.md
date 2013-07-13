iJSONBenchmark
==============

JSON Parsers
--------

<a href="https://github.com/couchdeveloper/JPJson">JPJson</a> (Commit e4ab587ce26b49a737791767e05cdc44e11f06fe)

<a href="https://github.com/johnezang/JSONKit">JSONKit</a> (Commit 82157634ca0ca5b6a4a67a194dd11f15d9b72835)

<a href="https://github.com/amamchur/jsonlite">JsonLite Objective-C</a> (Commit 7a9a73eb740fa8e8679e4c10b0fd211b48dd1ba3)

<a href="http://developer.apple.com/library/ios/#documentation/Foundation/Reference/NSJSONSerialization_Class/Reference/Reference.html">NSJSONSerialization</a> (iOS 6.1.3)

<a href="https://github.com/stig/json-framework">SBJson</a> (Commit ad4bad36abb899b53a8eb9c0896f388ea484fbeb)

<a href="https://github.com/gabriel/yajl-objc">YAJL Framework</a> (Commit 29c91797005ce0c7eb914333662c5ce3721347af)


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
* Results provided in nanosec.
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


