spend1();
function spend1() {
    var days = document.createElement("INPUT");
    days.setAttribute("type", "text"); 
    var days_info = document.createElement("h8");
    days_info.innerHTML = "how many days till it unlocks: ";
    document.body.appendChild(days_info);
    document.body.appendChild(days);
    
    var spend_fee = document.createElement("INPUT");
    spend_fee.setAttribute("type", "text"); 
    var fee_info = document.createElement("h8");
    fee_info.innerHTML = "put an unsigned transaction here: ";
    document.body.appendChild(fee_info);
    document.body.appendChild(spend_fee);
    
    var spend_button = document.createElement("BUTTON");
    spend_button.id = "spend_button";
    var spend_button_text = document.createTextNode("spend");
    spend_button.appendChild(spend_button_text);
    spend_button.onclick = function() {
	//var fee = parseInt(spend_fee.value, 16);
	//local_get(["doit", fee]);
	//console.log(spend_fee.value);
	var ds = parseInt(days.value, 10);
	variable_get([spend_fee.value, ds], doit2);
	//console.log(ABC.value);
    };
    document.body.appendChild(spend_button);

}

function doit2(X) {
    //console.log(atob(X));
    var new_info = document.createElement("h8");
    new_info.innerHTML = atob(X);
    document.body.appendChild(new_info);
    document.body.appendChild(document.createElement("br"));
    //document.body.appendChild(atob(X));
}
