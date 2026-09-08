# Wiki log

Append-only. Prefix: `## [YYYY-MM-DD] <kind> | <title>`

## [2026-09-08] design | Spec written — Warthog spoof remapper

- User approved D5 Warthog stick + dual throttle design.
- Formal spec: `docs/superpowers/specs/2026-09-08-nvs-warthog-spoof-remapper-design.md` (not yet committed — awaiting your review).
- Next after your OK: implementation plan (writing-plans).

## [2026-09-08] design | D5 Warthog stick + dual throttle spoof

- User: spoof Thrustmaster Warthog Flight Stick and Dual Throttle for joystick and throttle quadrant.
- Sinks: `044F:0402` + `044F:0404`; Xbox path demoted to fallback.
- Pages: `design/remapper.md`, `decisions.md` (D5), requirements; raw IDs note; diagrams regenerated.

## [2026-09-08] design | D4 remap HID Joystick → GFN Xbox class

- User: remap standard HID joystick to an accepted class for GeForce NOW.
- Locked Mac-native path: Orion Joystick HID → virtual Xbox 360–compatible HID → GFN.
- Pages: `design/remapper.md`, `design/decisions.md` (D4), requirements/architecture refresh; diagrams regenerated.

## [2026-09-08] query | X-Plane Mac WinCTRL HID path

- Probed attached **WINWING Orion Joystick Base 2 + JGRIP-F16** (`0x4098:0xBEA8`, IOKit Joystick usage 4).
- Documented dual path: XP built-in joystick stack for axes; optional `winctrl` plugin for panel/HID protocol.
- Implication: Mac can read the stick without Windows; GFN still won't forward that raw joystick.
- Pages: `queries/xplane-mac-winctrl-hid.md`, `raw/sources/2026-09-08-mac-orion-hid-probe.md`

## [2026-09-08] query | Mac without Windows?

- Filed `wiki/queries/mac-without-windows.md`: ViGEm needs Windows; Mac-native virtual HID is plausible but unverified for GFN+WinCTRL; kb/mouse is limited fallback.
- Extended Q5 with option D (Mac-native only).

## [2026-09-08] design | D3 skip MobiFlight (Mac)

- User: MobiFlight cannot run on Mac — skip it for v1.
- Amended D1; added D3; requirements/architecture now GFN XInput bridge only.
- Regenerated Archify overview (MF path removed); visual-check pass.
- Raised Q5: Windows PC vs Mac+VM for ViGEm host.
- Pages touched: `design/*`, `overview.md`, `diagrams/hybrid-system-overview.*`, `log.md`

## [2026-09-08] diagram | Archify hybrid overview + GFN sequence

- Delivered showcase HTML: `wiki/diagrams/hybrid-system-overview.html`, `wiki/diagrams/gfn-xinput-sequence.html` (9/9 checks, 0 composition errors).
- Browser evidence: both `visual-check` **pass** (containment/readability/viewer chrome); perceptual review still pending human glance.
- Design pages: `design/requirements.md`, `design/architecture.md`; decisions D1+D2 locked.
- Pages touched: `design/*`, `diagrams/*`, `index.md`, `overview.md`

## [2026-09-08] design | D1 Hybrid (Q1 → C)

- User chose **C**: GFN best-effort inputs + local MSFS/MobiFlight for full panels.
- Filed [design/decisions.md](design/decisions.md); expanded [approaches/hybrid-options.md](approaches/hybrid-options.md) (Options 1–3, recommend XInput-first).
- Pages touched: `design/decisions.md`, `design/open-questions.md`, `approaches/*`, `overview.md`, `index.md`

## [2026-09-08] ingest | Initialize Karpathy LLM wiki + research seed

- Created `AGENTS.md`, `.cursor/rules/read-agents-md.mdc`, `raw/`, `wiki/` per Karpathy LLM Wiki pattern.
- Snapshotted Karpathy gist into `raw/sources/karpathy-llm-wiki.md`.
- Ingested GFN HOTAS whitelist + XInput workaround research; MobiFlight WASM/SimConnect + WinCTRL HID research.
- Seeded overview, entities, concepts, feasibility gates, open questions (Q1 blocking), approach stubs.
- Pages touched: `wiki/overview.md`, `wiki/index.md`, `wiki/log.md`, `wiki/entities/*`, `wiki/concepts/*`, `wiki/constraints/feasibility-gates.md`, `wiki/design/open-questions.md`, `wiki/approaches/candidates.md`, `raw/sources/*`
