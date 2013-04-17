iJSONBenchmark
==============

Overview
--------

JSON Persers Information
--------

<a href="https://github.com/amamchur/jsonlite">JsonLite Objective-C</a> - stream parser based on jsonlite tokenizer.

<a href="https://github.com/gabriel/yajl-objc">YAJL Framework</a> - stream parser based on YAJL tokenizer.

<a href="https://github.com/johnezang/JSONKit">JSONKit</a> - recursion based parser.

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
        <td><a href="https://github.com/amamchur/iJSONBenchmark/blob/master/payload/nested.json">nested.json</a></td>
        <td><a href="https://github.com/chadaustin/Web-Benchmarks/tree/master/json/testdata">Web-Benchmarks</a></td>
        <td>Nested array stress test</td>
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

<table>
    <tr>
        <th>File Name</th>
        <th>JsonLite</th>
        <th>YALJ</th>
        <th>JSONKit</th>
    </tr>
    <tr>
        <td><a href="https://github.com/amamchur/iJSONBenchmark/blob/master/payload/apache_builds.json">apache_builds.json</a></td>
        <td>✔</td>
        <td>✔</td>
        <td>✔</td>
    </tr>
    <tr>
        <td><a href="https://github.com/amamchur/iJSONBenchmark/blob/master/payload/github_events.json">github_events.json</a></td>
        <td>✔</td>
        <td>✔</td>
        <td>✔</td>
    </tr>
    <tr>
        <td><a href="https://github.com/amamchur/iJSONBenchmark/blob/master/payload/instruments.json">instruments.json</a></td>
        <td>✔</td>
        <td>✔</td>
        <td>✔</td>
    </tr>
    <tr>
        <td><a href="https://github.com/amamchur/iJSONBenchmark/blob/master/payload/mesh.json">mesh.json</a></td>
        <td>✔</td>
        <td>✔</td>
        <td>✔</td>
    </tr>
    <tr>
        <td><a href="https://github.com/amamchur/iJSONBenchmark/blob/master/payload/mesh.pretty.json">mesh.pretty.json</a></td>
        <td>✔</td>
        <td>✔</td>
        <td>✔</td>
    </tr>
    <tr>
        <td><a href="https://github.com/amamchur/iJSONBenchmark/blob/master/payload/nested.json">nested.json</a></td>
        <td>✔</td>
        <td>✔</td>
        <td>✔</td>
    </tr>
    <tr>
        <td><a href="https://github.com/amamchur/iJSONBenchmark/blob/master/payload/truenull.json">truenull.json</a></td>
        <td>✔</td>
        <td>✔</td>
        <td>✔</td>
    </tr>
    <tr>
        <td><a href="https://github.com/amamchur/iJSONBenchmark/blob/master/payload/update-center.json">update-center.json</a></td>
        <td>✔</td>
        <td>✔</td>
        <td>✔</td>
    </tr>
    <tr>
        <td><a href="https://github.com/amamchur/iJSONBenchmark/blob/master/payload/random.json">random.json</a></td>
        <td>✔</td>
        <td>✔</td>
        <td>✔</td>
    </tr>
    <tr>
        <td><a href="https://github.com/amamchur/iJSONBenchmark/blob/master/payload/repeat.json">repeat.json</a></td>
        <td>✔</td>
        <td>✔</td>
        <td>✔</td>
    </tr>
    <tr>
        <td><a href="https://github.com/amamchur/iJSONBenchmark/blob/master/payload/twitter_timeline.json">twitter_timeline.json</a></td>
        <td>✔</td>
        <td>✔</td>
        <td>✔</td>
    </tr>
    <tr>
        <td><a href="https://github.com/amamchur/iJSONBenchmark/blob/master/payload/sample.json">sample.json</a></td>
        <td>✔</td>
        <td>✔</td>
        <td>Fail</td>
    </tr>
</table>

