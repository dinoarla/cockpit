/* cockpit-loader.js — rotating loading text for all COCKPIT pages */
(function () {
  'use strict';

  var MSGS = [
    'Memuat data…',
    'Menghitung angka…',
    'Menyeduh kopi dulu…',
    'Menghubungi database…',
    'Membaca SQL…',
    'Mengolah tabel…',
    'Merangkum jutaan baris…',
    'Membuat grafik…',
    'Menata visualisasi…',
    'Sedang berpikir…',
    'Kalkulasi berjalan…',
    'Parsing data…',
    'Menunggu server…',
    'Validasi angka…',
    'Hampir selesai…',
    'Menyusun insight…',
    'Kompilasi hasil…',
    'Mengoptimasi query…',
    'Mengecek lagi…',
    'Sebentar ya…',
  ];

  /* WeakMap: element → { timer, idx } */
  var running = new WeakMap();

  function start(el, customMsgs) {
    if (!el || running.has(el)) return noop;
    var msgs = customMsgs || MSGS;
    var idx = 0;

    el.style.transition = 'opacity 0.25s ease';
    el.textContent = msgs[0];
    el.style.opacity = '1';

    function tick() {
      if (!document.contains(el)) { _stop(el); return; }
      el.style.opacity = '0';
      setTimeout(function () {
        if (!running.has(el)) return;
        idx = (idx + 1) % msgs.length;
        el.textContent = msgs[idx];
        el.style.opacity = '1';
      }, 260);
    }

    var timer = setInterval(tick, 1700);
    running.set(el, { timer: timer, idx: idx });
    return function () { _stop(el); };
  }

  function _stop(el) {
    if (!running.has(el)) return;
    clearInterval(running.get(el).timer);
    running.delete(el);
    el.style.transition = '';
    el.style.opacity = '';
  }

  function stop(el, finalText) {
    _stop(el);
    if (finalText !== undefined) el.textContent = finalText;
  }

  function noop() {}

  /* Auto-detect: animate any element whose text contains "memuat" */
  function autoDetect(root) {
    var scope = root || document;
    /* Target: .no-data strong, .kpi-note, .meta-badge containing "memuat" */
    var candidates = scope.querySelectorAll(
      '.no-data strong, .kpi-note, .meta-badge, [data-loader]'
    );
    candidates.forEach(function (el) {
      var t = el.textContent.trim().toLowerCase();
      if (t.indexOf('memuat') !== -1) start(el);
    });
  }

  /* MutationObserver: clean up timers when elements leave the DOM */
  var mo = new MutationObserver(function (mutations) {
    mutations.forEach(function (m) {
      m.removedNodes.forEach(function (node) {
        if (node.nodeType !== 1) return;
        _stop(node);
        try {
          node.querySelectorAll('*').forEach(function (child) { _stop(child); });
        } catch (e) {}
      });
    });
  });

  if (document.body) {
    mo.observe(document.body, { childList: true, subtree: true });
  } else {
    document.addEventListener('DOMContentLoaded', function () {
      mo.observe(document.body, { childList: true, subtree: true });
    });
  }

  document.addEventListener('DOMContentLoaded', function () { autoDetect(); });

  window.CockpitLoader = { start: start, stop: stop, autoDetect: autoDetect, MSGS: MSGS };
})();
