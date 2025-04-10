# CS1023-Final-Project

Perfect — that changes everything again, **in a good way** 😄

If you’re comfortable with **both Java and OCaml**, here’s a breakdown of what I’d recommend and how you can realistically tackle **both projects** for bonus points **without losing your mind during exams**.

---

### 🎯 Goal: Finish both projects in 15–20 days
**With a priority on Project 2 (MiniML) for the bonus boost + originality.**

---

## 📌 Recommended Strategy

### ✅ **Step 1: Finish Project 1 (Java Arithmetic Library) in 5–6 days**

This one is:
- Conceptually easier
- Mostly implementation + testing + minor documentation
- No new tools to learn
- You can chip away at it when you're brain-dead after studying

✔️ **Aim**:
- Finish the logic and basic tests in 3–4 days
- Spend 1–2 days polishing the CLI + report + documentation
- Tag your Git appropriately at stages (this is a requirement!)

---

### ✅ **Step 2: Focus Majority of Time on Project 2 (MiniML) — 10–14 days**

This is:
- Heavier conceptually
- More rewarding
- More unique → better bonus points, better to show off

✔️ **Why it’s smart to leave more time here**:
- You’ll need to modify parsing (Menhir), the AST, the machine, and the compiler
- Testcases for exception handling can get tricky
- You'll need to work with the OCaml tooling (dune, build scripts)
- The LaTeX report takes time if you want it polished

---

## 🗓️ Suggested 2-Project Schedule

| Day Range  | Task                                      | Notes |
|------------|-------------------------------------------|-------|
| Day 1–2    | Project 1: Plan classes, start `BigInteger` ops | Don’t overdesign — get core logic working |
| Day 3–4    | Project 1: Finish arithmetic, handle edge cases | Add CLI + basic tests |
| Day 5      | Project 1: Report writing + Git polish     | Submit / move to MiniML |
| Day 6–7    | Project 2: Fork + understand MiniML project | Run sample code, understand the evaluation pipeline |
| Day 8–9    | Project 2: Modify `parser.mly`, `lexer.mll`, `syntax.ml` | Add `try ... with ...` and new exception types |
| Day 10–11  | Project 2: Add `IRaise` / `IHandle` to `machine.ml` | Start seeing output from simple programs |
| Day 12     | Project 2: Add typing rules + compile logic (`compile.ml`) | Handle typechecker updates |
| Day 13–14  | Project 2: Write testcases (good + failing), finalize Python CLI | Integrate with `miniml.ml`, test build system |
| Day 15+    | Project 2: Polish report (LaTeX), add commit logs, snapshot test runs | Final wrap-up + submission |

---

## ⏱️ Exam Days?

You can shift low-effort tasks like:
- Writing testcases
- Typing out the report
- Tagging commits
- Running pre-written testcases
...to your low-energy/exam-prep days.

OCaml debugging and parser/machine changes should be scheduled when you're fresh.

---

## 🎁 Extra Bonus Tips

- **For Project 1:**
  - Make sure to include division and modulo properly.
  - Include testcases that overflow a normal `int`.

- **For Project 2:**
  - Try catching division-by-zero in a test like:
    ```ocaml
    try (10 / 0) with x -> "caught"
    ```
  - Test unhandled exceptions too.
  - Add 1–2 testcases where `try ... with` nests inside expressions.

---

## ✅ Verdict

Since you already know OCaml + Java, and you’re motivated for bonus points:

**Yes, do both. But plan tightly. Prioritize Project 2. Use Project 1 as your warm-up.**  
You’ll walk out of this with two solid projects, and probably impress your instructor too.

Want help planning the MiniML exception implementation files (like parser rules, AST extension, or how to do `IRaise`/`IHandle`)? I can break it down file by file if you’d like.