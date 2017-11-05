<cfparam name="page.header" type="string" default="My app">

<!DOCTYPE html>
<html>
	<head>
		<title>Lucee testing</title>
        <link rel="stylesheet" type="text/css" href="/assets/css/lib/main.css">
		<link rel="stylesheet" type="text/css" href="http://fonts.googleapis.com/css?family=Open+Sans:400,300,600,700,800">

		<!-- global dependencies -->
		<script src="/assets/js/lib/polyfills.js"></script>
		<script src="/assets/js/lib/es6-promise.min.js"></script>
		<script src="/assets/js/lib/es6-promise.auto.min.js"></script>
		<script src="/assets/js/lib/axios.min.js"></script>
		<script src="/assets/js/lib/picoModal-3.0.0.min.js"></script>
		<script src="/assets/js/lib/markdown-it.min.js"></script>
		<script src="/assets/js/lib/main.js"></script>
		<script src="/assets/js/lib/editable.js"></script>

		<cfswitch expression="#page.header#">
			<!--- Wiki dependencies --->
			<cfcase value="Documentation place">
				<script src="/assets/js/lib/wiki.js"></script>
			</cfcase>

			<!--- Weather chart dependencies --->
			<cfcase value="Weather chart(s)!">
				<script src="/assets/js/lib/weather.js"></script>
				<!-- dependencies for charts -->
				<!-- Load c3.css -->
				<link href="/assets/css/c3.min.css" rel="stylesheet">

				<!-- Load d3.js and c3.js -->
				<script src="/assets/js/d3/d3.js" charset="utf-8"></script>
				<script src="/assets/js/c3/c3.js"></script>
			</cfcase>
			<cfdefaultcase></cfdefaultcase>
		</cfswitch>
	</head>
	<body>

	    <cfinclude template = "dsp_header.cfm">