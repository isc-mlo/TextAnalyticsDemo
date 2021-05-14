# TextAnalyticsDemo
Quick demo of using the Azure Text Analytics library using Embedded Python in InterSystems IRIS.

Files in this demo include:

<ul>
	<li>TextAnalyticsDemo.gof: Exported sample responses, in case you don't feel like entering your own</li>
	<li>src/cls/EmbeddedPython.Response.cls: Source code for a class that uses ObjectScript to capture and store responses from the user</li>
	<li>src/cls/EmbeddedPython.Analyzer.cls: Source code for a class that uses Python to analyze responses from the user</li>
</ul>

Setup instructions:

<ul>
	<li>Install a version of InterSystems IRIS with Embedded Python.</li>
	<li>Install the Azure Text Analytics library in your instance: pip install --target <installdir>\mgr\python azure-ai-textanalytics --pre --upgrade</li>
	<li>Ask me for an API key to authenticate with the sample Micrososft Azure resource.</li>
	<li>Add the API key where indicated in method EmbeddedPython.Analyzer.Authenticate().</li>
	<li>Import the classes in this repository into InterSystems IRIS.</li>
	<li>Optionally, import the global with sample data.</li>
	<li>To run the demo: do ##class(EmbeddedPython.Response).Run()</li>
</ul>

Use or operation of this code is subject to acceptance of the license available in the code repository for this code. 

