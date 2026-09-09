(function () {
  'use strict';

  const RESET_MS = 2000;
  const SVG = '<svg width="24" height="24" viewBox="0 0 24 24" fill="none" '
    + 'stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">';
  const ICON_COPY = SVG
    + '<rect x="8" y="1" width="12" height="15" rx="2"/>'
    + '<rect x="4" y="8" width="12" height="15" rx="2" fill="#000"/></svg>';
  const ICON_CHECK = SVG + '<polyline points="20 6 9 17 4 12"/></svg>';
  const ICON_FAIL = SVG
    + '<line x1="18" y1="6" x2="6" y2="18"/>'
    + '<line x1="6" y1="6" x2="18" y2="18"/></svg>';

  // A visually hidden live region. Screen readers announce whatever
  // text lands in it, so every click gets a spoken result.
  let status = null;

  function createStatusRegion() {
    status = document.createElement('div');
    status.className = 'copy-status';
    status.setAttribute('role', 'status');
    document.body.appendChild(status);
  }

  function announce(message) {
    // Clear first, then refill on the next tick. A live region only
    // speaks when its content changes, so a repeated message would
    // otherwise stay silent.
    status.textContent = '';
    setTimeout(function () {
      status.textContent = message;
    }, 50);
  }

  function setIcon(btn, icon, state) {
    btn.innerHTML = icon;
    btn.classList.toggle('copied', state === 'copied');
    btn.classList.toggle('failed', state === 'failed');
  }

  function writeToClipboard(text) {
    if (!navigator.clipboard) {
      return Promise.reject(new Error('Clipboard API unavailable'));
    }
    return navigator.clipboard.writeText(text);
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

    function showResult(icon, state, message) {
      clearTimeout(timer);
      setIcon(btn, icon, state);
      announce(message);
      timer = setTimeout(function () {
        setIcon(btn, ICON_COPY);
        timer = null;
      }, RESET_MS);
    }

    btn.addEventListener('click', function () {
      writeToClipboard(code.textContent).then(function () {
        showResult(ICON_CHECK, 'copied', 'Code copied to clipboard');
      }, function () {
        showResult(ICON_FAIL, 'failed', 'Copy failed');
      });
    });

    block.appendChild(btn);
  }

  document.addEventListener('DOMContentLoaded', function () {
    createStatusRegion();
    document.querySelectorAll('.highlight').forEach(createCopyButton);
  });
})();
