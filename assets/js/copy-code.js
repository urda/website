(function () {
  'use strict';

  const RESET_MS = 2000;
  const SVG = '<svg width="24" height="24" viewBox="0 0 24 24" fill="none" '
    + 'stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">';
  const ICON_COPY = SVG
    + '<rect x="8" y="1" width="12" height="15" rx="2"/>'
    + '<rect x="4" y="8" width="12" height="15" rx="2" fill="#000"/></svg>';
  const ICON_CHECK = SVG + '<polyline points="20 6 9 17 4 12"/></svg>';

  function setIcon(btn, icon, state) {
    btn.innerHTML = icon;
    btn.classList.toggle('copied', state === 'copied');
  }

  function createCopyButton(block) {
    const code = block.querySelector('.rouge-code pre');
    if (!code) return;

    // Wrap scrollable content so the button stays fixed in place
    var scrollWrap = document.createElement('div');
    scrollWrap.className = 'highlight-scroll';
    while (block.firstChild) {
      scrollWrap.appendChild(block.firstChild);
    }
    block.appendChild(scrollWrap);

    const btn = document.createElement('button');
    let timer = null;

    btn.className = 'copy-btn';
    btn.setAttribute('aria-label', 'Copy code to clipboard');
    setIcon(btn, ICON_COPY);

    btn.addEventListener('click', function () {
      navigator.clipboard.writeText(code.textContent).then(function () {
        clearTimeout(timer);
        setIcon(btn, ICON_CHECK, 'copied');
        timer = setTimeout(function () {
          setIcon(btn, ICON_COPY);
          timer = null;
        }, RESET_MS);
      });
    });

    block.appendChild(btn);
  }

  document.addEventListener('DOMContentLoaded', function () {
    document.querySelectorAll('.highlight').forEach(createCopyButton);
  });
})();
