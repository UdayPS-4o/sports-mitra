# Sports Mitra – Complete Mobile App UI (v0.1)

*A lightweight, offline-first, AI‑assisted mobile app for standardized talent assessment.*

---

## 0) Design System (Mobile‑first)

* **Platforms:** Android (min SDK 23), iOS 14+
* **Orientation:** Portrait everywhere; auto-rotate to **Landscape** only on camera capture screens for Shuttle Run & Endurance Run.
* **Color:** Primary `#0E9F6E` (teal), Secondary `#1F2937` (slate), Accent `#F59E0B` (amber), Success `#10B981`, Error `#EF4444`, Neutral `#F3F4F6`.
* **Type:** Headings – *Inter* 700, Body – *Inter* 400/500. Numeric counters use *SF Mono* / *Roboto Mono*.
* **Grid:** 8‑pt grid, safe-area insets respected.
* **Components:** Filled/tonal buttons, chips (filter, attempt tags), progress rings, segmented control, bottom sheets, floating action button (FAB) for **Start Test**.
* **Icons:** Outline style (Lucide/Material) – camera, activity, award, shield, wifi-off, cloud-upload.
* **States:** Empty, Loading, Offline, Flagged (amber), Verified (green tick), Draft (gray).
* **Haptics:** Light on rep count; success on submission; warning on anomaly flag.
* **Language:** Multilingual pack (EN, HI first; others via pack download). RTL ready.
* **Accessibility:** Dynamic type, high-contrast toggle, captions for voice cues, vibration mirroring.

---

## 1) Navigation & Information Architecture (Updated)

**Bottom Tab Bar (global):** **Home • Assessments • Progress • Settings**
**Orientation:** Portrait everywhere for this MVP.

**Flows kept for now** (camera capture deferred):

* Browse tests, read requirements & benchmarks.
* Enter results **manually** (stub) to design and validate downstream screens.
* View/save results, history, badges preview, and sync (mocked).
* Configure profile, language, units, and app options.

**IA Map (MVP)**

* **Home** → quick stats, next suggested test, drafts, recent results, badges preview.
* **Assessments** → list of tests → **Assessment Sheet** (overview + manual entry) → **Review** → **Submit** → **Result Details**.
* **Progress** → charts & tables: weekly trend, personal bests, percentile placeholders, history log.
* **Settings** → profile, language/units, downloads (model packs placeholder), privacy, accessibility.

### 2.1 Home

**Layout:** Card list + small header with avatar & Digital ID.
**Sections:**

1. **Welcome** — *“Hi, Aditi!”* • ID `SM-IN-7A2C94` (tap to copy).
2. **Quick Stats** — Verified tests **3/5**, Best percentile **P78**, Streak **5 days**.
3. **Next Suggested Test** — *Vertical Jump* → **Start from Assessments** (deep-link).
4. **Recent Results** — horizontal cards with last 4 verified/entered items.

   * *Push‑ups (60s): 28 reps — Verified*
   * *Shuttle Run 20m: 11.6 s — Draft*
5. **Drafts & To‑Upload** — list with actions: *Edit • Delete • Submit*.
6. **Badges Preview** — *Consistency (5/7)*, *Clean Form (2/3)*.
7. **Announcements** — one‑line items; tap opens webview.

**Empty state copy:** “No results yet. Head to **Assessments** to begin.”

---

### 2.2 Assessments

**Top controls:** Age/Gender auto‑applied (read‑only), Filter by *All / Strength / Speed / Endurance*.

**Cards (tests):** Height & Weight • Vertical Jump • Sit‑ups (60s) • Push‑ups (60s) • Shuttle Run 20m • Endurance Run 1.6 km • Sit & Reach.
Tapping a card opens an **Assessment Sheet** (no camera yet):

#### Assessment Sheet (Common Layout)

