# Spatial and Thermal-Stress Dynamics of Native and Introduced Bivalves in the Eastern Scheldt

This repository hosts the full analytical workflow used to explore the **spatial distribution**,  
**adult habitat intensity**, **temporal persistence**, **range centroid shifts**, and  
**temperature–abundance relationships** of two co-occurring bivalve species in the Eastern Scheldt, NL:

- **Native cockle** (*Cerastoderma edule*)  
- **Introduced Manila clam** (*Ruditapes philippinarum*)

The analyses complement and provide deeper spatial context to the findings published in:

> **Zhou et al. (2025)**  
> *Compound extreme events reshuffle the stacked odds in the gamble between native and introduced bivalves*  
> *Global Ecology and Conservation*  
> DOI: https://doi.org/10.1016/j.gecco.2025.e03918

The full workflow is implemented in:  
`run_all_bothSpecies.R`

---

# 📘 **Background**

Long-term benthic surveys have been conducted annually in the Eastern Scheldt since 1990  
(Troost et al. dataset, Rijkswaterstaat). Our analyses use the **2014–2021** period where:

- *Ruditapes philippinarum* (introduced) is present consistently (introduced prior to 2014).  
- Weather and temperature data from KNMI enable linking summer thermal extremes to next-year abundance.  
- 111 survey stations were selected where **adult individuals of both species co-occurred**,  
  reducing habitat-driven bias and providing a neutral baseline following **neutral theory**.

---

# 🐚 **Why Large Adults? Size & Age Class Logic**

To align with ecological inference and your mesocosm experiment, only **adult size classes** are analyzed.

### **Cerastoderma edule (cockle) — age classes**
Cockles grow annual rings; age is winter-defined:

| Class | Meaning |
|-------|---------|
| **1j** | one-year-old (juveniles) |
| **2j** | two-year-old |
| **mj** | more-than-two years old (mature adults) |
| **nb** | age not determined |
| *(0j rarely present; only 6 observations → merged into 1j)* |

We use **2j + mj** as "**large adults**" — individuals that survived ≥2 winters.

---

### **Ruditapes philippinarum (Manila clam) — size classes**
Clams were measured by shell length, but thresholds changed through time:

| Years | Small (“kln”) | Large (“grt”) |
|-------|----------------|----------------|
| **2014–2017** | <1.5 cm | >1.5 cm |
| **2018–2021** | <2.0 cm | >2.0 cm |

Size classes were inconsistently recorded:
- **2016**: no size classes recorded  
- **2014, 2017, 2019**: size classes partially recorded  

We use **“grt”** as the **large-adult class** across all years  
and exclude 2016 from size-based comparisons.

---

# 🗺️ **1. Spatial Distribution of Large Adults**

**Figure placeholder:**  
`![Abundance map](figures/abundance_bothSpecies_google_6classes.png)`

Large adults cluster in distinct regions of the estuary:

- *C. edule* forms broad intertidal distributions.  
- *R. philippinarum* forms strong, localized aggregations.  

Circle sizes reflect **six abundance classes**, enabling comparison of low to extremely high densities.

---

# 🌄 **2. Adult Habitat Intensity (KDE)**

**Figure placeholder:**  
`![Habitat intensity](figures/habitat_intensity_bothSpecies_google.png)`

Kernel-density fields identify **core adult habitats**, revealing:

- Multiple connected hotspots for the native cockle  
- Fragmented, isolated hotspots for the introduced clam  

These differences suggest contrasting habitat strategies between a long-term resident and a relatively recent invader.

---

# ⏳ **3. Temporal Persistence (2014–2022)**

**Figure placeholder:**  
`![Temporal persistence](figures/temporal_persistence_bothSpecies_google.png)`

Persistence = **number of years** large adults appear at a station (0–9 years).

Patterns:

- Native cockles show **high-persistence belts**, indicating stable multi-year survival.  
- Manila clams exhibit **shorter-term persistence**, consistent with spatially dynamic expansion after introduction.

---

# 🔄 **4. Range Centroid Shifts (Abundance-Weighted)**

**Figure placeholder:**  
`![Centroid shifts](figures/centroid_shift_clean_bothSpecies_globalScale_8classes.png)`

Annual **abundance-weighted centroids** illustrate spatial movement:

- **Native cockle:** oscillating centroid pattern, suggesting stable habitat use with year-to-year fluctuations.  
- **Manila clam:** a **clear southeastward drift**, consistent with expansion or thermal-niche tracking.  

Circle sizes use a shared **eight-class global scale** (0–25 → >5000 ind./m²/year).

---

# 🌡️ **5. Abundance Response to Summer Temperature Extremes**

**Figure placeholder:**  
`![TempSum regression](figures/twoSps_tempSum.png)`

Following **Zhou et al. (2025)** and **Troost et al. (2021)**, we quantify interannual thermal stress by summing:

\[
\sum (\mathrm{TX} - 23.7^\circ\mathrm{C})
\]

where 23.7 °C is the **90th percentile** of daily maximum temperature.

Because benthic surveys occur in spring (Apr–May),  
**summer heat load in year *t*** is matched to **adult abundance in year *t + 1***, capturing:

- Carry-over mortality (mass die-offs during extreme heatwaves)
- Recruitment failures
- Thermal filtering of adults and juveniles

### **Contrasting species responses:**

| Species | Slope | t-value | p-value |
|--------|-------|---------|---------|
| *C. edule* | **negative** | –1.07 | 0.332 |
| *R. philippinarum* | **positive** | 2.65 | 0.045 ✓ |

Interpretation:

- Native cockles show *no significant trend*, though high thermal-load years (e.g., 2018) correspond to well-documented **>90% mortality events** (Troost et al. 2021).
- The introduced Manila clam shows a **significant positive response**, indicating **greater resilience or opportunistic advantage** under thermal extremes.

This contrast aligns with results in Zhou et al. (2025):  
**compound heat events reshuffle competitive outcomes**, favoring the introduced species.

---

# 📦 **Reproducing the Workflow**

Run the full pipeline:

```r
source("run_all_bothSpecies.R")
```

This script produces:
	•	abundance_bothSpecies_google_6classes.png
	•	habitat_intensity_bothSpecies_google.png
	•	temporal_persistence_bothSpecies_google.png
	•	centroid_shift_clean_bothSpecies_globalScale_8classes.png
	•	twoSps_tempSum.png

#📘 **Citation**

If using this workflow, please cite:

Zhou et al. (2025).
Compound extreme events reshuffle the stacked odds in the gamble between native and introduced bivalves.
Global Ecology and Conservation.
DOI: https://doi.org/10.1016/j.gecco.2025.e03918

And acknowledge the long-term monitoring dataset curated by Troost et al. (Rijkswaterstaat / WMR).

#👋 **Contact**

For questions, data access, or collaboration inquiries, please contact the authors of the linked publication.
