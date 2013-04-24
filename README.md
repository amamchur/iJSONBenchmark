iJSONBenchmark
==============

Overview
--------

JSON Parsers
--------

<a href="https://github.com/johnezang/JSONKit">JSONKit</a> (Commit 82157634ca0ca5b6a4a67a194dd11f15d9b72835)

<a href="https://github.com/amamchur/jsonlite">JsonLite Objective-C</a> (Commit 7a9a73eb740fa8e8679e4c10b0fd211b48dd1ba3)

<a href="http://developer.apple.com/library/ios/#documentation/Foundation/Reference/NSJSONSerialization_Class/Reference/Reference.html">NSJSONSerialization</a>

<a href="https://github.com/stig/json-framework">SBJson</a> (Commit ad4bad36abb899b53a8eb9c0896f388ea484fbeb)

<a href="https://github.com/gabriel/yajl-objc">YAJL Framework</a> (Commit 29c91797005ce0c7eb914333662c5ce3721347af)


Payload Information
--------
<table>
    <tr>
        <th>File Name</th>
        <th>Source</th>
        <th>Description</th>
    </tr>
    <tr>
        <td><a href="https://github.com/amamchur/iJSONBenchmark/blob/master/payload/apache_builds.json">apache_builds.json</a></td>
        <td><a href="https://github.com/chadaustin/Web-Benchmarks/tree/master/json/testdata">Web-Benchmarks</a></td>
        <td>A lot of duplicated key and values</td>
    </tr>
    <tr>
        <td><a href="https://github.com/amamchur/iJSONBenchmark/blob/master/payload/github_events.json">github_events.json</a></td>
        <td><a href="https://github.com/chadaustin/Web-Benchmarks/tree/master/json/testdata">Web-Benchmarks</a></td>
        <td>Why not? We like GitHub</td>
    </tr>
    <tr>
        <td><a href="https://github.com/amamchur/iJSONBenchmark/blob/master/payload/instruments.json">instruments.json</a></td>
        <td><a href="https://github.com/chadaustin/Web-Benchmarks/tree/master/json/testdata">Web-Benchmarks</a></td>
        <td>A lot of duplicated key and number tokens</td>
    </tr>
    <tr>
        <td><a href="https://github.com/amamchur/iJSONBenchmark/blob/master/payload/mesh.json">mesh.json</a></td>
        <td><a href="https://github.com/chadaustin/Web-Benchmarks/tree/master/json/testdata">Web-Benchmarks</a></td>
        <td>Number token stress test</td>
    </tr>
    <tr>
        <td><a href="https://github.com/amamchur/iJSONBenchmark/blob/master/payload/mesh.pretty.json">mesh.pretty.json</a></td>
        <td><a href="https://github.com/chadaustin/Web-Benchmarks/tree/master/json/testdata">Web-Benchmarks</a></td>
        <td>Number token stress test + formatting (good to measure whitespace skipping)</td>
    </tr>
    <tr>
        <td><a href="https://github.com/amamchur/iJSONBenchmark/blob/master/payload/truenull.json">truenull.json</a></td>
        <td><a href="https://github.com/chadaustin/Web-Benchmarks/tree/master/json/testdata">Web-Benchmarks</a></td>
        <td>Null and true token stress test</td>
    </tr>
    <tr>
        <td><a href="https://github.com/amamchur/iJSONBenchmark/blob/master/payload/update-center.json">update-center.json</a></td>
        <td><a href="https://github.com/chadaustin/Web-Benchmarks/tree/master/json/testdata">Web-Benchmarks</a></td>
        <td>A lot of duplicated key and different string tokens</td>
    </tr>
    <tr>
        <td><a href="https://github.com/amamchur/iJSONBenchmark/blob/master/payload/random.json">random.json</a></td>
        <td><a href="https://github.com/bontoJR/iOS-JSON-Performance/tree/master/JSONlibs">iOS-JSON-Performance</a></td>
        <td>A lot of duplicated key; different values</td>
    </tr>
    <tr>
        <td><a href="https://github.com/amamchur/iJSONBenchmark/blob/master/payload/repeat.json">repeat.json</a></td>
        <td><a href="https://github.com/bontoJR/iOS-JSON-Performance/tree/master/JSONlibs">iOS-JSON-Performance</a></td>
        <td>Different values</td>
    </tr>
    <tr>
        <td><a href="https://github.com/amamchur/iJSONBenchmark/blob/master/payload/twitter_timeline.json">twitter_timeline.json</a></td>
        <td><a href="https://github.com/bontoJR/iOS-JSON-Performance/tree/master/JSONlibs">iOS-JSON-Performance</a></td>
        <td>De facto standart JSON benchmark payload</td>
    </tr>
    <tr>
        <td><a href="https://github.com/amamchur/iJSONBenchmark/blob/master/payload/sample.json">sample.json</a></td>
        <td><a href="https://code.google.com/p/json-test-suite/downloads/list">json-test-suite</a></td>
        <td>UNICODE stress test</td>
    </tr>
