// June 2014 - Brayden.Lopez@canyonsdistrict.org //

if (typeof String.prototype.contains === 'undefined') {   String.prototype.contains = function(it) { return this.indexOf(it) != -1; }; }
if (typeof String.prototype.containsIgnoreCase === 'undefined') {   String.prototype.containsIgnoreCase = function(it) { return this.toLowerCase().indexOf(it.toLowerCase()) != -1; }; }

jQuery(function($) {
	$("[title]").tooltip();
	$("table.table-responsive").each(function() {
		var randomID = makeid();
		if ($(this).attr("id") == "" )
			$(this).attr("id", randomID);
		randomID = $(this).attr("id");
		
        var headers = [];
        $(this).find("th").each(function () {
            headers.push($(this).text().trim());
        });

        // Generate CSS string
        var css_str = "<style>@media only screen and (max-width: 760px), (min-device-width: 768px) and (max-device-width: 1024px) { ";
        var header, num;
        for (var i in headers) {
          header = headers[i].replace(/([\\"])/g, "\\$1").replace(/\n/g, " ");
          num = parseInt(i,10)+1;
          css_str += "#" + randomID + ".table-responsive td:nth-of-type("+num+"):before { content: \""+header+"\"; font-weight:bold;}" + "\n";
        }
        css_str += " }</style>";
        $(css_str).appendTo("head");
    });
});



function makeid()
{
    var text = "";
    var possible = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";

    for( var i=0; i < 5; i++ )
        text += possible.charAt(Math.floor(Math.random() * possible.length));

    return text;
}

function coldfusionJsonToNormalJson(jayson) {
	if(typeof jayson === "string") {
		jayson = jayson.trim();
		jayson = JSON.parse(jayson);
	}

	var arr = new Array();
	
	for(var row = 0; row < jayson.DATA.length; row++) { 
		var entry = {};
		for(var i = 0; i < jayson.COLUMNS.length; i++) 
			entry[jayson.COLUMNS[i]] = jayson.DATA[row][i];
		arr.push(entry);
	}
	
	return arr;
}