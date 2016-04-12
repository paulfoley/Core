function contextSwitch(button) {
    if (button.hasClass("selected")) return;
    else {
        /*
        sidebar button selection:
        1. remove selected from active
        2. hide pane
        3. add selected to button
        4. show new pane
        5. set active to new button
        */
        active.removeClass("selected");
        document.getElementById(active[0].id.replace("_button", "")).style.opacity = 0;
        document.getElementById(active[0].id.replace("_button", "")).style.zIndex = 0;

        button.addClass("selected");
        document.getElementById(button[0].id.replace("_button", "")).style.opacity = 1;
        document.getElementById(button[0].id.replace("_button", "")).style.zIndex = 2;
        active = button;
        
        //slide app icons in from left in aesthetic order
        if(active[0].id == "reports_button") {
            var i = 0;
            $('.r_button').each(function() {
                $(this).css("top","150px");
                $(this).css("transition-delay", "0s," + i.toString() + "s");
                i+=0.1;
            });
        }
        
        //slide app icons out to left in aesthetic order
        else {
            var i = 0;
            $('.r_button').each(function() {
                $(this).css("top","-150px");
                $(this).css("transition-delay", "0s,0.3s");
            });
        }
        
        
    }
}

//get "xyz" from "variable=xyz"
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
    //view switches controlled via buttons
    active = $('.selected')
    document.getElementById(active[0].id.replace("_button", "")).style.opacity = 1;
    document.getElementById(active[0].id.replace("_button", "")).style.zIndex = 2;

    //set up menu button animations
    $(".menu_button").each(function() {
        this.addEventListener("click", function() {
            contextSwitch($(this));
        });
    });
    //load app icons/URLs
    //this requires each field in JSON be titled the same as the corresponding DOM element
    appsObject = $.getJSON("/core/appdata/apps.json", function() {
        $('.app_button').each(function() {
            if($(this).hasClass("r_button")) {
                eval("$(this).parent()[0].href = appsObject.responseJSON." + this.id + ".oauthURL");
            }
            //$('#s_marketing')[0].style.backgroundImage = " url(' " + appsObject.responseJSON.marketing.appIcon + " ') ";
            var first = "$('#" + this.id + "')[0].style.backgroundImage = ";
            var second = '"' + "url('" + '"' + "+ appsObject.responseJSON." + this.id.replace("a_","") + ".appIcon + " + '"' + "')" + '"';
            eval(first+second);
        });
    });

    
    //if redirect from oauth page, catch codes
    if(window.location.search.substring(1) != "") {
        var code = getQueryVariable("code");
        console.log("code= " + code);
    }
    
});