* **Header:** Test name, short purpose line; status chip (Draft / Submitted / Verified).
* **Sections:**

  1. **Overview** — 2–3 lines explaining what is measured.
  2. **Requirements** — small checklist (equipment, space, helper needed).
  3. **Benchmarks** — age/gender‑based ranges (table).
  4. **Enter Result (Manual for now)** — numeric field(s) with unit picker; validation; *Add Attempt* button (keeps best by default).
  5. **Notes (optional)** — free text.
  6. **Attachments (optional)** — disabled tile: “Video capture coming soon”.
  7. **Actions** — **Save Draft**, **Submit for Verification** (mock), **Reset**.

##### Example: Vertical Jump (Girls 16–17)

* **Overview:** Standing vertical jump using wall/ruler marker.
* **Requirements:** Wall marker to 300 cm; shoes; flat floor.
* **Benchmarks table:** Excellent ≥45 cm • Good ≥40 cm • Average ≥33 cm.
* **Enter Result:** Field `Best height (cm)`; Attempts list shows:

  * Attempt 1 — 38.7 cm
  * Attempt 2 — 41.2 cm **(best)**
  * Attempt 3 — 39.5 cm
* **Actions:** Save Draft / Submit for Verification.

##### Example: Push‑ups (60s)

* **Requirements:** Flat surface; camera optional (future).
* **Benchmarks:** Excellent ≥32; Good ≥26; Average ≥18 (dummy).
* **Fields:** `Valid reps` (int), `Breaks` (int, optional), `Notes`.

##### Example: Shuttle Run 20m

* **Requirements:** Two cones 20 m apart; stopwatch/helper.
* **Fields:** `Attempt time (s)` (decimal); button *Mark Best* if multiple rows.

**Review Step (after Submit)**

* **Summary:** score, benchmark band (e.g., *Good*), date/time, notes.
* **Status:** *Submitted* → *Verified* (simulated after 5s for MVP demo).
* **Buttons:** View Result • Edit (unlocks if status ≠ Verified).

---

### 2.3 Progress

**Header filters:** Time window (7d/30d/90d/All), Tests (chips multi‑select).
**Widgets:**

1. **Weekly Trend** — sparkline per test (textual placeholders in MVP).

   * *Vertical Jump:* 33 → 41 → 40 → **42** cm
   * *Push‑ups:* 18 → 22 → 26 → **28**
2. **Personal Bests** — compact list with date badges.

   * *Shuttle 20m:* **11.63 s** (09 Sep)
   * *Vertical Jump:* **41.2 cm** (09 Sep)
3. **Cohort Benchmarks** — displays band only (e.g., *Top 25%*), percentile calc placeholder.
4. **History Table** (sortable):

   | Date   | Test            | Score       | Status    |
   | ------ | --------------- | ----------- | --------- |
   | 09 Sep | Vertical Jump   | **41.2 cm** | Verified  |
   | 07 Sep | Shuttle Run 20m | **11.63 s** | Submitted |
   | 06 Sep | Push‑ups (60s)  | **28 reps** | Verified  |

**Empty state:** “Once you submit assessments, your progress appears here.”

---

### 2.4 Settings

* **Profile:** Name, DOB, Gender, City/District, Sports (chips).
* **Language & Units:** English/Hindi; cm‑kg or ft‑lb.
* **Downloads:** Model packs (placeholders), language packs.
* **Data & Privacy:** Export my data (mock), Delete account (confirm only).
* **Accessibility:** Larger text, high‑contrast, haptic level.
* **About:** Version, contact support.

**Footer on all tabs:** Role pill (Athlete) • Digital ID QR (tap).## 3) Per‑Test UI Specs (fields, options, sample values)

### 3.1 Vertical Jump

* **Attempts:** 3 (editable for coach event)
* **Output fields:** Peak height (cm), Takeoff/landing validity, Run‑up used (Y/N), Form score (0–100), Anomaly flags (angle drift, occlusion).
* **Sample:** `{height: 41.2, valid: true, runup: false, form: 92, flags: ['angle_drift_minor']}`

### 3.2 Sit‑ups 60s

* **Output:** Valid reps, Half‑reps excluded, Breaks, Form score, Flags (hands off head, feet lift).
* **Sample:** `{reps: 32, excluded: 3, breaks: 1, form: 90, flags: []}`

### 3.3 Push‑ups 60s

