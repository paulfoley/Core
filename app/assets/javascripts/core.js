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

function reportSwitch(button) {
    
    $(button).css("filter","grayscale(0%)");
    $(button).css("-webkit-filter","grayscale(0%)");
    $(button).css("background-size","100%");
    $(".r_button").each(function() {
        if(this != button) {
            $(this).css("filter","grayscale(100%)");
            $(this).css("-webkit-filter","grayscale(100%)");
            $(this).css("background-size","90%");
        }
    });
    $(".r_app_pane").each(function() {
        if(this.id.replace("_pane","") != button.id) {
            $(this).removeClass("show");
        }
    });
    $(document.getElementById(button.id+"_pane")).addClass("show");
    
        
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

    //if login page
    if(!!document.getElementById("login")) {
        var view = getQueryVariable("view");
        
        //hack to get login and signup transitions working properly
        $('#login').css("display","block");
        $('#signup').css("display","none");
        $('#pw').css("display","none")
        
        if(!!document.getElementsByClassName("notice")[0]) {
            setTimeout(function(){
                document.getElementsByClassName("notice")[0].style.opacity = 0;
            }, 5000);
        }
        document.getElementById("signup_button").addEventListener("click", function() {
            $('#login').removeClass("show");
             setTimeout(function(){
                $('#login').css("display","none");
                $('#signup').css("display","block");
                $('#signup').addClass("show");
            }, 200);
            
        });
        document.getElementById("forgot_pw").addEventListener("click", function() {
            $('#login').removeClass("show");
             setTimeout(function(){
                $('#login').css("display","none");
                $('#pw').css("display","block");
                $('#pw').addClass("show");
            }, 200);
            
        });
        $('.back').each(function() {
            this.addEventListener("click", function() {
                var grandparent = this.parentElement.parentElement;
                $(grandparent).removeClass("show");
                 setTimeout(function(){
                    $(grandparent).css("display","none");
                    $('#login').css("display","block");
                    $('#login').addClass("show");
                }, 200);
            });
        });
        
    }


    else if(!!document.getElementsByClassName("setup_container")[0]) {
        $('.app_button').each(function() {
            this.addEventListener('click', function() {
                window.location = "/elements/show/?app_name=" + this.id;
            });
        });
    }

    //if main page
    else if(!!document.getElementById("container")) {
        //global variables
        //view switches controlled via buttons
        active = $('.selected');
        document.getElementById(active[0].id.replace("_button", "")).style.opacity = 1;
        document.getElementById(active[0].id.replace("_button", "")).style.zIndex = 2;
    
        //menu button transitions
        $(".menu_button").each(function() {
            this.addEventListener("click", function() {
                contextSwitch($(this));
            });
        });
        //reports button transitions
        $(".r_button").each(function() {
            this.addEventListener("click", function() {
                reportSwitch(this);
            });
        });

        $('.app_button').each(function() {
            this.addEventListener('click', function() {
                window.location = "/elements/show/?app_name=" + this.id;
            });
        });
        //load app icons/URLs
        //this requires each field in JSON be titled the same as the corresponding DOM element
        appsObject = $.getJSON("/apps.json", function() {
            $('.app_button').each(function() {
                //$('#s_marketing')[0].style.backgroundImage = " url(' " + appsObject.responseJSON.marketing.appIcon + " ') ";
                var first = "$('#" + this.id + "')[0].style.backgroundImage = ";
                var second = '"' + "url('" + '"' + "+ appsObject.responseJSON." + this.id.replace("a_","") + ".appIcon + " + '"' + "')" + '"';
                eval(first+second);
            });
        });
    
    }

});