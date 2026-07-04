import { randomBytes } from "node:crypto";
import { safeCompare } from "./session.js";
/**
 * Pola "double submit cookie" untuk CSRF protection:
 * 1. Server generate token random, kirim lewat cookie BUKAN httpOnly
 *    (supaya JavaScript di halaman form bisa bacanya) + sisipkan juga
 *    di hidden field form.
 * 2. Saat form disubmit, browser otomatis kirim cookie-nya, DAN hidden
 *    field ikut terkirim di body request.
 * 3. Server bandingkan keduanya — kalau beda/tidak ada, tolak.
 *
 * Situs jahat yang mencoba trigger submit form ke endpoint kita tidak
 * bisa membaca cookie kita (dibatasi same-origin policy browser), jadi
 * tidak akan bisa menyertakan nilai yang cocok di hidden field.
 */
export const CSRF_COOKIE_NAME = "cockpit_csrf";
export function generateCsrfToken() {
    return randomBytes(32).toString("base64url");
}
export function verifyCsrfToken(cookieValue, formValue) {
    if (!cookieValue || !formValue)
        return false;
    return safeCompare(cookieValue, formValue);
}
//# sourceMappingURL=csrf.js.map