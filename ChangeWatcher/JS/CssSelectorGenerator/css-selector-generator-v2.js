 (function(f){if(typeof exports==="object"&&typeof module!=="undefined"){module.exports=f()}else if(typeof define==="function"&&define.amd){define([],f)}else{var g;if(typeof window!=="undefined"){g=window}else if(typeof global!=="undefined"){g=global}else if(typeof self!=="undefined"){g=self}else{g=this}g.CssSelectorGeneratorV2 = f()}})(function(){var define,module,exports;return (function(){function r(e,n,t){function o(i,f){if(!n[i]){if(!e[i]){var c="function"==typeof require&&require;if(!f&&c)return c(i,!0);if(u)return u(i,!0);var a=new Error("Cannot find module '"+i+"'");throw a.code="MODULE_NOT_FOUND",a}var p=n[i]={exports:{}};e[i][0].call(p.exports,function(r){var n=e[i][1][r];return o(n||r)},p,p.exports,r,e,n,t)}return n[i].exports}for(var u="function"==typeof require&&require,i=0;i<t.length;i++)o(t[i]);return o}return r})()({1:[function(require,module,exports){
 "use strict";

 var _cssSelectorGenerator = _interopRequireDefault(require("css-selector-generator"));

 function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { "default": obj }; }

 function getSelector(el) {
     var selector = (0, _cssSelectorGenerator["default"])(el);
     return selector;
 }

 module.exports = {
   getSelector: getSelector
 };

 },{"css-selector-generator":2}],2:[function(require,module,exports){
 !function(t,r){"object"==typeof exports&&"object"==typeof module?module.exports=r():"function"==typeof define&&define.amd?define([],r):"object"==typeof exports?exports.CssSelectorGenerator=r():t.CssSelectorGenerator=r()}(window,(function(){return function(t){var r={};function n(e){if(r[e])return r[e].exports;var o=r[e]={i:e,l:!1,exports:{}};return t[e].call(o.exports,o,o.exports,n),o.l=!0,o.exports}return n.m=t,n.c=r,n.d=function(t,r,e){n.o(t,r)||Object.defineProperty(t,r,{enumerable:!0,get:e})},n.r=function(t){"undefined"!=typeof Symbol&&Symbol.toStringTag&&Object.defineProperty(t,Symbol.toStringTag,{value:"Module"}),Object.defineProperty(t,"__esModule",{value:!0})},n.t=function(t,r){if(1&r&&(t=n(t)),8&r)return t;if(4&r&&"object"==typeof t&&t&&t.__esModule)return t;var e=Object.create(null);if(n.r(e),Object.defineProperty(e,"default",{enumerable:!0,value:t}),2&r&&"string"!=typeof t)for(var o in t)n.d(e,o,function(r){return t[r]}.bind(null,o));return e},n.n=function(t){var r=t&&t.__esModule?function(){return t.default}:function(){return t};return n.d(r,"a",r),r},n.o=function(t,r){return Object.prototype.hasOwnProperty.call(t,r)},n.p="",n(n.s=2)}([function(t,r,n){var e=n(1);function o(t,r,n){Array.isArray(t)?t.push(r):t[n]=r}t.exports=function(t){var r,n,i,u=[];if(Array.isArray(t))n=[],r=t.length-1;else{if("object"!=typeof t||null===t)throw new TypeError("Expecting an Array or an Object, but `"+(null===t?"null":typeof t)+"` provided.");n={},i=Object.keys(t),r=i.length-1}return function n(c,a){var f,l,s;for(l=i?i[a]:a,Array.isArray(t[l])||(void 0===t[l]?t[l]=[]:t[l]=[t[l]]),f=0;f<t[l].length;f++)p=c,o(s=Array.isArray(p)?[].concat(p):e(p),t[l][f],l),a>=r?u.push(s):n(s,a+1);var p}(n,0),u}},function(t,r){t.exports=function(){for(var t={},r=0;r<arguments.length;r++){var e=arguments[r];for(var o in e)n.call(e,o)&&(t[o]=e[o])}return t};var n=Object.prototype.hasOwnProperty},function(t,r,n){"use strict";n.r(r),n.d(r,"getCssSelector",(function(){return k}));var e="function"==typeof Symbol&&"symbol"==typeof Symbol.iterator?function(t){return typeof t}:function(t){return t&&"function"==typeof Symbol&&t.constructor===Symbol?"symbol":typeof t},o=function(t){return null!=t&&"object"===(void 0===t?"undefined":e(t))&&1===t.nodeType&&"object"===e(t.style)&&"object"===e(t.ownerDocument)};function i(t){var r=t.parentNode;if(r)for(var n=0,e=r.childNodes,i=0;i<e.length;i++)if(o(e[i])&&(n+=1,e[i]===t))return[":nth-child(".concat(n,")")];return[]}function u(t){return Object.assign({},c,{root:t.ownerDocument.querySelector(":root")})}var c={selectors:["id","class","tag","attribute"],includeTag:!1,whitelist:[],blacklist:[],combineWithinSelector:!0,combineBetweenSelectors:!0},a=new RegExp(["^$","\\s","^\\d"].join("|")),f=new RegExp(["^$","^\\d"].join("|")),l=["nthoftype","tag","id","class","attribute","nthchild"],s=n(0),p=n.n(s);function y(t){return function(t){if(Array.isArray(t))return d(t)}(t)||function(t){if("undefined"!=typeof Symbol&&Symbol.iterator in Object(t))return Array.from(t)}(t)||function(t,r){if(!t)return;if("string"==typeof t)return d(t,r);var n=Object.prototype.toString.call(t).slice(8,-1);"Object"===n&&t.constructor&&(n=t.constructor.name);if("Map"===n||"Set"===n)return Array.from(t);if("Arguments"===n||/^(?:Ui|I)nt(?:8|16|32)(?:Clamped)?Array$/.test(n))return d(t,r)}(t)||function(){throw new TypeError("Invalid attempt to spread non-iterable instance.\nIn order to be iterable, non-array objects must have a [Symbol.iterator]() method.")}()}function d(t,r){(null==r||r>t.length)&&(r=t.length);for(var n=0,e=new Array(r);n<r;n++)e[n]=t[n];return e}function v(){var t=arguments.length>0&&void 0!==arguments[0]?arguments[0]:[],r=[[]];return t.forEach((function(t){r.forEach((function(n){r.push(n.concat(t))}))})),r.shift(),r.sort((function(t,r){return t.length-r.length}))}function g(t){return t.replace(/[|\\{}()[\]^$+?.]/g,"\\$&").replace(/\*/g,".+")}function b(){var t=arguments.length>0&&void 0!==arguments[0]?arguments[0]:[];if(0===t.length)return new RegExp(".^");var r=t.map((function(t){return"string"==typeof t?g(t):t.source})).join("|");return new RegExp(r)}function m(t,r){var n=arguments.length>2&&void 0!==arguments[2]?arguments[2]:document,e=n.querySelectorAll(r);return 1===e.length&&e[0]===t}function h(t){for(var r=arguments.length>1&&void 0!==arguments[1]?arguments[1]:j(t),n=[],e=t;o(e)&&e!==r;)n.push(e),e=e.parentElement;return n}function j(t){return t.ownerDocument.querySelector(":root")}function S(t){return[M(t.tagName.toLowerCase())]}function A(t){return function(t){if(Array.isArray(t))return w(t)}(t)||function(t){if("undefined"!=typeof Symbol&&Symbol.iterator in Object(t))return Array.from(t)}(t)||function(t,r){if(!t)return;if("string"==typeof t)return w(t,r);var n=Object.prototype.toString.call(t).slice(8,-1);"Object"===n&&t.constructor&&(n=t.constructor.name);if("Map"===n||"Set"===n)return Array.from(t);if("Arguments"===n||/^(?:Ui|I)nt(?:8|16|32)(?:Clamped)?Array$/.test(n))return w(t,r)}(t)||function(){throw new TypeError("Invalid attempt to spread non-iterable instance.\nIn order to be iterable, non-array objects must have a [Symbol.iterator]() method.")}()}function w(t,r){(null==r||r>t.length)&&(r=t.length);for(var n=0,e=new Array(r);n<r;n++)e[n]=t[n];return e}var O=b(["class","id","ng-*"]);function x(t){var r=t.nodeName,n=t.nodeValue;return"[".concat(r,"='").concat(M(n),"']")}function E(t){var r=t.nodeName;return!O.test(r)}function T(t){return function(t){if(Array.isArray(t))return C(t)}(t)||function(t){if("undefined"!=typeof Symbol&&Symbol.iterator in Object(t))return Array.from(t)}(t)||function(t,r){if(!t)return;if("string"==typeof t)return C(t,r);var n=Object.prototype.toString.call(t).slice(8,-1);"Object"===n&&t.constructor&&(n=t.constructor.name);if("Map"===n||"Set"===n)return Array.from(t);if("Arguments"===n||/^(?:Ui|I)nt(?:8|16|32)(?:Clamped)?Array$/.test(n))return C(t,r)}(t)||function(){throw new TypeError("Invalid attempt to spread non-iterable instance.\nIn order to be iterable, non-array objects must have a [Symbol.iterator]() method.")}()}function C(t,r){(null==r||r>t.length)&&(r=t.length);for(var n=0,e=new Array(r);n<r;n++)e[n]=t[n];return e}var I=":".charCodeAt(0).toString(16).toUpperCase(),$=/[ !"#$%&'()\[\]{|}<>*+,./;=?@^`~\\]/;function M(){var t=arguments.length>0&&void 0!==arguments[0]?arguments[0]:"";return t.split("").map((function(t){return":"===t?"\\".concat(I," "):$.test(t)?"\\".concat(t):escape(t).replace(/%/g,"\\")})).join("")}var N={tag:S,id:function(t){var r=t.getAttribute("id")||"",n="#".concat(M(r));return!a.test(r)&&m(t,n,t.ownerDocument)?[n]:[]},class:function(t){return(t.getAttribute("class")||"").trim().split(/\s+/).filter((function(t){return!f.test(t)})).map((function(t){return".".concat(M(t))}))},attribute:function(t){return A(t.attributes).filter(E).map(x)},nthchild:i,nthoftype:function(t){var r=S(t)[0],n=t.parentElement;if(n)for(var e=n.querySelectorAll(r),o=0;o<e.length;o++)if(e[o]===t)return["".concat(r,":nth-of-type(").concat(o+1,")")];return[]}};function P(t,r){if(t.parentNode)for(var n=function(t,r){return function(t){var r=arguments.length>1&&void 0!==arguments[1]?arguments[1]:{},n=r.selectors,e=r.combineBetweenSelectors,o=r.includeTag,i=e?v(n):n.map((function(t){return[t]}));return o?i.map(_):i}(t,r).map((function(r){return n=t,e={},r.forEach((function(t){var r=n[t];r.length>0&&(e[t]=r)})),p()(e).map(D);var n,e})).filter((function(t){return""!==t}))}(function(t,r){var n=r.blacklist,e=r.whitelist,o=r.combineWithinSelector,i=b(n),u=b(e);return function(t){var r=t.selectors,n=t.includeTag,e=[].concat(r);n&&!e.includes("tag")&&e.push("tag");return e}(r).reduce((function(r,n){var e=function(){var t=arguments.length>0&&void 0!==arguments[0]?arguments[0]:[],r=arguments.length>1?arguments[1]:void 0;return t.sort((function(t,n){var e=r.test(t),o=r.test(n);return e&&!o?-1:!e&&o?1:0}))}(function(){var t=arguments.length>0&&void 0!==arguments[0]?arguments[0]:[],r=arguments.length>1?arguments[1]:void 0,n=arguments.length>2?arguments[2]:void 0;return t.filter((function(t){return n.test(t)||!r.test(t)}))}(function(t,r){return(N[r]||function(){return[]})(t)}(t,n),i,u),u);return r[n]=o?v(e):e.map((function(t){return[t]})),r}),{})}(t,r),r),e=(u=n,(c=[]).concat.apply(c,y(u))),o=0;o<e.length;o++){var i=e[o];if(m(t,i,t.parentNode))return i}var u,c;return"*"}function _(t){return t.includes("tag")||t.includes("nthoftype")?T(t):[].concat(T(t),["tag"])}function q(t,r){return r[t]?r[t].join(""):""}function D(){var t=arguments.length>0&&void 0!==arguments[0]?arguments[0]:{};return l.map((function(r){return q(r,t)})).join("")}function R(t,r){return h(t,r).map((function(t){return i(t)[0]})).reverse().join(" > ")}function U(t){var r=arguments.length>1&&void 0!==arguments[1]?arguments[1]:{};return Object.assign({},u(t),r)}function k(t){for(var r=arguments.length>1&&void 0!==arguments[1]?arguments[1]:{},n=U(t,r),e=h(t,n.root),o=[],i=0;i<e.length;i++){o.unshift(P(e[i],n));var u=o.join(" > ");if(m(t,u,n.root))return u}return R(t,n.root)}r.default=k}])}));
 },{}]},{},[1])(1)
 });
