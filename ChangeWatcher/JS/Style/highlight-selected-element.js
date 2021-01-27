var style  = document.createElement("style");
//style.innerHTML = ".watch-element {position:relative !important} .watch-element:after { content: '';display: block;position: absolute;top: -5px;bottom: -5px;left: -5px;right: -5px;border-radius: 5px;border: 1px solid red;z-index:999} .bordered{outline: solid 1px red;outline-offset: 3px}";
style.innerHTML = ".watch-element {background-color: silver;box-shadow: 1px 1px 0 5px silver, -1px -1px 0 5px silver, 1px -1px 0 5px silver, -1px 1px 0 5px silver;}";

var header = document.getElementsByTagName("HEAD")[0];
header.appendChild(style);
 