</table>

Payload Passing
--------

Tests were performed on Core i5 arch i386

<table>
    <tr>
        <th>File Name</th>
        <th>JSONKit</th>
        <th>JsonLite</th>
        <th>NSJSONSerialization</th>
        <th>SBJson</th>
        <th>YAJL</th>
    </tr>
    <tr>
        <td><a href="https://github.com/amamchur/iJSONBenchmark/blob/master/payload/apache_builds.json">apache_builds.json</a></td>
        <td>✔</td>
        <td>✔</td>
        <td>✔</td>
        <td>✔</td>
        <td>✔</td>
    </tr>
    <tr>
        <td><a href="https://github.com/amamchur/iJSONBenchmark/blob/master/payload/github_events.json">github_events.json</a></td>
        <td>✔</td>
        <td>✔</td>
        <td>✔</td>
        <td>✔</td>
        <td>✔</td>
    </tr>
    <tr>
        <td><a href="https://github.com/amamchur/iJSONBenchmark/blob/master/payload/instruments.json">instruments.json</a></td>
        <td>✔</td>
        <td>✔</td>
        <td>✔</td>
        <td>✔</td>
        <td>✔</td>
    </tr>
    <tr>
        <td><a href="https://github.com/amamchur/iJSONBenchmark/blob/master/payload/mesh.json">mesh.json</a></td>
        <td>✔</td>
        <td>✔</td>
        <td>✔</td>
        <td>✔</td>
        <td>✔</td>
    </tr>
    <tr>
        <td><a href="https://github.com/amamchur/iJSONBenchmark/blob/master/payload/mesh.pretty.json">mesh.pretty.json</a></td>
        <td>✔</td>
        <td>✔</td>
        <td>✔</td>
        <td>✔</td>
        <td>✔</td>
    </tr>
    <tr>
        <td><a href="https://github.com/amamchur/iJSONBenchmark/blob/master/payload/truenull.json">truenull.json</a></td>
        <td>✔</td>
        <td>✔</td>
        <td>✔</td>
        <td>✔</td>
        <td>✔</td>
    </tr>
    <tr>
        <td><a href="https://github.com/amamchur/iJSONBenchmark/blob/master/payload/update-center.json">update-center.json</a></td>
        <td>✔</td>
        <td>✔</td>
        <td>✔</td>
        <td>✔</td>
        <td>✔</td>
    </tr>
    <tr>
        <td><a href="https://github.com/amamchur/iJSONBenchmark/blob/master/payload/random.json">random.json</a></td>
        <td>✔</td>
        <td>✔</td>
        <td>✔</td>
        <td>✔</td>
        <td>✔</td>
    </tr>
    <tr>
        <td><a href="https://github.com/amamchur/iJSONBenchmark/blob/master/payload/repeat.json">repeat.json</a></td>
        <td>✔</td>
        <td>✔</td>
        <td>✔</td>
        <td>✔</td>
        <td>✔</td>
    </tr>
    <tr>
        <td><a href="https://github.com/amamchur/iJSONBenchmark/blob/master/payload/twitter_timeline.json">twitter_timeline.json</a></td>
        <td>✔</td>
        <td>✔</td>
        <td>✔</td>
        <td>✔</td>
        <td>✔</td>
    </tr>
    <tr>
        <td><a href="https://github.com/amamchur/iJSONBenchmark/blob/master/payload/sample.json">sample.json</a></td>
        <td>Fail</td>
        <td>✔</td>
        <td>✔</td>
        <td>✔</td>
        <td>✔</td>
    </tr>
</table>

Memory Leaks Test
--------

