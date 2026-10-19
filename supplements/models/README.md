# Simulation models: where distributions come from

Specifications, written 2026-10-19, for review before building. **Model 3 is
built and verified** as `same_field_two_ways.nlogox`; the rest are specs.

These back Supplement 02, *Where distributions come from*. Lecture 12 teaches
which distribution to use and what each shape looks like; it never shows the
process that produces the shape. A student who has seen random placement turn
into a Poisson does not have to memorize that counts are Poisson.

## The design rule everything follows

**Every slider is a biological quantity, not a distribution parameter.**

Do not give them a slider labeled `size`. Give them one labeled *covey size*,
and let them watch `size` change as a consequence. The moment an abstract
parameter becomes the result of something they can picture is the moment it
stops feeling arbitrary. If a slider cannot be named in biology, it probably
should not be on the interface.

Two consequences:

- Each model should make **one** mechanism visible. Resist adding a second.
- Every model needs a setting where the **simpler distribution reappears**:
  covey size 1, habitat variation 0. That the Poisson falls out as a special
  case is the point, not a detail.

## How these reach the students

Verified 2026-10-19. Students install nothing; it runs in the browser.

```html
<iframe src="https://netlogoweb.org/web?url=https://raw.githubusercontent.com/bmaitner/biometry_course/main/supplements/models/seeds.nlogox"
        width="700" height="600"></iframe>
```

- **CORS**: `raw.githubusercontent.com` returns `Access-Control-Allow-Origin: *`,
  which is what NetLogo Web requires. Models can live in this repository and be
  embedded immediately. GitHub Pages is **not** a prerequisite.
- **Version pinning**: `https://netlogoweb.org/versions/2.15.0.html?url=...`
  pins a build instead of tracking latest, so an embed does not change behavior
  under us. Use it.
- **If the dependency on netlogoweb.org is unwanted**: NetLogo Web can export a
  model as a standalone HTML file we host ourselves, which removes the runtime
  dependency entirely. Worth doing if an embed is ever used in class rather
  than only in a self-paced supplement.
- **Not every NetLogo primitive runs in NetLogo Web.** Each model has to be
  loaded and checked, not assumed.

**Verified for Model 3, 2026-10-19**, in both mechanisms, with no console
errors: on desktop NetLogo 7.0.4 headless, on NetLogo Web latest (`/web`), and
on the pinned build (`/versions/2.15.0.html`). The pinned build also renders
inside an iframe, and none of the three URL forms sends a frame-blocking header.
`random-gamma`, the `while` loop and the recursive plot pens all survive the
browser. At default speed a run takes about a minute, which suits watching it;
the speed slider goes faster.

The embed to use in the supplement is the pinned one:

```html
<iframe src="https://netlogoweb.org/versions/2.15.0.html?url=https://raw.githubusercontent.com/bmaitner/biometry_course/main/supplements/models/same_field_two_ways.nlogox"
        width="1100" height="560"></iframe>
```

## Running a model headlessly on Windows

`netlogo-headless.bat` breaks when `JAVA_HOME` contains a space, which it always
does under Program Files. Call the bundled Java directly instead:

```bash
"C:/Program Files/NetLogo 7.0.4/runtime/bin/java.exe" \
  -XX:MaxRAMPercentage=50 -Dfile.encoding=UTF-8 \
  --add-exports=java.base/java.lang=ALL-UNNAMED \
  --add-exports=java.desktop/sun.awt=ALL-UNNAMED \
  --add-exports=java.desktop/sun.java2d=ALL-UNNAMED \
  -classpath "C:/Program Files/NetLogo 7.0.4/app/netlogo-7.0.4.jar" \
  org.nlogo.headless.Main \
  --model supplements/models/same_field_two_ways.nlogox \
  --experiment verify --table - --threads 1
```

Each model carries a `verify` experiment whose expected results are recorded
under that model below, so a change that breaks the biology shows up as a number
that moved.

## The pairing with R

NetLogo and R do different jobs here, and the supplement alternates:

| | Answers |
|---|---|
| **NetLogo, embedded, watch** | what *is* this process, and what do the parameters do |
| **R, type and run** | how do I use it, on my own data |

The R half is what transfers to the final project. The NetLogo half is what
makes the R half feel inevitable rather than arbitrary.

---

# Model 1: Occupancy

**Produces:** binomial

**Agents:** patches, one per Breeding Bird Survey route.

**Setup:** `n-routes` patches, all unoccupied.

**Go:** one tick is one survey. Each route independently becomes occupied with
probability `detection-probability`. Count how many are occupied, record it,
reset.

**Sliders:** `detection-probability` (0 to 1), `n-routes` (10 to 120).

**Plots:** histogram of routes occupied per survey, with the binomial overlaid.
Monitors for mean and variance.

**What they should notice:** the peak sits at n times p. The spread grows with
n. Near p of 0 or 1 the distribution squashes against the edge and stops looking
symmetric.

**Hook:** this is the Lecture 16 occupancy model. 52 of 71 routes in 2019.

**R counterpart:** `rbinom(1000, size = 71, prob = 0.73)`, histogram, compare.

---

# Model 2: Seeds in quadrats

**Produces:** Poisson

**Agents:** seeds, falling onto a gridded field of quadrats.

**Setup:** empty 20 by 20 grid of quadrats.

**Go:** drop one seed at a **uniformly random** location. The quadrat it lands
in increments.

