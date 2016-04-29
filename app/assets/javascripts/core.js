function contextSwitch(button) {
    if (button.hasClass("selected")) return;
    else {
        /*
         sidebar button selection:
         1. remove .selected from currently active button
         2. hide current pane
         3. add .selected to new button
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
    
    //onclick set all buttons to grayscale except clicked
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
    //switch lists of reports
    $(".r_app_pane").each(function() {
        if(this.id.replace("r_","").replace("_pane","") != button.id) {
            $(this).removeClass("show");
        }
    });
    $(document.getElementById(button.id.replace("r_","") +"_pane")).addClass("show");
    console.log(button.id+"_pane");
    
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

//get "xyz" from "variable=xyz" in URL
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
        
        if(gon.connected_to_salesforce) {
            $('#a_CRM').removeClass('not_connected');
            $('#r_CRM').removeClass('not_connected');
        }
        if(gon.connected_to_quickbooks) {
            $('#a_accounting').removeClass('not_connected');
            $('#r_accounting').removeClass('not_connected');
        }
        if(gon.connected_to_stripe) {
            $('#a_ecommerce').removeClass('not_connected');
            $('#r_ecommerce').removeClass('not_connected');
        }
    
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
            //reroute to callback controller for linking apps
            $('.admin_app_button').each(function() {
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
        //login screen view switching
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
        //reroute for app linking
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
