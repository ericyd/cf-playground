component {
    private struct function fileTreeReducer(struct all, struct item, number i) {
        all[item.id] = {
            "id": item.id,
            "title": item.title,
            "parentID": item.parent_ID,
            "children": queryReduce(application.file.getFiles(item.id), fileTreeReducer)
        };
        return all
    }

    // can access via /cfcs/apitest.cfc?method=listFiles
    // if the returnformat="JSON" is left off of the function definition, you can access it manually like so:
    // http://localhost:8888/api/test.cfc?method=listFiles&returnformat=json
    remote struct function listFiles(string extra = "test") /* returnformat="JSON" */ {
        return queryReduce(application.file.getFiles(), fileTreeReducer);
    }
}
