# Thermal threshold modeling in coastal bivalve abundance

This repository documents the analysis workflow for **Example 1** described in my cover letter:

> Thermal threshold modeling in coastal bivalve abundance from a Dutch tidal estuary.

The main goal is to combine long-term field survey data and temperature records to:

1. Derive an index of summer heatwave intensity from daily maximum temperatures.
2. Link this index to annual abundance of native and introduced bivalves.
3. Compare thermal responses between species and identify mortality-related thresholds.

Mesocosm experiments and their analysis will be added in a separate section.  
This first part of the repository focuses on the **field data analysis** only.

---

## Repository structure (field analysis)

```text
.
├─ README.md
├─ data/
│  ├─ field_abundance.csv          # long-term survey data for both species
│  ├─ daily_max_temperature.csv    # daily max temperature time series
│  └─ metadata_data_sources.md     # description of data origin & units
├─ R/
│  └─ field_thermal_thresholds.R   # main script for field analysis
├─ outputs/
│  ├─ figures/
│  │  ├─ fig_abundance_vs_temp_native.png
│  │  └─ fig_abundance_vs_temp_introduced.png
│  └─ tables/
│     ├─ model_summary_native.csv
│     └─ model_summary_introduced.csv
└─ LICENSE                         # optional
