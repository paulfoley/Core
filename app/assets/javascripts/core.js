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
        
        //update URL on view switch
        window.history.pushState(null,null,'/core/run/?view='+button[0].id.replace("_button",""));

        //slide app icons in from top in aesthetic order
        if(active[0].id == "reports_button") {
            var i = 0;
            $('.r_button').each(function() {
                $(this).css("top","150px");
                $(this).css("transition-delay", "0s," + i.toString() + "s");
                i+=0.1;
            });
        }

        //slide app icons out to top in aesthetic order
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
    $(button).css("background-size","100%");
    $(".r_button").each(function() {
        if(this != button) {
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

function openPopup(popup) {
    $('#popup_wrapper').show();
    $('.popup').each(function() {
        $(this).hide();
    });
    $('#' + popup + '_popup').show();
}
function closePopup() {
    $('#popup_wrapper').hide();
}

var inactivity_time = function () {
   var t;
   window.onload = reset_timer;
   //document.addEventListener("mousemove",console.log("BUTTS"));
   //window.addEventListener("keypress",console.log("POOP"));
   $(document).mousemove(console.log("BUTTS"));
   $(document).keypress(console.log("POOP"));

   function logout() {
       stop_timer();
       alert("You have been logged out.");
       window.location = '/welcome#index';
   }

   function reset_timer() {
       t = setTimeout(function(){ logout(); }, 9000000);
   }
   function stop_timer() {
       t = 0;
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
    
    //if main page
    if(!!document.getElementById("main")) {
        
        //log out after x inactivity time
        inactivity_time();
        
        //view switches controlled via buttons
        if(getQueryVariable("view")) {
            $('#' + getQueryVariable('view') + '_button').addClass('selected');
        }
        else $('#metrics_button').addClass('selected');
        
        active = $('.selected');
        //slide in reports buttons if initial screen is reports
        if(active[0] == $('#reports_button')[0]) {
            var i = 0;
            $('.r_button').each(function() {
                $(this).css("top","150px");
                $(this).css("transition-delay", "0s," + i.toString() + "s");
                i+=0.1;
            });
        }
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
        //settings editing
        document.getElementById("edit_settings").addEventListener("click",function() {
            
        });
        //admin page
        if(document.getElementById("admin")) {
            $('.app_button').each(function() {
                this.addEventListener('click', function() {
                    window.location = "/elements/show/?app_name=" + this.id;
                });
            });
            document.getElementById("invite_user").addEventListener("click", function() {
                openPopup('invite');
            });
            document.getElementById("edit_settings").addEventListener("click", function() {
                openPopup('edit');
            });
            $('.cancel').each(function() {
                this.addEventListener("click", function() {
                    closePopup();
                });
            });
        }
    
    }
    
    //if login page
    else if(!!document.getElementById("login")) {
        var view = getQueryVariable("view");
        
        //hack to get login and signup transitions working properly
        $('#login').css("display","block");
        $('#signup').css("display","none");
        $('#pw').css("display","none")
        
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

    //set up page
    else if(!!document.getElementsByClassName("setup_container")[0]) {
        //log out after x inactivity time
        inactivity_time();
        $('.app_button').each(function() {
            this.addEventListener('click', function() {
                window.location = "/elements/show/?app_name=" + this.id;
            });
        });
    }
    
    //fade flash notices
    if(!!document.getElementsByClassName("notice")[0]) {
        setTimeout(function(){
            document.getElementsByClassName("notice")[0].style.opacity = 0;
        }, 5000);
    }

});