**Sliders:** `density` (mean seeds per quadrat, 0.5 to 20).

**Plots:** histogram of quadrat counts, Poisson overlaid. Monitors for mean,
variance, and **variance / mean**.

**What they should notice:** variance over mean sits near 1 wherever the density
slider is. That is the Poisson's testable claim, and it is the check they
already run on real data. At low density the shape is right-skewed with a spike
at zero; at high density it becomes symmetric, which is the normal
approximation appearing on its own.

**Assumption to make visible:** seeds are placed independently and the field is
uniform. Model 3 breaks each of those in turn.

**R counterpart:** `rpois()`, and `var(x) / mean(x)`.

---

# Model 3: The same field, two ways

**Produces:** negative binomial. **Build this one first.**

One model, with a chooser for `mechanism`.

### Mechanism A, "clumped"

**Go:** pick a random location for a covey. Drop `covey-size` birds around it
with a small scatter.

**Slider:** `covey-size` (1 to 25). **At 1, the Poisson reappears.**

### Mechanism B, "variable habitat"

**Setup:** every quadrat draws its own quality from a gamma with mean 1, spread
set by `habitat-variation`.

**Go:** each quadrat receives Poisson(quality times density) birds.

**Slider:** `habitat-variation` (0 to 2). **At 0, every quadrat is identical and
the Poisson reappears.**

### Both

**Plots:** histogram of quadrat counts, with Poisson and negative binomial
overlaid. Monitors for variance / mean and the fitted `size`.

**What they should notice, and this is the headline:** both mechanisms push
variance over mean above 1, and at matched settings (covey size 12, habitat
variation 1.4) they give the same variance over mean, near 7. The bobwhite data
have variance over mean near 10, and that number alone cannot tell you whether
bobwhite travel in coveys or whether some routes are simply better.

**Corrected after running the model, 2026-10-19.** The spec originally said the
two mechanisms produce *the same distribution*. They do not, quite. Variable
habitat is exactly negative binomial (gamma-Poisson is the textbook derivation),
and its zero class matches: 151 empty quadrats against about 149 predicted.
Clumping leaves about 200 empty, a third more than a negative binomial with the
same mean and variance allows. The fitted negative binomial line visibly misses
the zero bar under clumping and sits on it under variable habitat, so the model
shows this without extra work.

That is a better lesson than the one specified: variance over mean cannot
separate the mechanisms, the shape carries a weak signal, and with real sample
sizes and both mechanisms acting at once, telling them apart needs different
data rather than a better fit.

**Expected `verify` results** (5 reps, mean 3 per quadrat): variance / mean
near 1.0 for covey size 1 and for habitat variation 0; near 6.8 for covey size
12; near 3.9 for habitat variation 1, against 4.0 from theory. Covey size 12 is
matched by habitat variation **1.4**.

**R counterpart:** simulate both, fit `dnbinom` to each, and compare the fitted
zero class with the observed one, which is where the two mechanisms differ.

---

# Model 4: Waiting for the next detection

**Produces:** exponential, and gamma

**Agents:** an observer on a timeline.

**Go:** each small time step, an event occurs with a small constant
probability. Mark it. Record the gap since the previous event.

**Sliders:** `detection-rate`, `events-to-wait-for` (k, 1 to 10).

**Plots:** histogram of gaps, exponential overlaid when k is 1, gamma when
k is above 1.

**What they should notice:** with k at 1 the commonest gap is a short one, which
surprises people. And the memorylessness: a monitor showing "expected additional
wait, given you have already waited this long" that does not change as the wait
grows. That is worth a slider of its own if it can be made to read clearly.

**R counterpart:** `rexp()`, `rgamma()`, and the gaps in a simulated event
series.

---

# Model 5: Adding against multiplying

**Produces:** normal, and lognormal

**Agents:** `n-individuals`, each starting at the same value.

**Go:** each tick, every individual experiences one random effect.

- chooser `add`: the value **gains** a small random amount
- chooser `multiply`: the value is **scaled** by a small random factor

**Sliders:** `effect-size`, `n-effects` (ticks elapsed).

**Plots:** histogram of values. A second histogram of the **log** of the values.

**What they should notice:** the same effects, with one operator changed, give a
symmetric distribution or a right-skewed one. And the log of the multiplicative
case is symmetric, which is the definition of lognormal made visible rather than
stated.

**Hook:** growth is multiplicative. A 10% gain on a large animal is more grams
than on a small one. That is why every body mass in this course, in AVONET and
in the amniote database, is right-skewed, and why logging it works.

**R counterpart:** `cumsum` against `cumprod` of the same random draws.

---

## Build order

1. **Model 3**, because the two-mechanisms lesson is the best content here and
   it is the one that explains the data they have used all semester.
2. **Model 5**, because it explains every logged axis in the course.
3. **Model 2**, which Model 3 needs as its baseline anyway.
4. Models 1 and 4 last; both are useful, neither is surprising.

## Open questions for review

- Are the clumping and habitat mechanisms in Model 3 stated in a way a field
  ecologist would accept, or are they too stylized?
- Is the gamma-distributed quality in Mechanism B worth showing explicitly, or
  should it stay under the hood as "quadrats differ"?
- Model 4's memorylessness monitor may be more confusing than useful. Cut it?
- Is 20 by 20 quadrats the right grain, given the bobwhite data are routes
  rather than quadrats?
