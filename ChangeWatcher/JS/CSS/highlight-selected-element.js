var style  = document.createElement("style");
style.innerHTML = ".any-update-selected {position:relative !important} .any-update-selected:after { content: '';display: block;position: absolute;top: -5px;bottom: -5px;left: -5px;right: -5px;border-radius: 5px;border: 1px solid red;z-index:999} .bordered{outline: solid 1px red;outline-offset: 3px}";

var header = document.getElementsByTagName("HEAD")[0];
header.appendChild(style);
