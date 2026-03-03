# PH 280 Project 7: Learning from Data - AI Assessment Rubric

**Course**: PH 280 - Computational Physics
**Assignment**: Project 7: Learning from Data
**Criterion Weights**: Abstract & Description 10%, Algorithm & Discussion 20%, Implementation/Code 40%, Results 20%, Conclusion 10%

---

## Critical Standards (Applied Throughout Assessment)

### 1. Precision-Uncertainty Alignment (Conceptual Error)

**Definition**: When a student reports a fitted parameter with uncertainty, the reported precision must match the precision implied by the uncertainty.

**Example of correct alignment**:
- ✅ `slope = -0.40 ± 0.01` (both to hundredths)
- ✅ `A = 1.25 ± 0.03` (both to hundredths)

**Example of misalignment** (CONCEPTUAL ERROR):
- ❌ `slope = -0.40384726 ± 0.01` (8 extra digits beyond uncertainty)
- ❌ `A = 1.2523847 ± 0.03` (false precision)

**Assessment Rule**:
- If precision-uncertainty mismatch exists, rate as **"Developing"** (not Good, not Excellent)
- This is a **conceptual error**, not a formatting issue
- Severity: If >3 extra digits of false precision, consider lowering overall criterion rating
- Apply this check to: Abstract, Results, and Conclusion sections

---

### 2. Uncertainty Source (Critical for Excellent)

**Definition**: When a student states parameter uncertainty (±X), they must explain HOW they estimated it.

**Valid sources** (student must reference one):
- Covariance matrix from `curve_fit`: `uncertainty = sqrt(pcov[i,i])`
- Monte Carlo bootstrap: generate synthetic data, refit many times, compute std of parameters
- Both approaches used and compared

**Assessment Rule**:
- **For Excellent**: Uncertainty must be stated with explicit source explanation
  - Not just "±0.01" but "±0.01, from the square root of the covariance matrix diagonal returned by curve_fit"
  - Should appear in Results section with detail; can be summarized in Abstract/Conclusion
- **For Good**: Can state uncertainty without source
- **For Developing**: No uncertainty stated, or uncertainty stated without any source

---

### 3. Attributions Required

**Definition**: Student must acknowledge all external help, resources, and collaborations.

**What to check**:
- Other students discussed with?
- Dataset source cited?
- Resources consulted (books, websites, AI, etc.)?
- Help from faculty/TAs?

**Assessment Rule**:
- Deduct 1-2 points if attributions completely missing
- Dataset source citation is required; missing it should be flagged
- Note in feedback if present and thorough

---

## Detailed Criterion Assessment

### Criterion 1: Abstract & Description (10%)

**Purpose**: Student clearly introduces what data they used, what model they chose, and what they found.

#### Performance Levels

| Level | Range | Description |
|-------|-------|-------------|
| **Excellent** | 65-100% | Dataset clearly identified with source; Model choice stated; Main result (parameter values) with units AND uncertainty; Significance briefly explained |
| **Good** | 35-65% | Dataset described; model mentioned; result present; brief significance |
| **Developing** | 0-35% | Dataset vague or missing; model not stated; result missing or no uncertainty; no significance |

#### Red Flags (Significant Deductions)

- Callout boxes from template still present: Major deduction
- Dataset not identified or no source: Significant deduction
- No model stated: Significant deduction
- Parameters reported without uncertainty: Significant deduction
- Precision-uncertainty mismatch: Rate as Developing

#### Assessment Guidance

**Excellent indicators**:
- Names the dataset and source (e.g., "earthquake frequency data from USGS")
- States the model (e.g., "power law: y = A x^n" or "linear fit in log-log space")
- Reports parameters with ± and units (e.g., "slope = -0.40 ± 0.01")
- Explains briefly why this data/model is interesting

**Good indicators**:
- Dataset described, source mentioned
- Model named
- Main result stated (uncertainty optional but preferred)

**Developing indicators**:
- Dataset vague or unnamed
- Model not described
- Result missing or meaningless
- Precision-uncertainty mismatch

---

### Criterion 2: Algorithm & Discussion (20%)

**Purpose**: Student demonstrates understanding of the fitting process—what they're doing computationally and why.

#### Performance Levels

| Level | Range | Description |
|-------|-------|-------------|
| **Excellent** | 65-100% | Model function stated with mathematical form; Justification for model choice given; How `curve_fit` works explained (minimizing chi-squared or sum of squared residuals); How uncertainty is estimated explained (pcov diagonal or Monte Carlo bootstrap); Any log transformations explained and motivated |
| **Good** | 35-65% | Model described; some justification; fitting approach explained adequately; uncertainty approach mentioned |
| **Developing** | 0-35% | Model vague or missing; no justification; fitting approach not explained; uncertainty approach absent |

#### Red Flags (Significant Deductions)

- Callout boxes from template still present: Major deduction
- No mathematical form of model: Significant deduction
- No explanation of how fitting works: Significant deduction
- No discussion of uncertainty estimation method: Significant deduction
- Log-log transformation used but not explained: Significant deduction

#### Assessment Guidance

