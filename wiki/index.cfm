<cfset page.header = "Documentation place">
<cfinclude template = "../view/layout/dsp_top.cfm">

<div class="container">
	<a href="/view/file/dsp_addTopic.cfm">Add topic</a><br/>
</div>

<main class="main--flex container">

	<cfinclude template = "../view/file/dsp_side.cfm">


	<!--- this is from the pre-ajax layout --->
	<!--- <cfif url.fileID eq 0>
		<cfoutput>
			<section class="doc-preview">
				<h2>Hi there!  Please select a topic from the left.</h2>
			</section>
		</cfoutput>
	<cfelse>
		<cfinclude template = "view/layout/dsp_main.cfm">
	</cfif> --->
	<div id="file">
		<section class="doc-preview">
			<h2>Hi there!  Please select a topic from the left.</h2>
		</section>
	</div>
</main>

<cfinclude template = "../view/layout/dsp_bottom.cfm">