(()=>{"use strict";var e,t,r,a,o,f={},c={};function n(e){var t=c[e];if(void 0!==t)return t.exports;var r=c[e]={exports:{}};return f[e].call(r.exports,r,r.exports,n),r.exports}n.m=f,e=[],n.O=(t,r,a,o)=>{if(!r){var f=1/0;for(u=0;u<e.length;u++){r=e[u][0],a=e[u][1],o=e[u][2];for(var c=!0,d=0;d<r.length;d++)(!1&o||f>=o)&&Object.keys(n.O).every((e=>n.O[e](r[d])))?r.splice(d--,1):(c=!1,o<f&&(f=o));if(c){e.splice(u--,1);var i=a();void 0!==i&&(t=i)}}return t}o=o||0;for(var u=e.length;u>0&&e[u-1][2]>o;u--)e[u]=e[u-1];e[u]=[r,a,o]},n.n=e=>{var t=e&&e.__esModule?()=>e.default:()=>e;return n.d(t,{a:t}),t},r=Object.getPrototypeOf?e=>Object.getPrototypeOf(e):e=>e.__proto__,n.t=function(e,a){if(1&a&&(e=this(e)),8&a)return e;if("object"==typeof e&&e){if(4&a&&e.__esModule)return e;if(16&a&&"function"==typeof e.then)return e}var o=Object.create(null);n.r(o);var f={};t=t||[null,r({}),r([]),r(r)];for(var c=2&a&&e;"object"==typeof c&&!~t.indexOf(c);c=r(c))Object.getOwnPropertyNames(c).forEach((t=>f[t]=()=>e[t]));return f.default=()=>e,n.d(o,f),o},n.d=(e,t)=>{for(var r in t)n.o(t,r)&&!n.o(e,r)&&Object.defineProperty(e,r,{enumerable:!0,get:t[r]})},n.f={},n.e=e=>Promise.all(Object.keys(n.f).reduce(((t,r)=>(n.f[r](e,t),t)),[])),n.u=e=>"assets/js/"+({60:"54f44f5c",85:"1f391b9e",144:"74d0c629",205:"30ecee84",213:"ab3cad51",231:"868531cc",245:"68ef633b",250:"c8f97dc4",270:"0a5cd3fd",297:"5a542c2e",308:"c5606216",331:"02fae9b5",511:"596877d1",560:"f033f4cb",619:"5e5f3b67",670:"be553fb0",677:"7556a729",721:"9a16b5f8",766:"13760ac7",800:"3f50c7da",879:"1a681808",896:"7a449a3e",978:"494a20e0"}[e]||e)+"."+{60:"7228b3ff",85:"d4dc5de3",144:"734cc274",205:"d8896cce",213:"05b09fea",231:"a691adbf",245:"e3b86426",250:"2eb270b3",270:"4617968c",297:"f56e3931",308:"1e2ff6ab",331:"5acf44c7",339:"ea7d7f66",343:"0365238a",511:"dbd11797",560:"64adfc87",619:"06b956d5",670:"67cb7040",677:"5b2aa7b9",721:"3a5c241d",766:"407dd27b",800:"5cccb8fb",878:"27baceba",879:"34dd6dca",896:"27f5fd07",972:"44ff1402",978:"5a2fdae4"}[e]+".js",n.miniCssF=e=>{},n.g=function(){if("object"==typeof globalThis)return globalThis;try{return this||new Function("return this")()}catch(e){if("object"==typeof window)return window}}(),n.o=(e,t)=>Object.prototype.hasOwnProperty.call(e,t),a={},o="docs:",n.l=(e,t,r,f)=>{if(a[e])a[e].push(t);else{var c,d;if(void 0!==r)for(var i=document.getElementsByTagName("script"),u=0;u<i.length;u++){var b=i[u];if(b.getAttribute("src")==e||b.getAttribute("data-webpack")==o+r){c=b;break}}c||(d=!0,(c=document.createElement("script")).charset="utf-8",c.timeout=120,n.nc&&c.setAttribute("nonce",n.nc),c.setAttribute("data-webpack",o+r),c.src=e),a[e]=[t];var l=(t,r)=>{c.onerror=c.onload=null,clearTimeout(s);var o=a[e];if(delete a[e],c.parentNode&&c.parentNode.removeChild(c),o&&o.forEach((e=>e(r))),t)return t(r)},s=setTimeout(l.bind(null,void 0,{type:"timeout",target:c}),12e4);c.onerror=l.bind(null,c.onerror),c.onload=l.bind(null,c.onload),d&&document.head.appendChild(c)}},n.r=e=>{"undefined"!=typeof Symbol&&Symbol.toStringTag&&Object.defineProperty(e,Symbol.toStringTag,{value:"Module"}),Object.defineProperty(e,"__esModule",{value:!0})},n.p="/luau-props/",n.gca=function(e){return e={"54f44f5c":"60","1f391b9e":"85","74d0c629":"144","30ecee84":"205",ab3cad51:"213","868531cc":"231","68ef633b":"245",c8f97dc4:"250","0a5cd3fd":"270","5a542c2e":"297",c5606216:"308","02fae9b5":"331","596877d1":"511",f033f4cb:"560","5e5f3b67":"619",be553fb0:"670","7556a729":"677","9a16b5f8":"721","13760ac7":"766","3f50c7da":"800","1a681808":"879","7a449a3e":"896","494a20e0":"978"}[e]||e,n.p+n.u(e)},(()=>{var e={303:0,532:0};n.f.j=(t,r)=>{var a=n.o(e,t)?e[t]:void 0;if(0!==a)if(a)r.push(a[2]);else if(/^(303|532)$/.test(t))e[t]=0;else{var o=new Promise(((r,o)=>a=e[t]=[r,o]));r.push(a[2]=o);var f=n.p+n.u(t),c=new Error;n.l(f,(r=>{if(n.o(e,t)&&(0!==(a=e[t])&&(e[t]=void 0),a)){var o=r&&("load"===r.type?"missing":r.type),f=r&&r.target&&r.target.src;c.message="Loading chunk "+t+" failed.\n("+o+": "+f+")",c.name="ChunkLoadError",c.type=o,c.request=f,a[1](c)}}),"chunk-"+t,t)}},n.O.j=t=>0===e[t];var t=(t,r)=>{var a,o,f=r[0],c=r[1],d=r[2],i=0;if(f.some((t=>0!==e[t]))){for(a in c)n.o(c,a)&&(n.m[a]=c[a]);if(d)var u=d(n)}for(t&&t(r);i<f.length;i++)o=f[i],n.o(e,o)&&e[o]&&e[o][0](),e[o]=0;return n.O(u)},r=self.webpackChunkdocs=self.webpackChunkdocs||[];r.forEach(t.bind(null,0)),r.push=t.bind(null,r.push.bind(r))})()})();