Tests were performed on Core i5 arch i386

<table>
    <tr>
        <th>File Name</th>
        <th>JSONKit</th>
        <th>JsonLite</th>
        <th>NSJSONSerialization</th>
        <th>SBJson</th>
        <th>YAJL</th>
    </tr>
    <tr>
        <td><a href="https://github.com/amamchur/iJSONBenchmark/blob/master/payload/apache_builds.json">apache_builds.json</a></td>
        <td>✔</td>
        <td>✔</td>
        <td>✔</td>
        <td>✔</td>
        <td>✔</td>
    </tr>
    <tr>
        <td><a href="https://github.com/amamchur/iJSONBenchmark/blob/master/payload/github_events.json">github_events.json</a></td>
        <td>✔</td>
        <td>✔</td>
        <td>✔</td>
        <td>✔</td>
        <td>✔</td>
    </tr>
    <tr>
        <td><a href="https://github.com/amamchur/iJSONBenchmark/blob/master/payload/instruments.json">instruments.json</a></td>
        <td>✔</td>
        <td>✔</td>
        <td>✔</td>
        <td>✔</td>
        <td>✔</td>
    </tr>
    <tr>
        <td><a href="https://github.com/amamchur/iJSONBenchmark/blob/master/payload/mesh.json">mesh.json</a></td>
        <td>✔</td>
        <td>✔</td>
        <td>✔</td>
        <td>✔</td>
        <td>✔</td>
    </tr>
    <tr>
        <td><a href="https://github.com/amamchur/iJSONBenchmark/blob/master/payload/mesh.pretty.json">mesh.pretty.json</a></td>
        <td>✔</td>
        <td>✔</td>
        <td>✔</td>
        <td>✔</td>
        <td>✔</td>
    </tr>
    <tr>
        <td><a href="https://github.com/amamchur/iJSONBenchmark/blob/master/payload/truenull.json">truenull.json</a></td>
        <td>✔</td>
        <td>✔</td>
        <td>✔</td>
        <td>✔</td>
        <td>✔</td>
    </tr>
    <tr>
        <td><a href="https://github.com/amamchur/iJSONBenchmark/blob/master/payload/update-center.json">update-center.json</a></td>
        <td>✔</td>
        <td>✔</td>
        <td>✔</td>
        <td>✔</td>
        <td>✔</td>
    </tr>
    <tr>
        <td><a href="https://github.com/amamchur/iJSONBenchmark/blob/master/payload/random.json">random.json</a></td>
        <td>✔</td>
        <td>✔</td>
        <td>✔</td>
        <td>✔</td>
        <td>✔</td>
    </tr>
    <tr>
        <td><a href="https://github.com/amamchur/iJSONBenchmark/blob/master/payload/repeat.json">repeat.json</a></td>
        <td>✔</td>
        <td>✔</td>
        <td>✔</td>
        <td>✔</td>
        <td>✔</td>
    </tr>
    <tr>
        <td><a href="https://github.com/amamchur/iJSONBenchmark/blob/master/payload/twitter_timeline.json">twitter_timeline.json</a></td>
        <td>✔</td>
        <td>✔</td>
        <td>✔</td>
        <td>✔</td>
        <td>✔</td>
    </tr>
    <tr>
        <td><a href="https://github.com/amamchur/iJSONBenchmark/blob/master/payload/sample.json">sample.json</a></td>
        <td>N/A</td>
        <td>✔</td>
        <td>✔</td>
        <td>✔</td>
        <td>✔</td>
    </tr>
</table>

Performance Results
--------

Tests were performed on Core i5 arch i386 (less is better).

[Results are available at Google Drive](https://docs.google.com/spreadsheet/ccc?key=0ApjrAc5bvHuhdDhoUlRYcnk4eW1WSzRjRmpxQmhRUlE&usp=sharing)

<img src="https://docs.google.com/spreadsheet/oimg?key=0ApjrAc5bvHuhdDhoUlRYcnk4eW1WSzRjRmpxQmhRUlE&oid=4&zx=6djd9txrlgb4" />

Leaders:

<img src="https://docs.google.com/spreadsheet/oimg?key=0ApjrAc5bvHuhdDhoUlRYcnk4eW1WSzRjRmpxQmhRUlE&oid=3&zx=ihhlsu8wg3v0" />