* **Output:** Valid reps, Depth compliance %, Tempo, Flags (hip sag, knee contact).
* **Sample:** `{reps: 28, depth_ok: 91, tempo: 'steady', flags: ['hip_sag_minor']}`

### 3.4 Shuttle Run 20m

* **Output:** Best time (s), Splits, Turn faults, Start reaction.
* **Sample:** `{best: 11.63, splits:[5.71, 5.92], faults:1, reaction:0.28}`

### 3.5 Endurance Run 1.6 km

* **Output:** Time, Avg pace, HR avg (if available), GPS integrity score, Selfie checks passed.
* **Sample:** `{time:'09:11', pace:'5:43/km', hr:--, integrity:0.93, selfies:3}`

### 3.6 Height & Weight

* **Output:** Height cm, Weight kg, BMI auto‑calc (display only), Capture photo for record.
* **Sample:** `{height:162.4, weight:52.8, bmi:20.0}`

---

## 4) Gamification & Community UI

* **Badges list** with criteria:

  * *Clean Form* – 95%+ form in any test (3 times)
  * *District Top‑10* – Place ≤ 10 in district leaderboard
  * *Streak* – Complete 7/14/30 day streaks
* **Challenges**: Join → progress bar on Home; notifications when milestones hit.
* **Leaderboards:** show rank delta (↑2 / ↓1), shareable card image.

---

## 5) Sample Data Fixtures (for UX copy & QA)

**User (Athlete)**

```
{
  "id":"SM-IN-7A2C94",
  "name":"Aditi Sharma",
  "age":16,
  "gender":"F",
  "district":"Indore",
  "sports":["Athletics","Basketball"],
  "percentiles":{"strength":74,"speed":69,"endurance":81}
}
```

**Recent Results**

```
[
  {"test":"vertical_jump","best_cm":41.2,"verified":true,"date":"2025-09-09"},
  {"test":"shuttle_20m","best_s":11.63,"verified":false,"date":"2025-09-07"},
  {"test":"pushups_60","reps":28,"verified":true,"date":"2025-09-06"}
]
```

**Leaderboard (Girls 16–17, Vertical Jump)**

```
[
 {"rank":1,"name":"Ananya Mehta","city":"Delhi","score":"47.6 cm","status":"verified"},
 {"rank":2,"name":"Riya Patil","city":"Pune","score":"46.3 cm","status":"verified"},
 {"rank":3,"name":"Aditi Sharma (You)","city":"Indore","score":"41.2 cm","status":"verified"}
]
```

---

## 6) Empty/Error/Flag States (copy + UI)

* **Empty Home:** “Let’s record your first test. Start with Vertical Jump.” \[Start]
* **Offline:** “You’re offline. Record as usual; we’ll upload when back online.” \[View queue]
* **Flagged Review:** “We spotted something unusual (angle drift). You can submit, but an official may request a retake.” \[Submit anyway] \[Retake]
* **Low Light:** “Lighting is low (120 lux). Move near a window or turn on a light.” \[Re‑check]

---

## 7) Micro‑interactions & Copy

* Countdown VO: “Ready… three, two, one… go!”
* Success toast: “Saved • Added to Sync Queue”
* Verification toast: “Verified by Indore District Official • 09 Sep”

---

## 8) What’s Desktop/Web vs Mobile

* **Mobile app** covers athlete capture, practice, leaderboards, digital ID; coach light tools; official review light.
* **Web dashboard** (separate) for deep analytics, bulk verification, event management (outside this document).

---

## 9) Quick Visual Style Notes

* Cards with 16px radius, soft shadows.
* Counters use large numerals; keep background neutral for video overlays.
* Use colored chips for status: Verified (green), AI‑verified (amber), Pending (gray), Flagged (red outline).

---

## 10) Release Slice (MVP – camera deferred)

Build these first:

1. **Bottom Nav (4 tabs)**
2. **Home** with drafts, recent results, and suggested test deep‑links
3. **Assessments** with **Assessment Sheet** (manual entry), Review, Submit, and Result Details (static verify)
4. **Progress** with trends, personal bests, and history table
5. **Settings** with profile, language/units, accessibility

