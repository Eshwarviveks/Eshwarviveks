const cursor=document.querySelector('.cursor');
const menu=document.querySelector('.menu');
const navLinks=document.querySelector('.nav-links');

if(cursor){
  window.addEventListener('pointermove',e=>{cursor.style.left=`${e.clientX}px`;cursor.style.top=`${e.clientY}px`},{passive:true});
  document.querySelectorAll('a,button').forEach(el=>{
    el.addEventListener('pointerenter',()=>{cursor.style.width='32px';cursor.style.height='32px';cursor.style.background='var(--accent)'});
    el.addEventListener('pointerleave',()=>{cursor.style.width='10px';cursor.style.height='10px';cursor.style.background='transparent'});
  });
}

menu?.addEventListener('click',()=>{
  const open=navLinks.classList.toggle('open');
  menu.setAttribute('aria-expanded',String(open));
});
navLinks?.querySelectorAll('a').forEach(a=>a.addEventListener('click',()=>navLinks.classList.remove('open')));

const observer=new IntersectionObserver(entries=>{
  entries.forEach(entry=>{if(entry.isIntersecting){entry.target.classList.add('show');observer.unobserve(entry.target)}});
},{threshold:.12,rootMargin:'0px 0px -40px 0px'});
document.querySelectorAll('.reveal').forEach(el=>observer.observe(el));

// Keep scroll effects lightweight: no large libraries and no continuous layout work.
let lastY=window.scrollY;
window.addEventListener('scroll',()=>{lastY=window.scrollY},{passive:true});
