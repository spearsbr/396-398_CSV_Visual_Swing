# PH 280 - Computational Physics
# AI Feedback Guidance - Project 7: Learning from Data

> **IMPORTANT**: This file has TWO parts:
> - **Part I**: General guidance applied to ALL criteria
> - **Part II**: Specific guidance for EACH individual criterion

---

# PART I: GENERAL GUIDANCE

## Course Context

**Course**: PH 280 - Computational Physics
**Assignment**: Project 7: Learning from Data
**Type**: Computational Methods Project

### Learning Objectives

Students are learning to:
- Obtain and explore real-world data
- Propose a parameterized mathematical model appropriate for their data
- Use `scipy.optimize.curve_fit` to fit model parameters to data
- Extract parameter uncertainties from the covariance matrix or via Monte Carlo bootstrap
- Validate that the fitted model describes the data well
- Report fitted parameters with appropriate precision and uncertainty

### Assignment Overview

In Project 7, students find a dataset of their choosing from the internet, propose a model function, fit the parameters using `curve_fit`, and report results with uncertainty estimates. The course notebook introduces power law distributions (Zipf's Law) as a motivating example, but students may use any reasonable parameterized model (linear, exponential, polynomial, power law, etc.).

Key tools demonstrated in the notebook:
- `scipy.optimize.curve_fit` for nonlinear least-squares fitting
- Extracting uncertainties from `pcov` (covariance matrix diagonal)
- Monte Carlo bootstrap for uncertainty estimation
- SVD-based linear regression (optional matrix approach)

---

## Feedback Philosophy

### Tone and Style
- **Encouraging**: Frame mistakes as learning opportunities. Data fitting is genuinely hard.
- **Specific**: Reference exact figure numbers, code sections, or parameter values.
- **Actionable**: Provide concrete steps students can take to improve.
- **Balanced**: Identify strengths before suggesting improvements.
- **Technical**: Use appropriate terminology (covariance matrix, residuals, chi-squared, bootstrap).

### What Excellent Work Looks Like

Exemplary work in this project demonstrates:
- A dataset that clearly has interesting structure worth modeling
- A model function motivated by physical or mathematical reasoning
- Correct use of `curve_fit` with appropriate initial guesses
- Uncertainties extracted from `pcov` diagonal OR Monte Carlo bootstrap (or both)
- A clear plot with data and fitted model overlaid, properly labeled
- Parameters stated with units and ± at appropriate precision
- Validation: residuals, chi-squared, or comparison to known values
- Genuine reflection on what the fitting process revealed

### Common Student Challenges

Be particularly attentive to these frequent issues:

1. **False precision**: Reporting `slope = -0.40384726 ± 0.01` when `-0.40 ± 0.01` is correct. This is a conceptual error about what uncertainty means, not just a formatting issue.

2. **Missing uncertainty source**: Writing "slope = -0.40 ± 0.01" without explaining that ± comes from `sqrt(pcov[0,0])` or a Monte Carlo bootstrap.

3. **No validation**: Students often stop after getting a fit and don't check whether the model actually describes the data well.

4. **Poor initial guesses**: `curve_fit` can fail or converge to wrong minima with bad initial parameter guesses. Students should understand this and choose `p0` wisely.

5. **Unexplained log transformations**: Many power law fits are done in log-log space. Students should explain why this is valid and what it assumes.

6. **Missing dataset citation**: The data source must be cited. This is an academic integrity concern.

7. **No exploratory plot**: Students should show the raw data before fitting, not just the fitted result.

---

## Callout Removal Expectations

Students are required to **remove all callout boxes** from the template before submitting their report. The template uses callout boxes (`.callout-note`, `.callout-tip`, `.callout-warning`, `.callout-important`) as instructor instructions—these are not part of the report itself.

**What to check**:
- Any line starting with `::: {.callout-` that appears in the rendered report is a sign the student did not clean up
- "Instructions:" callouts in Abstract, Description, Algorithm, Code, Results, or Conclusion sections indicate incomplete work
- The "Before You Submit" callout-warning is also meant to be removed
- The introductory "Before You Begin" callout-important should be removed

**How to flag in feedback**:
- If any callout boxes remain: Major deduction in the affected criterion
- Note specifically which section still has template content: "Your Abstract section still contains the instruction callout starting with 'Write 2–3 sentences summarizing...' — please remove this before submitting."

---

## Technical Expectations

### Required Tools/Software
Students are using:
- Jupyter Notebook with Python
- `scipy.optimize.curve_fit` for parameter fitting
- `numpy` for covariance matrix handling and Monte Carlo bootstrap
- `matplotlib` for plotting
- `pandas` for data loading (typically)

### Expected Solution Structure

The typical solution includes:
1. Data loading and exploratory plot (raw data, before fitting)
2. Model function definition (as a Python function)
3. `curve_fit` call with appropriate initial guesses
4. Uncertainty extraction from `pcov` diagonal or Monte Carlo bootstrap
5. Plot of data + fitted model overlaid
6. Validation (residuals, chi-squared, or comparison to known values)
7. Reporting parameters with units and ±

### Key Technical Details Graders Should Know

**`curve_fit` usage**:
```python
popt, pcov = curve_fit(model_func, xdata, ydata, p0=[initial_guess1, initial_guess2])
```
- `popt`: array of best-fit parameters
- `pcov`: covariance matrix of parameter estimates
- `sigma_param = sqrt(pcov[i,i])` gives the 1-sigma uncertainty on parameter i

**Monte Carlo bootstrap**:
```python
param_list = []
for _ in range(1000):
    y_synthetic = y_fitted + sigma * np.random.normal(size=len(xdata))
    mc_popt, _ = curve_fit(model_func, xdata, y_synthetic, p0=popt)
    param_list.append(mc_popt[0])
uncertainty = np.std(param_list)
```

**Log-log fitting for power laws**:
- Transform: take log of both x and y
- Fit a linear model to log-log data
- The slope gives the power-law exponent
- The intercept gives log(amplitude)
- Student should explain this transformation

---

## Feedback Quality Guidelines

### ❌ Avoid Vague Feedback
Bad: "Your uncertainty analysis needs improvement."

### ✅ Provide Specific, Actionable Feedback
Good: "You reported `slope = -0.40384726 ± 0.01`. The uncertainty of ±0.01 means you only know the slope to the hundredths place, so report it as `-0.40 ± 0.01`. Reporting 8 extra digits suggests a misunderstanding of what uncertainty means."

### Reference Specific Evidence
Always point to:
- Figure numbers ("Figure 2 shows the data + fit overlaid, but the axes are missing units")
- Code sections ("In cell 4, you call `curve_fit` but don't extract the covariance matrix `pcov`")
- Parameter values ("You report slope = -0.40 ± 0.01, which is good precision-uncertainty alignment")

---

# PART II: CRITERION-SPECIFIC GUIDANCE

*Each section below is extracted and used ONLY when evaluating that specific criterion.*

---

## CRITERION: Abstract & Description

### What to Evaluate

Focus on whether the student clearly introduces:
- What dataset they used (named, with source)
- What model they applied
- What their main result is (parameter values with ± and units)
- Why this is interesting or significant

### Excellence Indicators (High Scores)

Award 65-100% when:
- Dataset named and source cited (e.g., "earthquake magnitude data from USGS")
- Model stated explicitly (e.g., "power law fit: log(count) = n·log(magnitude) + b")
- Parameters given with units AND uncertainty at correct precision (e.g., "slope = -0.40 ± 0.01")
- Brief statement of significance (e.g., "Power-law behavior suggests scale-free distribution")
- Abstract is concise (2-3 sentences max)

### Common Mistakes (Point Deductions)

Watch for:
- Dataset unnamed or no source — significant deduction; flag as academic integrity concern
- Model not stated in abstract — deduct 2-3 points
- Parameters given without ± — deduct 2-3 points
- Precision-uncertainty mismatch — rate entire criterion as Developing
- Abstract too long (more than a paragraph) — minor deduction

### Red Flags (Unsatisfactory Work)

Award 0-35% if:
- Dataset is completely unidentified
- No model mentioned
- No numerical results
- Callout boxes still present

### Feedback Suggestions

**If dataset not cited**: "Please add a citation for your dataset in the Abstract or Description. Without knowing where the data came from, readers can't evaluate the work or reproduce your analysis. Something like 'Data from [URL] / [agency] / [paper]' is sufficient."

**If no uncertainty in abstract**: "Add the uncertainty to your parameter estimate in the Abstract. For example, instead of 'slope = -0.40', write 'slope = -0.40 ± 0.01 (from the covariance matrix)'. The ± makes the result scientifically meaningful."

**If precision mismatch**: "Your abstract states `slope = -0.40384726 ± 0.01`. The ±0.01 uncertainty means you only know the slope to the hundredths place—the remaining digits are not meaningful. Report it as `-0.40 ± 0.01`."

---

## CRITERION: Algorithm & Discussion

### What to Evaluate

Focus on whether the student demonstrates understanding of:
- Why their model is appropriate for their data
- How `curve_fit` works (what it's minimizing)
- How uncertainty is estimated (pcov diagonal or Monte Carlo)
- Any data transformations applied (log-log, normalization, etc.)

### Excellence Indicators (High Scores)

Award 65-100% when:
- Model written in mathematical form (e.g., "$y = A x^n$" or "$\log y = n \log x + b$")
- Justification for model: explains physical or mathematical motivation
- `curve_fit` explained: "minimizes the sum of squared residuals between the model function and the data"
- Uncertainty method clearly described:
  - PCov: "Uncertainty = $\sqrt{\text{pcov}[i,i]}$, the square root of the diagonal of the covariance matrix returned by `curve_fit`"
  - Bootstrap: "I generated 1000 synthetic datasets by adding Gaussian noise with the same standard deviation as the residuals, refitted each, and took the standard deviation of the resulting parameter distributions"
- Log transformation explained if used: "Taking log of both sides converts $y = A x^n$ to $\log y = n \log x + \log A$, which is linear in log-log space"

### Common Mistakes (Point Deductions)

Watch for:
- Model described in words only, no equation — deduct 2-3 points
- No justification for model choice — deduct 3-5 points
- `curve_fit` used but not explained — deduct 2-3 points
- Uncertainty method not explained — deduct 3-5 points
- Log transformation used but not explained — deduct 2-3 points

### Red Flags (Unsatisfactory Work)

Award 0-35% if:
- No model described at all
- No explanation of fitting process
- Uncertainty method completely absent
- Callout boxes still present

### Feedback Suggestions

**If model not mathematically stated**: "Add the mathematical form of your model to the Algorithm section. For example, if you're fitting a power law, write $y = A x^n$ or $\log y = n \log x + \log A$. This makes it clear exactly what function you're fitting."

**If no justification for model**: "Explain why you chose this model for your data. Did the log-log plot look linear (suggesting a power law)? Did you expect an exponential based on the physics? Connecting your model choice to the data shape or underlying mechanism is what separates good scientific analysis from curve-fitting without understanding."

**If uncertainty method not explained**: "Explain how you computed the ± values for your parameters. If you used `pcov` from `curve_fit`, write something like: 'The parameter uncertainties are estimated as $\sqrt{\text{pcov}[i,i]}$, the square root of the diagonal elements of the covariance matrix returned by `curve_fit`.' If you used Monte Carlo bootstrap, describe that process."

---

## CRITERION: Implementation/Code

### What to Evaluate

Focus on whether:
- Data is loaded and an exploratory plot is shown
- Model function is defined correctly as a Python function
- `curve_fit` is called correctly with reasonable initial guesses
- Uncertainties are extracted correctly from `pcov` or via Monte Carlo
- Fitted model is plotted overlaid on data
- Code is readable with meaningful variable names
- Some validation of fit quality is present

### Excellence Indicators (High Scores)

Award 65-100% when:
- Data loaded with exploratory plot showing raw data before fitting
- Model function defined: `def model(x, A, n): return A * x**n`
- `curve_fit` called with both `popt` and `pcov`: `popt, pcov = curve_fit(model, x, y, p0=[...])`
- Uncertainties extracted: `sigma_A = np.sqrt(pcov[0,0])`; or Monte Carlo bootstrap with `np.std(param_list)`
- Fitted model overlaid on data in labeled plot
- Validation: residuals plotted OR chi-squared computed OR comparison to known values
- Semantic variable names: `x_data`, `y_data`, `slope_fit`, `slope_unc` rather than `x1`, `p1`, `s`
- Narrative interspersed with code explaining what each block does

### Common Mistakes (Point Deductions)

Watch for:
- `curve_fit` called but `pcov` not captured or not used — deduct 5-8 points
- Bad initial guesses causing fit failure or convergence to wrong minimum — deduct 3-5 points
- No exploratory plot of raw data — deduct 2-3 points
- No overlay of fitted model on data — deduct 5-8 points
- No validation of fit — deduct 5-8 points
- Single-letter variable names throughout — deduct 2-3 points

### Red Flags (Unsatisfactory Work)

Award 0-35% if:
- Data not loaded or code broken
- `curve_fit` not used (or misused)
- No uncertainties computed
- No plots
- Callout boxes still present

### Feedback Suggestions

**If pcov not used**: "You call `curve_fit` but don't capture the covariance matrix `pcov`. Change your call to `popt, pcov = curve_fit(...)` and then compute uncertainties as `sigma_A = np.sqrt(pcov[0,0])`, `sigma_n = np.sqrt(pcov[1,1])`. This gives the 1-sigma uncertainty on each parameter."

**If no validation**: "Add a validation step to show that your model actually describes the data. The simplest approach is to plot residuals: `residuals = y_data - model(x_data, *popt)`. If residuals are randomly scattered around zero with no pattern, the model fits well. If there's a systematic curve or trend in the residuals, the model may be wrong."

**If bad initial guess**: "Your fit may not have converged correctly because the initial parameter guess `p0` was far from the true values. Try plotting your model with the initial guesses first to verify they look reasonable before running `curve_fit`."

**If no exploratory plot**: "Add a plot of your raw data before any fitting. This helps the reader understand the data distribution and motivates your model choice. Something as simple as `plt.plot(x_data, y_data, 'b.')` is sufficient."

---

## CRITERION: Results

### What to Evaluate

Focus on whether:
- A plot shows data + fitted model overlaid, properly labeled
- Parameters are stated with units and ± at correct precision
- Uncertainty source is explained
- The fit quality is discussed (residuals, chi-squared, or visual inspection)
- Parameters are physically interpreted

### Excellence Indicators (High Scores)

Award 65-100% when:
- Plot: data as points, model as curve, both labeled; axes have labels with units; legend present
- Parameters stated: e.g., "slope $n = -0.40 \pm 0.01$, intercept $\log A = 10.25 \pm 0.08$"
- Precision matches uncertainty: `-0.40 ± 0.01` not `-0.4038472 ± 0.01`
- Uncertainty source identified: "from `sqrt(pcov[i,i])`" or "from Monte Carlo bootstrap standard deviation"
- Validation shown and discussed: "Residuals (Figure 3) show no systematic pattern, consistent with a good fit" or "Chi-squared per degree of freedom is 1.2, close to 1 as expected"
- Physical interpretation: "The exponent -0.40 indicates a moderately steep power-law decline; smaller files are much more common than large ones"
- Comparison to known values if available

### Common Mistakes (Point Deductions)

Watch for:
- Precision-uncertainty mismatch — rate as Developing
- Parameters without units where units apply — deduct 2-3 points per parameter
- No fit quality discussion — deduct 5-8 points
- Uncertainty source not explained — deduct 3-5 points
- No physical interpretation — deduct 3-5 points
- Plot axes unlabeled — deduct 2 points per unlabeled axis

### Red Flags (Unsatisfactory Work)

Award 0-35% if:
- No plot of data + model
- No parameter values with ±
- Precision-uncertainty mismatch throughout
- No validation of any kind
- Callout boxes still present

### Feedback Suggestions

**If precision-uncertainty mismatch**: "Your results show `slope = -0.40384726 ± 0.01`. The ±0.01 uncertainty means your slope is only known to the hundredths place—those extra digits are not meaningful. This is a conceptual point: uncertainty tells you the limit of your knowledge. Report it as `slope = -0.40 ± 0.01`."

**If no fit quality discussion**: "Add a discussion of how well the model fits the data. Plot your residuals (data minus model) — if they're randomly scattered around zero, the fit is good. If there's a systematic pattern, you may need a different model. You can also compute chi-squared per degree of freedom; a value near 1 suggests a good fit."

**If no physical interpretation**: "Explain what your fitted parameters mean physically. For a power law `y = A x^n`, the exponent `n` describes how steeply `y` falls with `x`. What does your specific value of `n = -0.40 ± 0.01` tell you about your system? Is this consistent with what you expected?"

---

## CRITERION: Conclusion

### What to Evaluate

Focus on whether:
- Main result is restated with parameters and ±
- Student reflects genuinely on what they learned
- Project success is assessed (did the model fit the data?)
- Attributions are complete (dataset source, collaborators, AI, resources)
- Precision matches uncertainty consistently with rest of report

### Excellence Indicators (High Scores)

Award 65-100% when:
- Result restated: "The power-law fit gives $n = -0.40 \pm 0.01$ and $\log A = 10.25 \pm 0.08$, with uncertainties from the covariance matrix"
- Precision-uncertainty consistent with Abstract and Results
- Genuine learning reflection: "I learned that `curve_fit` requires good initial guesses, and that the covariance matrix gives a quick uncertainty estimate that assumes Gaussian errors. The Monte Carlo approach gave similar results, which builds confidence."
- Assessment of success: "The residuals showed no systematic trend, and the power-law exponent is consistent with Zipf's law predictions, suggesting the model is appropriate."
- Complete attributions: "Data from [source URL]; discussed approach with [name]; used Claude AI to debug initial parameter guesses; consulted SciPy documentation."

### Common Mistakes (Point Deductions)

Watch for:
- Result not restated — deduct 3-5 points
- No reflection on learning — deduct 3-5 points
- Dataset source not cited anywhere in the report — significant deduction; flag as academic integrity concern
- Attributions missing — deduct 2-3 points
- Precision-uncertainty mismatch — rate as Developing

### Red Flags (Unsatisfactory Work)

Award 0-35% if:
- Conclusion missing or just one sentence
- No result stated
- No attribution whatsoever
- Callout boxes still present

### Feedback Suggestions

**If no reflection**: "Add a paragraph reflecting on what you learned from this project. What was surprising? What was harder than expected? How does `curve_fit` actually work — what is it doing? What would you do differently with more time? Genuine reflection on the process is an important part of scientific reporting."

**If no attribution**: "Please add an Attributions section at the end of your conclusion. List: (1) any classmates you worked with, (2) the dataset source, (3) any AI tools you used and for what purpose, (4) any other resources (websites, textbooks, etc.). This is standard scientific practice and part of academic integrity."

**If dataset not cited**: "I don't see a citation for your dataset anywhere in the report. Please add the source URL or reference. This is required for the work to be reproducible and is an academic integrity expectation."

---

# USAGE NOTES

This guidance file is designed for PH 280 Computational Physics projects. The system will:
1. Include all of "Part I: General Guidance" in every criterion evaluation
2. Extract the specific criterion section when evaluating that criterion
3. Combine general + specific guidance for focused, targeted feedback

Criterion sections are matched by exact name to the RUBRIC.md criterion titles.