**Excellent indicators**:
- Mathematical model written out: e.g., "$y = A x^n$" or "$\log y = n \log x + \log A$"
- Explanation of why this model: e.g., "Power laws appear in many natural frequency distributions, and the log-log plot of my data appears linear, suggesting a power law"
- Explanation of `curve_fit`: "minimizes the sum of squared residuals between model and data"
- Uncertainty method: "Uncertainty estimated as the square root of the diagonal of the covariance matrix `pcov` returned by `curve_fit`" or "Monte Carlo bootstrap: I generated 1000 synthetic datasets with the same noise statistics and refitted each one; the standard deviation of the fit parameters gives the uncertainty"
- If log transformation used: explains that fitting is done in log-log space and describes any consequences

**Good indicators**:
- Model described (even if not mathematically formal)
- Reasonable justification for model choice
- Fitting process described in reasonable terms
- Uncertainty method mentioned

**Developing indicators**:
- Model not described or vague
- No justification for model choice
- Fitting process not explained
- Uncertainty method absent

---

### Criterion 3: Implementation/Code (40%)

**Purpose**: Code is correct, readable, and demonstrates that the student actually implemented the fitting correctly and validated the results.

#### Performance Levels

| Level | Range | Description |
|-------|-------|-------------|
| **Excellent** | 65-100% | Data loaded and shown in exploratory plot; Model function defined correctly; `curve_fit` called correctly with appropriate initial guesses; Uncertainties extracted correctly from `pcov` diagonal (or Monte Carlo); Fitted model overlaid on data; Code readable with semantic names; Validation present (residuals, goodness of fit, or comparison to known values) |
| **Good** | 35-65% | Data loaded; model defined; `curve_fit` used; uncertainties extracted; plot present; code mostly readable; some validation |
| **Developing** | 0-35% | Data loading missing or broken; model defined incorrectly; `curve_fit` misused; uncertainties not extracted or wrong; no validation |

#### Red Flags (Significant Deductions)

- Callout boxes from template still present: Major deduction
- `pcov` diagonal not used for uncertainty (or Monte Carlo not shown): Significant deduction
- `curve_fit` called with wildly wrong initial guesses causing fit to fail: Significant deduction
- No plot of data with fitted model overlaid: Significant deduction
- No validation of fit: Significant deduction
- Poor variable names AND minimal comments: Significant deduction

#### Assessment Guidance

**Excellent indicators**:
- Data loading with exploratory plot showing raw data
- Model function defined as Python function: `def model(x, A, n): return A * x**n`
- `curve_fit` called correctly: `popt, pcov = curve_fit(model, xdata, ydata, p0=[...])`
- Uncertainties extracted: `sigma_A = np.sqrt(pcov[0,0])`, `sigma_n = np.sqrt(pcov[1,1])`
- Or Monte Carlo bootstrap: generate synthetic data, refit many times, compute std
- Fitted model overlaid on data in clear plot
- Validation: residuals plotted, chi-squared computed, or comparison to literature values
- Semantic variable names: `xdata`, `ydata`, `popt`, `fitted_slope` rather than `x1`, `y2`, `p`, `s`
- Code structure is clear with narrative interspersed

**Good indicators**:
- Data loaded, model defined, curve_fit used
- Uncertainties extracted (even if method not fully explained)
- Plot with data + model
- Some validation attempted
- Code is readable

**Developing indicators**:
- Data not loaded or broken
- Model defined incorrectly
- `curve_fit` misused or parameters not extracted
- Uncertainties missing or wrong
- No validation

#### Code Quality Philosophy

- **Prefer semantic names over comments**: `fitted_slope` and `slope_uncertainty` need no comments
- **Comments only when logic is non-obvious**: Explain non-trivial choices, not what is already clear
- **Example of clean fitting code**:
  ```python
  def power_law(x, A, n):
      return A * x**n

  popt, pcov = curve_fit(power_law, xdata, ydata, p0=[1.0, -1.0])
  A_fit, n_fit = popt
  A_unc, n_unc = np.sqrt(np.diag(pcov))
  ```
  This needs minimal comments because naming and structure are clear.

---

### Criterion 4: Results (20%)

**Purpose**: Student presents fitted parameters clearly, validates the model, and interprets the physical meaning.

#### Performance Levels

| Level | Range | Description |
|-------|-------|-------------|
| **Excellent** | 65-100% | Plot of data + fitted model, clearly labeled; Parameters stated with units and ±; Precision matches uncertainty; Uncertainty source explained; Residuals or goodness-of-fit discussed; Physical interpretation of parameters provided; Comparison to known values if available |
| **Good** | 35-65% | Plot present; parameters stated with ±; reasonable precision; some interpretation; brief validation |
| **Developing** | 0-35% | No plot or indecipherable; parameters missing or no uncertainty; precision-uncertainty mismatch; no interpretation; no validation |

#### Red Flags (Significant Deductions)

- Callout boxes from template still present: Major deduction
- **Precision-uncertainty mismatch**: Rate as Developing
  - e.g., `slope = -0.40384726 ± 0.01` — 7 extra digits of false precision