**Deferred (post‑MVP):**

* Splash & Onboarding flow (OTP, device readiness)
* Pre‑check & **Camera capture** (auto‑segmentation, on‑device models)
* Practice, Challenges, Leaderboards, Coach/Official modes
* Real verification pipeline & PDF exports

---

## 11) Modern Dark UI (like the reference)

**Look & Feel**

* **Theme:** Dark, warm‑contrast, sleek cards.
* **Background:** `#0C1320` → subtle radial gradient top‑right `rgba(59,130,246,0.08)`.
* **Surface/Card:** `#111827` (hover `#121E2B`), glass‑tint `rgba(255,255,255,0.04)`.
* **Text:** Primary `#E5E7EB`, Muted `#9CA3AF`.
* **Primary Accent:** Blue `#3B82F6`; **Secondary:** Teal `#14B8A6`; **Warn:** `#F59E0B`; **Danger:** `#EF4444`.
* **Radii:** 20dp cards, 16dp tiles, 12dp inputs, 28dp pill buttons.
* **Shadows:** soft ambient (y=8, blur=24, alpha 20%), inner highlight 1px top for cards.
* **Iconography:** Linear/duotone, 24dp; active = accent glow `0 0 12 rgba(59,130,246,.35)`.
* **Motion:** 180ms ease‑out; springy for hero CTA; parallax 4–6px on hero art.

**Bottom Nav (Dock)**

* Height 72dp; frosted dock effect (blur 16); active tab pill with subtle top indicator.
* Tabs: **Home · Assessments · Progress · Settings**

**Home (Modern layout)**

* **Header:** “Hi, Aditi” (20/28) + tiny settings icon.
* **Hero / Next Challenge card** (full‑bleed art):

  * Size **160dp height**; left text block, right illustration.
  * Title 16/24, body 12/18, CTA pill **Start →**.
* **My Stats** (horizontal):

  * 3–5 tiles **140×120dp** with mini art + metric (e.g., *Shuttle 11.6s*, *Sit‑ups 45 reps*).
* **District Leaderboard**:

  * Rows **56dp**; avatar 40dp (glow ring for top‑3).
  * “View all” link opens full board (later).
* **Info cards** (Diet Planner, Find a Coach) **160×120dp** with icon/illustration and CTA.

**Assessments (Modern list)**

* Segmented filter chips; each test is a **compact card** (72dp) with left icon, title, band tag, chevron.
* Tapping → **Assessment Sheet** (see Tab‑by‑Tab) using dark inputs, numeric keypad style.

**Progress (Modern)**

* Section header with chip filters; cards use sparklines (SVG placeholders) and pill stats.
* History table becomes **compact list** with test icon + score on the right.

**Settings (Modern)**

* Grouped lists with subtitles; toggle switches glow on accent.

---

## 12) Image Prompts & Sizes (ready to generate)

> Use these verbatim with your image tool. Export as **WebP**; provide @1x/@2x/@3x. For Android, keep 8‑pt safe insets; for iOS, mind corner radii.

### Global Guidance

* **Style:** modern sports editorial meets minimal 3D/flat hybrid; clean backgrounds, soft rim light, no brand logos.
* **Palette constraint:** deep navy backgrounds with **blue/teal** accents; avoid neon overload.
* **Framing:** leave **40–64px** safe space on the side with text (usually left).
* **People:** diverse Indian teens/young adults; gender‑balanced; athletic but natural.

### Asset List (Home)

1. **Hero – Next Challenge (Runner)**

   * **Size:** 1200×480 px (fits 375×150dp @3x).
   * **Prompt:** *“dynamic side‑view of a teen sprinter launching off the blocks at dusk, stylized semi‑real illustration, soft rim light, deep navy background, accents in electric blue and teal, motion trails, no text, high detail, 3:1 aspect”*.

2. **Stats Tile – Shuttle Run**

   * **Size:** 600×600 px (200×200dp @3x, square).
   * **Prompt:** *“minimal vector‑3D hybrid of running shoes crossing a finish split line, depth shadows, navy card background, blue accent, center composition, no text, square”*.

