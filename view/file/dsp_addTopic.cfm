<cfinclude template = "../layout/dsp_top.cfm">

<main class="container">
    <h2>Add a topic</h2>
    <form method="post" action="/cfcs/file.cfc?method=addTopic">
        <label for="title">Topic name</label></br>
        <input id="title" name="title" type="text" />
        <br /><br />

        <input type="submit" value="submit" />
    </form>
</main>
<cfinclude template = "../layout/dsp_bottom.cfm">