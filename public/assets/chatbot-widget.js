/* COCKPIT — Floating AI Assistant Widget */
(function () {
  if (document.getElementById('cw-root')) return;

  /* ── CSS ── */
  const css = `
  #cw-fab {
    position: fixed; bottom: 52px; right: 40px; z-index: 9998;
    width: 52px; height: 52px; border-radius: 50%;
    background: #FF4D00; border: 2.5px solid #111118;
    box-shadow: 3px 3px 0 #111118;
    cursor: pointer; display: flex; align-items: center; justify-content: center;
    transition: transform .15s, box-shadow .15s;
  }
  #cw-fab:hover { transform: translateY(-2px); box-shadow: 3px 5px 0 #111118; }
  #cw-fab svg { width: 24px; height: 24px; }

  #cw-badge {
    position: absolute; top: -4px; right: -4px;
    width: 16px; height: 16px; border-radius: 50%;
    background: #FFD600; border: 2px solid #111118;
    font-size: 9px; font-weight: 800; color: #111118;
    display: none; align-items: center; justify-content: center;
    font-family: 'DM Mono', monospace;
  }
  #cw-badge.visible { display: flex; }

  #cw-panel {
    position: fixed; bottom: 116px; right: 40px; z-index: 9999;
    width: 380px; height: 560px; max-height: calc(100vh - 160px);
    background: #FFFBF0; border: 2.5px solid #111118;
    border-radius: 16px; box-shadow: 4px 4px 0 #111118;
    display: flex; flex-direction: column; overflow: hidden;
    transform: scale(0.92) translateY(12px); opacity: 0;
    transform-origin: bottom right;
    transition: transform .2s cubic-bezier(.34,1.56,.64,1), opacity .15s;
    pointer-events: none;
    font-family: 'DM Sans', sans-serif;
  }
  #cw-panel.open {
    transform: scale(1) translateY(0); opacity: 1; pointer-events: all;
  }

  #cw-header {
    background: #0D1117; padding: 12px 14px;
    display: flex; align-items: center; gap: 10px;
    flex-shrink: 0;
  }
  .cw-hmark {
    width: 26px; height: 26px; border-radius: 7px;
    background: #FF4D00; border: 2px solid rgba(255,255,255,.25);
    display: flex; align-items: center; justify-content: center;
    font-size: 13px; flex-shrink: 0;
  }
  .cw-htitle { flex: 1; }
  .cw-htitle strong {
    display: block; font-size: .85rem; font-weight: 800; color: #E6EDF3;
  }
  .cw-htitle span {
    font-size: .65rem; color: #4ADE80;
    font-family: 'DM Mono', monospace;
  }
  #cw-close {
    width: 28px; height: 28px; border-radius: 7px; border: none;
    background: rgba(255,255,255,.07); color: rgba(230,237,243,.6);
    cursor: pointer; font-size: 14px; display: flex;
    align-items: center; justify-content: center; transition: background .15s;
  }
  #cw-close:hover { background: rgba(255,255,255,.15); color: #E6EDF3; }

  #cw-msgs {
    flex: 1; overflow-y: auto; padding: 14px 12px;
    display: flex; flex-direction: column; gap: 12px;
    scroll-behavior: smooth;
  }
  #cw-msgs::-webkit-scrollbar { width: 3px; }
  #cw-msgs::-webkit-scrollbar-thumb { background: rgba(17,17,24,.15); border-radius: 3px; }

  .cw-empty {
    flex: 1; display: flex; flex-direction: column;
    align-items: center; justify-content: center;
    text-align: center; gap: 8px; padding: 12px;
    color: #555560;
  }
  .cw-empty-icon { font-size: 2rem; opacity: .35; }
  .cw-empty h4 { font-size: .85rem; font-weight: 700; color: #111118; margin: 0; }
  .cw-empty p { font-size: .75rem; line-height: 1.5; margin: 0; }
  .cw-sugs { display: flex; flex-wrap: wrap; gap: 5px; justify-content: center; margin-top: 6px; }
  .cw-sug {
    padding: 5px 10px; border: 1.5px solid #111118; border-radius: 20px;
    background: #fff; font-size: .72rem; cursor: pointer;
    box-shadow: 1.5px 1.5px 0 #111118; transition: all .12s;
    font-family: 'DM Sans', sans-serif; color: #111118;
  }
  .cw-sug:hover { background: #111118; color: #fff; }

  .cw-msg { display: flex; gap: 7px; }
  .cw-msg.user { flex-direction: row-reverse; }
  .cw-av {
    width: 26px; height: 26px; border-radius: 7px; flex-shrink: 0;
    display: flex; align-items: center; justify-content: center;
    font-size: 11px; font-weight: 800; border: 2px solid #111118;
  }
  .cw-av.ai { background: #FF4D00; color: #fff; }
  .cw-av.user { background: #0D1117; color: #fff; }
  .cw-bubble {
    background: #fff; border: 2px solid #111118; border-radius: 10px;
    padding: 8px 11px; font-size: .8rem; line-height: 1.55;
    box-shadow: 2px 2px 0 #111118; max-width: calc(100% - 38px);
    word-break: break-word;
  }
  .cw-msg.user .cw-bubble {
    background: #0D1117; color: #E6EDF3; border-color: #0D1117; box-shadow: none;
  }

  .cw-sql-toggle {
    margin-top: 6px; padding: 4px 8px;
    background: rgba(17,17,24,.04); border: 1px solid rgba(17,17,24,.12);
    border-radius: 6px; cursor: pointer; font-size: .7rem;
    color: #555560; display: flex; align-items: center; gap: 5px;
    width: fit-content; user-select: none;
  }
  .cw-sql-toggle:hover { background: rgba(17,17,24,.08); }
  .cw-sql-block {
    display: none; margin-top: 5px;
    background: #0D1117; color: #7EE787;
    font-family: 'DM Mono', monospace; font-size: .68rem;
    padding: 8px 10px; border-radius: 7px; overflow-x: auto;
    white-space: pre; border: 2px solid #111118; max-height: 140px; overflow-y: auto;
  }
  .cw-sql-block.show { display: block; }

  .cw-thinking { display: flex; gap: 4px; align-items: center; padding: 2px 0; }
  .cw-thinking span {
    width: 6px; height: 6px; border-radius: 50%;
    background: #999; animation: cw-bounce .8s infinite;
  }
  .cw-thinking span:nth-child(2) { animation-delay: .15s; }
  .cw-thinking span:nth-child(3) { animation-delay: .3s; }
  @keyframes cw-bounce { 0%,80%,100%{transform:translateY(0)} 40%{transform:translateY(-5px)} }

  .cw-err {
    background: #FFF0EE; border: 1.5px solid #E74C3C;
    border-radius: 8px; padding: 7px 10px;
    font-size: .75rem; color: #E74C3C;
  }

  #cw-input-area {
    border-top: 2px solid #111118; background: #fff; padding: 10px;
    flex-shrink: 0;
  }
  #cw-input-row {
    display: flex; gap: 0; border: 2px solid #111118;
    border-radius: 10px; overflow: hidden;
    box-shadow: 2px 2px 0 #111118;
  }
  #cw-textarea {
    flex: 1; resize: none; border: none; outline: none;
    padding: 9px 11px; font-family: 'DM Sans', sans-serif;
    font-size: .82rem; line-height: 1.45; background: transparent;
    color: #111118; min-height: 40px; max-height: 100px;
  }
  #cw-textarea::placeholder { color: #aaa; }
  #cw-send {
    padding: 0 13px; background: #FF4D00; color: #fff;
    border: none; border-left: 2px solid #111118;
    cursor: pointer; font-size: 15px; font-weight: 700;
    transition: background .12s; flex-shrink: 0;
  }
  #cw-send:hover { background: #e04500; }
  #cw-send:disabled { background: #ccc; cursor: not-allowed; }
  #cw-hint {
    text-align: center; font-size: .65rem; color: #aaa;
    margin-top: 6px; font-family: 'DM Mono', monospace;
  }
  `;

  const styleEl = document.createElement('style');
  styleEl.textContent = css;
  document.head.appendChild(styleEl);

  /* ── HTML ── */
  const root = document.createElement('div');
  root.id = 'cw-root';
  root.innerHTML = `
    <button id="cw-fab" title="Jelajahi Cockpit — Tanya data riset">
      <div id="cw-badge"></div>
      <svg viewBox="0 0 24 24" fill="white" xmlns="http://www.w3.org/2000/svg">
        <path d="M21 16v-2l-8-5V3.5C13 2.67 12.33 2 11.5 2S10 2.67 10 3.5V9l-8 5v2l8-2.5V19l-2 1.5V22l3.5-1 3.5 1v-1.5L13 19v-5.5l8 2.5z"/>
      </svg>
    </button>

    <div id="cw-panel">
      <div id="cw-header">
        <div class="cw-hmark">
          <svg viewBox="0 0 24 24" fill="white" width="14" height="14">
            <path d="M21 16v-2l-8-5V3.5C13 2.67 12.33 2 11.5 2S10 2.67 10 3.5V9l-8 5v2l8-2.5V19l-2 1.5V22l3.5-1 3.5 1v-1.5L13 19v-5.5l8 2.5z"/>
          </svg>
        </div>
        <div class="cw-htitle">
          <strong>Jelajahi Cockpit</strong>
          <span>Llama 3.3 70B · Co-Pilot Riset</span>
        </div>
        <button id="cw-close" title="Tutup">✕</button>
      </div>

      <div id="cw-msgs">
        <div class="cw-empty" id="cw-empty">
          <div class="cw-empty-icon">✈</div>
          <h4>Siap terbang, Pilot!</h4>
          <p>Tanya data baca meter, statistik PLN, kependudukan, atau RUPTL.</p>
          <div class="cw-sugs">
            <button class="cw-sug">Total kWh Jabar 2026</button>
            <button class="cw-sug">UP3 pelanggan terbanyak</button>
            <button class="cw-sug">Rata-rata kWh Maret 2026</button>
          </div>
        </div>
      </div>

      <div id="cw-input-area">
        <div id="cw-input-row">
          <textarea id="cw-textarea" placeholder="Tanya data COCKPIT…" rows="1"></textarea>
          <button id="cw-send">↑</button>
        </div>
        <div id="cw-hint">Enter kirim · Shift+Enter baris baru · Esc tutup</div>
      </div>
    </div>
  `;
  document.body.appendChild(root);

  /* ── State ── */
  let open = false;
  let loading = false;
  let history = [];
  let unread = 0;

  const fab    = document.getElementById('cw-fab');
  const panel  = document.getElementById('cw-panel');
  const msgs   = document.getElementById('cw-msgs');
  const empty  = document.getElementById('cw-empty');
  const ta     = document.getElementById('cw-textarea');
  const send   = document.getElementById('cw-send');
  const badge  = document.getElementById('cw-badge');
  const closeB = document.getElementById('cw-close');

  /* ── Toggle ── */
  function togglePanel() {
    open = !open;
    panel.classList.toggle('open', open);
    if (open) { unread = 0; badge.classList.remove('visible'); ta.focus(); scrollBottom(); }
  }
  fab.addEventListener('click', togglePanel);
  closeB.addEventListener('click', () => { open = false; panel.classList.remove('open'); });
  document.addEventListener('keydown', (e) => { if (e.key === 'Escape' && open) { open = false; panel.classList.remove('open'); } });

  /* ── Helpers ── */
  function scrollBottom() { msgs.scrollTop = msgs.scrollHeight; }

  function esc(s) {
    return String(s).replace(/&/g,'&amp;').replace(/</g,'&lt;').replace(/>/g,'&gt;').replace(/"/g,'&quot;');
  }

  function fmt(text) {
    return esc(text)
      .replace(/\*\*(.*?)\*\*/g, '<strong>$1</strong>')
      .replace(/\n/g, '<br>');
  }

  function hideEmpty() { if (empty) empty.style.display = 'none'; }

  function addUser(text) {
    hideEmpty();
    const el = document.createElement('div');
    el.className = 'cw-msg user';
    el.innerHTML = `<div class="cw-av user">D</div><div class="cw-bubble">${esc(text)}</div>`;
    msgs.appendChild(el);
    scrollBottom();
  }

  function addThinking() {
    hideEmpty();
    const el = document.createElement('div');
    el.className = 'cw-msg ai'; el.id = 'cw-thinking';
    el.innerHTML = `<div class="cw-av ai">✦</div><div class="cw-bubble"><div class="cw-thinking"><span></span><span></span><span></span></div></div>`;
    msgs.appendChild(el);
    scrollBottom();
    return el;
  }

  function removeThinking() { document.getElementById('cw-thinking')?.remove(); }

  function addAI(answer, sql, rowCount) {
    const el = document.createElement('div');
    el.className = 'cw-msg ai';
    const sqlHtml = sql ? `
      <div class="cw-sql-toggle" data-sql-toggle>
        <span>▼</span> SQL (${rowCount} baris)
      </div>
      <div class="cw-sql-block">${esc(sql)}</div>` : '';
    el.innerHTML = `<div class="cw-av ai">✦</div><div class="cw-bubble">${fmt(answer)}${sqlHtml}</div>`;
    msgs.appendChild(el);
    scrollBottom();
    if (!open) { unread++; badge.textContent = unread > 9 ? '9+' : unread; badge.classList.add('visible'); }
  }

  function addErr(msg) {
    const el = document.createElement('div');
    el.className = 'cw-err'; el.textContent = '⚠ ' + msg;
    msgs.appendChild(el);
    scrollBottom();
  }

  /* ── Send (streaming SSE) ── */
  async function sendMsg() {
    if (loading) return;
    const text = ta.value.trim();
    if (!text) return;
    loading = true; send.disabled = true;
    ta.value = ''; ta.style.height = 'auto';
    addUser(text);

    // Buat bubble AI kosong dengan dots dulu
    hideEmpty();
    const aiEl = document.createElement('div');
    aiEl.className = 'cw-msg ai';
    aiEl.innerHTML = `<div class="cw-av ai">✦</div><div class="cw-bubble"><div class="cw-thinking"><span></span><span></span><span></span></div></div>`;
    msgs.appendChild(aiEl);
    scrollBottom();
    const bubble = aiEl.querySelector('.cw-bubble');

    let fullText = '';
    let gotFirstChunk = false;
    let sqlQuery = null;
    let sqlRows = 0;

    try {
      const res = await fetch('/api/chatbot/chat', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ message: text, history }),
      });

      if (!res.ok || !res.body) {
        const e = await res.json().catch(() => ({}));
        bubble.innerHTML = `<div class="cw-err">⚠ ${esc(e.error || 'Server error ' + res.status)}</div>`;
      } else {
        const reader = res.body.getReader();
        const decoder = new TextDecoder();
        let buf = '';

        while (true) {
          const { done, value } = await reader.read();
          if (done) break;
          buf += decoder.decode(value, { stream: true });
          const lines = buf.split('\n');
          buf = lines.pop() ?? '';

          for (const line of lines) {
            if (!line.startsWith('data: ')) continue;
            let ev;
            try { ev = JSON.parse(line.slice(6)); } catch { continue; }

            if (ev.t === 'chunk') {
              if (!gotFirstChunk) { bubble.innerHTML = ''; gotFirstChunk = true; }
              fullText += ev.v;
              bubble.innerHTML = fmt(fullText);
              scrollBottom();
            } else if (ev.t === 'sql') {
              sqlQuery = ev.query;
              sqlRows = ev.rows;
            } else if (ev.t === 'api') {
              sqlQuery = ev.endpoint;
              sqlRows = null;
            } else if (ev.t === 'error') {
              bubble.innerHTML = `<div class="cw-err">⚠ ${esc(ev.v)}</div>`;
            } else if (ev.t === 'done') {
              if (sqlQuery) {
                const label = sqlRows !== null ? `SQL (${sqlRows} baris)` : `API: ${esc(sqlQuery)}`;
                const detail = sqlRows !== null ? esc(sqlQuery) : esc(sqlQuery);
                bubble.innerHTML = fmt(fullText) +
                  `<div class="cw-sql-toggle" data-sql-toggle><span>▼</span> ${label}</div>` +
                  `<div class="cw-sql-block">${detail}</div>`;
              }
              if (fullText) {
                history.push({ role: 'user', text });
                history.push({ role: 'assistant', text: fullText });
                if (history.length > 20) history = history.slice(-20);
              }
              if (!open) { unread++; badge.textContent = unread > 9 ? '9+' : unread; badge.classList.add('visible'); }
            }
          }
        }
      }
    } catch {
      bubble.innerHTML = `<div class="cw-err">⚠ Gagal terhubung ke server.</div>`;
    }

    loading = false; send.disabled = false; ta.focus();
  }

  /* ── Input events ── */
  ta.addEventListener('input', () => { ta.style.height = 'auto'; ta.style.height = Math.min(ta.scrollHeight, 100) + 'px'; });
  ta.addEventListener('keydown', (e) => { if (e.key === 'Enter' && !e.shiftKey) { e.preventDefault(); sendMsg(); } });
  send.addEventListener('click', sendMsg);

  /* ── Event delegation (CSP-safe, no inline onclick) ── */
  msgs.addEventListener('click', (e) => {
    const sug = e.target.closest('.cw-sug');
    if (sug) { ta.value = sug.textContent.trim(); sendMsg(); return; }
    const toggle = e.target.closest('[data-sql-toggle]');
    if (toggle) {
      const block = toggle.nextElementSibling;
      block.classList.toggle('show');
      toggle.querySelector('span').textContent = block.classList.contains('show') ? '▲' : '▼';
    }
  });
})();
