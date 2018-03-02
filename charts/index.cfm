<cfset page.header = "Weather chart(s)!">
<cfinclude template = "../view/layout/dsp_top.cfm">

<!--- This is overkill for a <1 sec load time --->
<!--- <div class="overlay" id="overlay" style="display:none">
    <div class="overlay--backdrop"></div>
    <div class="overlay--item">
        <cfinclude template = "/icons/spinner.cfm">
    </div>
</div> --->

<!--- 
This is just for testing
<span style="font-size: 5em;">
<cfinclude template = "/icons/spinner.cfm">
</span> 
--->

<main class="main container">
    <h2>
        <span id="cityName">Portland, US</span><span id="spinner"><cfinclude template = "/icons/spinner.cfm"></span>&nbsp;
        <form id="zipForm" class="inline-form">
            <span id="zipCode" data-raw="97205" data-editable>97205</span>
            <button class="saveFile btn--icon" type="submit">
                <cfinclude template = "/icons/iconmonstr-save-2.svg">
            </button>
        </form>
        <button class="editFile btn--icon">
            <cfinclude template = "/icons/iconmonstr-edit-6.svg">
        </button>
    </h2>
    <h3>Current weather: <span id="currentWeather">?</span></h3>
    <h3>Forecast:</h3>
    <div id="chart"></div>
</main>


<cfinclude template = "../view/layout/dsp_bottom.cfm">

