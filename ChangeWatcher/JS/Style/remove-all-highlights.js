document.addEventListener('touchstart', ()=>{
var elements = document.getElementsByClassName('watch-element');
for (var element of elements) {
    element.classList.remove('watch-element')
}
})
