function contextSwitch(button) {
    if (button.hasClass("selected")) return;
    else {
        currentMenu.toggleClass("selected");
        button.toggleClass("selected");
        currentMenu = button;
    }
}

//get xyz from "variable=xyz"
function getQueryVariable(variable)
{
   var query = window.location.search.substring(1);
   var vars = query.split("&");
   for (var i=0;i<vars.length;i++) {
       var pair = vars[i].split("=");
       if(pair[0] == variable){return pair[1];}
   }
   return(false);
}

$(document).ready(function() {
    //global variables
    currentMenu = $("#metrics_button");
    currentMenu.addClass("selected");

    //set up menu buttonanimations
    $(".menu_button").each(function() {
        this.addEventListener("click", function() {
            contextSwitch($(this));
        });
    });
    
    //if redirect from oauth page, catch codes
    if(window.location.search.substring(1) != "") {
        var code = getQueryVariable("code");
        console.log("code= " + code);
    }
    
});
