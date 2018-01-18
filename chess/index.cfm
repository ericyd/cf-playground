<cfset page.header = "Chess clone">
<cfinclude template = "../view/layout/dsp_top.cfm">


<main class="main container">
	from <a href="http://react-dnd.github.io/react-dnd/docs-tutorial.html">http://react-dnd.github.io/react-dnd/docs-tutorial.html</a>
    <div id="root" style="height: 500px; width: 500px"></div>
</main>

<script src="../assets/js/chess/manifest-bundle.js"></script>
<script src="../assets/js/chess/react-build-bundle.js"></script>
<script src="../assets/js/chess/main-bundle.js"></script>
<cfinclude template = "../view/layout/dsp_bottom.cfm">