3. **Stats Tile – Sit‑ups**

   * **Size:** 600×600 px.
   * **Prompt:** *“clean flat illustration of athlete doing sit‑ups on mat, side silhouette, warm skin tones, navy background, subtle teal grid, square, no text”*.

4. **Stats Tile – Endurance Run**

   * **Size:** 600×600 px.
   * **Prompt:** *“top‑down track lane with looping path and tiny runner icon, modern minimal, blue/teal palette, high contrast, square”*.

5. **District Leaderboard Avatars (Top‑3)**

   * **Size:** 480×480 px (circle crop).
   * **Prompt:** *“portrait of smiling teen athlete, studio soft light, subtle rim light, dark navy background with faint gradient, professional sports portrait, no text, centered, photoreal”*.

6. **District Leaderboard Avatars (Others)**

   * **Size:** 320×320 px.
   * **Prompt:** *“simple illustrated avatar head‑and‑shoulders of athlete, flat colors, navy background, circular crop, friendly expression, no text”*.

7. **Card – Diet Planner**

   * **Size:** 900×600 px (3:2).
   * **Prompt:** *“premium still‑life of fruits, grains, and water bottle arranged on dark matte surface, soft top light, teal highlight, clean modern, 3:2 aspect, no labels”*.

8. **Card – Find a Coach**

   * **Size:** 900×600 px.
   * **Prompt:** *“retro‑modern stamp‑style illustration of a whistle and clipboard, duotone navy and teal, textured grain, centered icon, 3:2 aspect, no text”*.

### Asset List (Assessments)

9. **Test Icon – Vertical Jump**

   * **Size:** 256×256 px (monochrome).
   * **Prompt:** *“line icon of figure jumping with upward arc and tick marks, simple strokes, rounded ends, blue‑teal gradient fill, transparent background”*.

10. **Test Icon – Push‑ups**

* **Size:** 256×256 px.
* **Prompt:** *“line icon of person doing push‑up, side view, rounded strokes, minimal, transparent background”*.

11. **Test Icon – Shuttle 20m**

* **Size:** 256×256 px.
* **Prompt:** *“icon of two cones with 20m line between, perspective minimal, blue accent, transparent”*.

12. **Empty State – No Results Yet**

* **Size:** 1200×900 px (4:3).
* **Prompt:** *“friendly minimal illustration of empty clipboard and stopwatch on a dark desk, soft blue glow, spacious composition, no text, 4:3”*.

### Asset List (Progress)

13. **Header Art – Progress Overview**

* **Size:** 1200×400 px.
* **Prompt:** *“abstract flowing lines forming a speed graph, neon blue on deep navy, subtle glow, no numbers, panoramic 3:1 banner”*.

14. **Badge – Consistency Streak**

* **Size:** 512×512 px (PNG with alpha).
* **Prompt:** *“award badge icon with calendar and lightning bolt, modern flat, blue/teal gradient, soft inner shadow, transparent background”*.

15. **Badge – Clean Form**

* **Size:** 512×512 px.
* **Prompt:** *“shield icon with checkmark and posture line, sleek minimal, blue gradient, transparent background”*.

### Asset List (Settings/Profile)

16. **Digital Athlete ID QR Background**

* **Size:** 1080×1080 px.
* **Prompt:** *“subtle patterned navy background with diagonal micro‑grid and faint teal glow center, square, no text, wallpaper style”*.

### Generic Prompt Template

```
Generate a [style: e.g., semi‑real editorial / minimal vector / icon] image of [subject], on a deep navy background, with blue/teal accents, no text, clean modern composition. Aspect [WxH px].
```

### Densities & Export

* **Android:** mdpi (@1x), hdpi (1.5x), xhdpi (2x), xxhdpi (3x).
* **iOS:** @2x, @3x.
* **Compression:** WebP quality 80–90; maintain transparency for icons/badges.

### File Naming

`home_hero_next_challenge@3x.webp`, `tile_shuttle_square@2x.webp`, `icon_vertical_jump_256.png`, `badge_consistency_512.png`.