- Plot axes missing labels or units: Deduction per axis
- Parameters stated without units: Significant deduction
- No validation of fit quality: Significant deduction
- Uncertainty stated but source not explained: Significant deduction

#### Assessment Guidance

**Excellent indicators**:
- Plot: data as points, fitted model as curve, both clearly labeled with legend
- Parameters: "Slope $n = -0.40 \pm 0.01$, amplitude $A = e^{10.25 \pm 0.08}$" (units where applicable)
- Precision matches uncertainty: `-0.40 ± 0.01`, not `-0.4038472 ± 0.01`
- Uncertainty source: "estimated from square root of covariance matrix diagonal" or "standard deviation of 1000 Monte Carlo bootstrap fits"
- Validation: "Residuals (Figure 3) show no systematic pattern, suggesting the power-law model is appropriate" or "Chi-squared per degree of freedom is near 1, indicating good fit"
- Interpretation: "The exponent -0.40 indicates a moderately steep power-law decline; this is consistent with Zipf's law predictions for file size distributions"
- Comparison to known values if available: "Literature reports exponents between -0.3 and -0.5 for similar distributions, consistent with our result"

**Good indicators**:
- Plot present and mostly clear
- Parameters with ± stated
- Reasonable precision
- Some interpretation
- Brief validation

**Developing indicators**:
- Plot missing or unlabeled
- Parameters missing uncertainty
- Precision-uncertainty mismatch
- No interpretation
- No validation

---

### Criterion 5: Conclusion (10%)

**Purpose**: Student summarizes findings, reflects on learning, and completes academic integrity.

#### Performance Levels

| Level | Range | Description |
|-------|-------|-------------|
| **Excellent** | 65-100% | Main result restated with parameters and ±; Reflection on what was learned about data fitting and uncertainty; Statement about whether model described data well; Attributions present (dataset source, collaborators, AI, resources); Precision matches uncertainty (consistent with abstract/results) |
| **Good** | 35-65% | Result stated; brief reflection; attribution mentioned; reasonable precision |
| **Developing** | 0-35% | Result vague or missing; no reflection; no attribution; precision-uncertainty mismatch |

#### Red Flags (Significant Deductions)

- Callout boxes from template still present: Major deduction
- Result not stated or vague: Significant deduction
- No reflection on learning: Significant deduction
- Precision-uncertainty mismatch: Rate as Developing
- Attributions missing entirely: Significant deduction
- Dataset source not cited anywhere in the report: Significant deduction

#### Assessment Guidance

**Excellent indicators**:
- Result restated: "The power-law fit gives slope $n = -0.40 \pm 0.01$, with uncertainty from the covariance matrix"
- Precision-uncertainty alignment consistent with Abstract/Results
- Genuine reflection: "I learned that `curve_fit` is sensitive to initial parameter guesses, and that the covariance matrix provides a quick but assumption-dependent estimate of uncertainty"
- Project success addressed: "The residuals show no systematic trend, confirming the power-law is a good model for this data in the range tested"
- Attribution section: "Data from [source]; discussed approach with [name]; used AI for [specific task]; consulted [resource]"

**Good indicators**:
- Result stated with ±
- Brief learning reflection
- Some attribution
- Reasonable precision

**Developing indicators**:
- Result vague or missing
- No learning reflection
- No attribution
- Precision-uncertainty mismatch

---

## Criterion Weights

| Criterion | Weight | Developing | Good | Excellent |
|-----------|--------|-----------|------|-----------|
| Abstract & Description | 10% | 0-35% | 35-65% | 65-100% |
| Algorithm & Discussion | 20% | 0-35% | 35-65% | 65-100% |
| Implementation/Code | 40% | 0-35% | 35-65% | 65-100% |
| Results | 20% | 0-35% | 35-65% | 65-100% |
| Conclusion | 10% | 0-35% | 35-65% | 65-100% |
| **TOTAL** | **100%** | | | |

---

## Key Assessment Principles

1. **Correctness first**: The fitting must be implemented correctly. Both Good and Excellent require `curve_fit` used properly and uncertainties extracted correctly. The matrix/SVD approach is an optional alternative for students who want to explore the underlying mathematics.

2. **Uncertainty source is required for Excellent**: Numbers with ±X are only Excellent if they explain where the estimate came from (pcov diagonal or Monte Carlo bootstrap).

3. **Precision-Uncertainty is conceptual**: Mismatches are not formatting errors—they indicate misunderstanding of what uncertainty means.

4. **Validation is independent verification**: Not just "the code ran" but actual evidence the model fits the data (residuals or comparison to known values).

5. **Model justification matters**: Students should explain WHY they chose their model, not just that they did.

6. **Code quality over comments**: Semantic naming + clear structure > poor names + many comments. Incentivize good design.

7. **Dataset citation is required**: Missing data source is an academic integrity concern.

8. **Attributions are integrity**: Missing acknowledgments should be noted.

---

**Last Updated**: February 2025
**Version**: PH 280 Project 7 (Learning from Data) - AI Assessment Edition
